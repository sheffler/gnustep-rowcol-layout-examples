@interface GSVbox : NSView

- (void) setAutoresizingMask: (NSUInteger)mask;
- (void) setBorder: (float)aBorder;
- (void) setDefaultMinYMargin: (float)aMargin;
- (void) addView:(NSView*)view;
- (void) addView:(NSView*)view enablingYResizing:(BOOL)aFlag;
@end

@interface GSHbox : NSView

- (void) setAutoresizingMask: (NSUInteger)mask;
- (void) setBorder: (float)aBorder;
- (void) setDefaultMinXMargin: (float)aMargin;
- (void) addView:(NSView*)view;

@end
