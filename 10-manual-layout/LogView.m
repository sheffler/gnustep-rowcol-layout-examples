/*
 * A View for holding a textfield "log" view area, a text field for capturing
 * input to "send" to the log, and a button to press to cause the new message
 * to be added to the log.
 */

#import "LogView.h"

@interface LogView()

@property (nonatomic, retain, strong) NSButton *but;
@property (nonatomic, retain, strong) NSTextField *textfield;
@property (nonatomic, retain, strong) NSTextView *textview;
@property (nonatomic, retain, strong) NSScrollView *scrollview;

@end


@implementation LogView {
  NSSize butSize;
}

- (id) init {
  if (self = [super init]) {

    _but = [NSButton new];
    _but.title = @"Send";
    _but.target = self;
    _but.action = @selector(butPressed:);

    // record the natural size of the button
    [_but sizeToFit];
    butSize = _but.frame.size;

    _textfield = [NSTextField new];

    // Size the textview and scrollview, knowing the sizes will be computed
    _textview = [NSTextView new];

    _scrollview = [NSScrollView new];
    [_scrollview setHasVerticalScroller:YES];
    [_scrollview setDocumentView:_textview];

    [self addSubview:_but];
    [self addSubview:_textfield];
    [self addSubview:_scrollview];

  }
  return self;
}

- (void) butPressed:(NSControl*)sender {
  NSString *text = _textfield.stringValue;
  [self appendLog:text];
}

- (void) appendLog:(NSString*)message {

  NSString *messageWithNewLine = [message stringByAppendingString:@"\n"];

  // determine if the view should scroll - it should if at bottom
  BOOL scroll = (NSMaxY(self.textview.visibleRect) == NSMaxY(self.textview.bounds));

  // Append string to textview
  [self.textview.textStorage appendAttributedString:[[NSAttributedString alloc]initWithString:messageWithNewLine]];

  // unconditionally make visible the very end
  if (scroll)
    [self.textview scrollRangeToVisible: NSMakeRange(self.textview.string.length, 0)];
}

- (void) clearLog {
  NSString *news = @"";
  NSString *olds = _textview.textStorage.string;
  NSRange allChars = NSMakeRange(0, [olds length]);

  [_textview.textStorage replaceCharactersInRange:allChars
				       withString:news];
}


/* 
 * Overriding this to resize the view when the window is resized.
 * Explicitly calculates the new frames of the elements when
 * the window is resized.
 */

-(void) resizeSubviewsWithOldSize:(NSSize)oldSize {
  [super resizeSubviewsWithOldSize:oldSize];

  double wd = self.bounds.size.width;
  double ht = self.bounds.size.height;

  double bwd = butSize.width;
  double bht = butSize.height;

  // place button and textfield based on button natural size
  _but.frame = NSMakeRect(5, ht-bht-5, bwd, bht);
  _textfield.frame = NSMakeRect(bwd+5+5, ht-bht-5, wd-bwd-15, bht);

  // set scrollview to rest of the area
  _scrollview.frame = NSMakeRect(5, 5, wd-10, ht-bht-15);

  // compute desired content size based on scrollsize
  NSSize contentSize = [NSScrollView contentSizeForFrameSize: _scrollview.frame.size
				       hasHorizontalScroller: YES
					 hasVerticalScroller: NO
						  borderType: _scrollview.borderType];
  _textview.frame = NSMakeRect(0, 0, contentSize.width, contentSize.height);
}
@end
