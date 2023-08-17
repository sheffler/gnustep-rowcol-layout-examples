
Begun 2023-08-12

Yesterday, I learned how to override resizeSubviewsWithOldSize: to manually
layout elements.  Today, I will try to make a little app with widgets.

   |---[button]----[textfield   ]--|
   |---[ textview area scroll   ]--|

The textview should grow in height as the window is resized.


- this is getting there.  the button and text field are working.
- the textfield is not quite what I want.  It does not scroll
  like a text view

SUCCESS

- this is mostly kinda working.  There are the widgets, the window resizes
  and the scrollview moves to the bottom.  The Textview is actually a little
  editor and the scroll is windowing into it.  Wow.

*** Smart Scrolling ***

Got a little lost here.  It seems that you might not want to scroll if
the insertion point is not visible before inserting the text.  Maybe
that's what this was computing.  Maybe not.

  // Smart Scrolling - I don't see what is *smart* about this
  // Ref: https://stackoverflow.com/questions/15546808/scrolling-nstextview-to-bottom
  NSLog(@"visibleRect:%@", NSStringFromRect(self.textview.visibleRect));
  NSLog(@"bounds:%@", NSStringFromRect(self.textview.bounds));

  BOOL scroll = (NSMaxY(self.textview.visibleRect) == NSMaxY(self.textview.bounds));

- NSScrolView has this
    // [self.scrollview scrollToEndOfDocument:self];
  but it does not give the same effect.  It seems to scroll to n-1 lines

  The computation in the link above goes all the way
  to the end and keeps scrolling upon insertion if that is where it is.
  It behaves the way I want for a realtime insertion, where you can
  stop the visual scrolling by going to the middle.
  
