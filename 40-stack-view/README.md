# Use of NSStackView

In this example, we would like to replace `GSHbox` and `GSVbox` with an `NSStackView`.  We want to programmatically construct all widgets and layout.

The code compiles fine, but upon startup there is an exception.  (traced to the `[NSStackView new]` line).

We have not found the correct way to use an NSStackView or a workaround.


```
$ openapp ./stack-view.app/
2023-08-17 09:21:59.191 stack-view[355312:355312] makeWidgets
2023-08-17 09:21:59.198 stack-view[355312:355312] Problem posting <GSNotification: 0x5626b2cc44d8> Name: NSApplicationDidFinishLaunchingNotification Object: <NSApplication: 0x5626b2a12538> Info: (null): <NSException: 0x5626b31fd728> NAME:NSRangeException REASON:Index 0 is out of range 0 (in 'objectAtIndex:') INFO:{Array = (); Count = 0; Index = 0; }

```
