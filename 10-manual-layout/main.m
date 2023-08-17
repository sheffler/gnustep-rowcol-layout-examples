#import <AppKit/AppKit.h>
#import "AppDelegate.h"
#include <dispatch/dispatch.h>

int main(int argc, char *argv[])
{

  @autoreleasepool
    {
      [NSApplication sharedApplication];

      AppDelegate *delegate = [AppDelegate new];
      [NSApp setDelegate:delegate];

      dispatch_async(
		     dispatch_get_main_queue(),
		     ^{
		       [NSApp activateIgnoringOtherApps:YES];
		     });

      [NSApp run];
    }

  return 0;
}
