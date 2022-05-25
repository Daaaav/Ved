#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

#if __has_feature(objc_arc)
#error ARC is enabled, it probably shouldn't be
#endif

/*
 * Sets an error out parameter to the specified message except when NULL was passed.
 */
static void set_error(const char** out_err, const char* message)
{
	if (out_err != NULL)
	{
		*out_err = message;
	}
}

/*
 * Gets the path to the currently-running VVVVVV executable.
 * If one (1) running VVVVVV is found, buffer contains the path to the
 * executable, and the function returns true.
 * A false return value indicates error or ambiguity.
 * You may pass NULL for errkey. errkey is meaningless upon success.
 */
bool ved_find_vvvvvv_exe_macos(char* buffer, size_t buffer_size, const char** errkey)
{
	bool success = false;

	@autoreleasepool
	{
		NSArray* running_v6s = [NSRunningApplication runningApplicationsWithBundleIdentifier:@"com.distractionware.VVVVVV"];

		/* Default for !success: we simply didn't find it */
		set_error(errkey, "FIND_V_EXE_NOTFOUND");

		NSMutableString* result_path = [NSMutableString stringWithCapacity:buffer_size];
		unsigned n_processes = 0;
		for (NSRunningApplication* app in running_v6s)
		{
			NSString* exe = [[app executableURL] path];

			if (exe == nil)
			{
				/* Okay, maybe *this* VVVVVV has a nil executable path...
				 * Maybe there's still another where it doesn't fail.
				 * Either way it's no longer a "not found". */
				set_error(errkey, "FIND_V_EXE_FOUNDERROR");
				continue;
			}

			if ([exe hasSuffix:@".osx"])
			{
				/* 2.2 had this suffix.
				 * Btw, apparently the bundle identifier for 2.0 is all-lowercase. */
				set_error(errkey, "FIND_V_EXE_FOUNDERROR");
				continue;
			}

			n_processes++;

			/* If multiple VVVVVVs are running, we'll allow it if the executable is the same */
			if (n_processes > 1 && ![exe isEqualToString:result_path])
			{
				set_error(errkey, "FIND_V_EXE_MULTI");
				success = false;
				break;
			}

			[result_path setString:exe];

			success = true;
		}

		if (success)
		{
			[result_path getCString:buffer maxLength:buffer_size encoding:NSUTF8StringEncoding];
		}
	}

	return success;
}
