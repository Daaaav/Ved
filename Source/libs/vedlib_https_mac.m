#import <Foundation/Foundation.h>

#if __has_feature(objc_arc)
#error ARC is enabled, it probably shouldn't be
#endif


typedef struct _https_status
{
	int64_t progress_dlnow;
	int64_t progress_dltotal;

	bool done;
	bool final_success;
	unsigned long final_dltotal;
} https_status;


// I could have used a completion handler instead of a delegate of course, but I want progress updates
@interface VedHTTPSDelegate : NSObject <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>
{
	NSMutableData* response;
	BOOL done;
	BOOL success;
	dispatch_semaphore_t sem;
	int64_t progress_dlnow;
	int64_t progress_dltotal;
}
@end

@implementation VedHTTPSDelegate
- (instancetype) initWithSemaphore:(dispatch_semaphore_t)s expectedResponseLength:(unsigned long)len
{
	self = [super init];
	if (self)
	{
		response = [[NSMutableData alloc] initWithCapacity:len]; // capacity is not final
		done = NO;
		success = NO;
		sem = s;
		progress_dlnow = 0;
		progress_dltotal = 0;
	}
	return self;
}

- (void) dealloc
{
	[response release];
	[super dealloc];
}

- (void) doneSuccessfully:(BOOL)suc
{
	done = YES;
	success = suc;
	dispatch_semaphore_signal(sem);
}

- (void) URLSession:(NSURLSession*)session didBecomeInvalidWithError:(NSError*)error
{
	if (!done)
	{
		[self doneSuccessfully:NO];
	}
}

- (void) URLSession:(NSURLSession*)session task:(NSURLSessionTask*)task didCompleteWithError:(NSError*)error
{
	[self doneSuccessfully:(error == NULL)];
	[session invalidateAndCancel];
}

- (void) URLSession:(NSURLSession*)session
	dataTask:(NSURLSessionDataTask*)dataTask
	didReceiveResponse:(NSURLResponse*)baseResponse
	completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))handler
{
	NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)baseResponse;
	if ([httpResponse statusCode] >= 400)
	{
		handler(NSURLSessionResponseCancel);
		return;
	}

	handler(NSURLSessionResponseAllow);
}

- (void) URLSession:(NSURLSession*)session dataTask:(NSURLSessionDataTask*)dataTask didReceiveData:(NSData*)data
{
	[response appendData:data];

	progress_dlnow = [dataTask countOfBytesReceived];
	progress_dltotal = [dataTask countOfBytesExpectedToReceive];
	if (progress_dltotal == NSURLSessionTransferSizeUnknown)
	{
		progress_dltotal = 0;
	}
}

- (dispatch_semaphore_t) getSemaphore
{
	return sem;
}

- (void) getStatus:(https_status*)status
{
	status->progress_dlnow = progress_dlnow;
	status->progress_dltotal = progress_dltotal;
	status->done = done;
	if (done)
	{
		status->final_success = success;
		status->final_dltotal = [response length];
	}
}

- (const void*) getResponseData
{
	return [response bytes];
}
@end


VedHTTPSDelegate* ved_delegate;

void https_start_request(const char* cstr_url, unsigned long expected_length)
{
	@autoreleasepool
	{
		NSURL* url = [NSURL URLWithString:[NSString stringWithUTF8String:cstr_url]];

		NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
		config.HTTPAdditionalHeaders = @{@"User-Agent": @"Ved/NSURLSession"};
		config.HTTPShouldSetCookies = NO;

		dispatch_semaphore_t sem = dispatch_semaphore_create(0);

		if (expected_length == 0)
		{
			expected_length = 16384;
		}

		ved_delegate = [[VedHTTPSDelegate alloc] initWithSemaphore:sem expectedResponseLength:expected_length];

		NSURLSession* session = [NSURLSession sessionWithConfiguration:config delegate:ved_delegate delegateQueue:nil];

		NSURLSessionTask* task = [session dataTaskWithURL:url];
		[task resume];
	}
}

bool https_request_await(https_status* status)
{
	/* Call this repeatedly, while it returns true.
	 * The semaphore call can either return because it was signaled,
	 * or after a 50ms timeout. */
	dispatch_semaphore_wait(
		[ved_delegate getSemaphore],
		dispatch_time(DISPATCH_TIME_NOW, 50*NSEC_PER_MSEC)
	);

	[ved_delegate getStatus:status];

	return !status->done;
}

const void* https_get_response_data(void)
{
	return [ved_delegate getResponseData];
}

void https_free_request(void)
{
	[ved_delegate release];
}
