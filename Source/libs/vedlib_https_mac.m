#import <Foundation/Foundation.h>

#if __has_feature(objc_arc)
#error ARC is enabled, it probably shouldn't be
#endif

// I could have used a completion handler instead of a delegate of course, but I want progress updates later
@interface VedHTTPSDelegate : NSObject <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>
{
	NSMutableData* response;
	BOOL done;
	BOOL success;
	dispatch_semaphore_t sem;
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

- (void) URLSession:(NSURLSession*)session dataTask:(NSURLSessionDataTask*)dataTask didReceiveData:(NSData*)data
{
	[response appendData:data];
}

- (bool) getSuccess
{
	return success;
}

- (unsigned long) getResponseLength
{
	return [response length];
}

- (const void*) getResponseData
{
	return [response bytes];
}
@end

VedHTTPSDelegate* ved_delegate;

bool https_start_request(const char* cstr_url, unsigned long expected_length)
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

		dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);

		return [ved_delegate getSuccess];
	}
}

unsigned long https_get_response_length(void)
{
	return [ved_delegate getResponseLength];
}

const void* https_get_response_data(void)
{
	return [ved_delegate getResponseData];
}

void https_free_request(void)
{
	[ved_delegate release];
}
