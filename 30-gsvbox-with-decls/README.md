# GSVbox and GSHbox with local "fake" declarations

In this example, the log view with an attached "Send" button and text area is arranged with an additional button to clear the text view.  The "Clear" button exists in its own GSHbox, and this new HBox is combined with the LogView in a GSVbox.

We desire to compile our application with `-fobjc-arc` and the workaround for using the GSHbox and GSVbox is to provide an interface that completely hides the implementation, but provides the method signatures necessary for compilation.

This all works well.

![original layout](gsvbox-with-decls-pic1.pnd)

After resizing the window and typing some messages into the text area and pressing the "Send" button, the new layout looks like this.

![resized layout](gsvbox-with-decls-pic2.pnd)



