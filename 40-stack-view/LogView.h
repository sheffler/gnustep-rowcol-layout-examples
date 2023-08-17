/*
 * A widget that has a text area for logs and a button to clear it.
 */

#import <AppKit/AppKit.h>

@interface LogView : NSView

- (void) sizeToFit;
- (void) appendLog:(NSString*)message;
- (void) clearLog;

@end

