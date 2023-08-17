# GSVbox, GSHbox and GSTable have a compile time error

In this example, the desired layout is as shown in [../30-gsvbox-with-decls](../30-gsvbox-with-decls), but there is a compile time error when these files are compiled with `-fobjc-arc`.

The error is reproduced below.

```
/usr/GNUstep/Local/Library/Headers/GNUstepGUI/GSTable.h:188:11: error: pointer to non-const type 'NSView *' with no explicit ownership
  NSView **_jails;
```

The reason is that the inclusion of "GSVbox.H" also includes "GSTable.h", and the header exposes the instance variable `_jails`, which probably could be kept private.

One way to get this code to compile is to provide an alternative "GSTable.h" that modifies the line like this.

```
  NSView * __autoreleasing *_jails;
```

This makes our `AppDelegate.m` compile, but `GSTable.m` itself is not compiled with ARC so there is a contradiction.

One workaround is to make a local copy of `GSTable.h` with the modified declaration that is included by `AppDelegate.m`.  But this seems wrong.

The solution in [../30-gsvbox-with-decls](../30-gsvbox-with-decls) creates local declarations of `GSVbox` and `GSHbox` that don't include `GSTable.h` and don't expose instance variables ... since our code doesn't need to know.
