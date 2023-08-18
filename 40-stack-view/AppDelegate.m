#import "AppDelegate.h"
#import "LogView.h"

@implementation AppDelegate {

  NSStackView *vbox;
  NSStackView *hbox;

  NSButton *button;
  LogView *logView;
}

- (void) makeWidgets {

  NSLog(@"makeWidgets");


  /* Button clearing the table.  */
  button = [NSButton new]; 
  [button setBordered: YES];
  [button setButtonType: NSMomentaryPushButton];
  [button setTitle:  @"Clear"];
  [button setImagePosition: NSNoImage]; 
  [button setTarget: self];
  [button setAction: @selector(doClearLog:)];
  [button setAutoresizingMask: NSViewMaxXMargin];
  [button sizeToFit];
  [button setTag: 1];

  hbox = [NSStackView new];
  [hbox addView: button inGravity:NSStackViewGravityTop];
  // [hbox setAutoresizingMask: NSViewWidthSizable];

  vbox = [NSStackView new];
 
  // Size the textview and scrollview, knowing the sizes will be computed
  logView = [LogView new];
  [logView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];

  [logView sizeToFit];

  [vbox addView: hbox inGravity:NSStackViewGravityTop];
  [vbox addView: logView inGravity:NSStackViewGravityTop];
}
  
- (void) doClearLog:(NSControl*)sender {

  // perform on GUI queue
  dispatch_async(dispatch_get_main_queue(), ^{
      [logView clearLog];
    });
}

- (void) makeWindow {

  NSRect frame;
  frame.size = [vbox frame].size;
  frame.origin = NSMakePoint (300, 400);

  self.win = [[NSWindow alloc]
		      initWithContentRect: frame
				styleMask: (NSWindowStyleMaskTitled
					    | NSWindowStyleMaskClosable
					    | NSWindowStyleMaskResizable
					    | NSWindowStyleMaskMiniaturizable)
				  backing:NSBackingStoreBuffered
				    defer:NO];

  [self.win setTitle: @"Manual-layout"];
  // [self.win setReleasedWhenClosed: NO]; // ??

  [self.win setContentView: vbox];
  [self.win setMinSize: [NSWindow frameRectForContentRect: frame
						styleMask: [self.win styleMask]].size];

  [self.win makeKeyAndOrderFront:self];
  [self.win orderFrontRegardless];

}

- (void) makeMenu {

  self.menuBar = [NSMenu new];
  NSMenu *appMenu = [NSMenu new];
  NSMenuItem *appMenuItem = [[NSMenuItem alloc] init];
  appMenuItem.title = @"File";

  NSMenuItem *quitMenuItem = [[NSMenuItem alloc]
			       initWithTitle:@"Quit"
				      action:@selector(terminate:)
			       keyEquivalent:@"q"];

  [self.menuBar addItem:appMenuItem];
  [appMenu addItem:quitMenuItem];
  [appMenuItem setSubmenu:appMenu];

  [NSApp setMainMenu:self.menuBar];
}

- (void) applicationDidFinishLaunching: (NSNotification *) aNotification
{
  [self makeMenu];
  [self makeWidgets];
  [self makeWindow];

  /*
   * Send messages to the log window from another queue
   */
  dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,
						   0, 0, dispatch_get_global_queue(0,0));
  if (timer) {
    double popTime = 1.0 * NSEC_PER_SEC;
    double leeway = 0.1 * NSEC_PER_SEC;

    __block int counter = 0;
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), popTime, leeway);
    dispatch_source_set_event_handler(timer, ^{

	// perform GUI op on main queue
	dispatch_async(dispatch_get_main_queue(), ^{
	    NSString *msg = [NSString stringWithFormat:@"Message in a bottle number %d", counter++];
	    [logView appendLog:msg];
	  });
      });
    dispatch_resume(timer);
  }
  

}

@end
