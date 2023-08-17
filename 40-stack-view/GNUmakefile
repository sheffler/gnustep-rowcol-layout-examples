#
# GS Gui Test Number 1
#

include $(GNUSTEP_MAKEFILES)/common.make

APP_NAME = \
  stack-view

################################################################
# ObjC files

stack-view_OBJC_FILES = \
  LogView.m \
  AppDelegate.m \
  main.m

################################################################
# Resource Files

stack-view_RESOURCE_FILES = 


ADDITIONAL_OBJCFLAGS = -Wall -Wno-import -fblocks -fobjc-arc
ADDITIONAL_LDFLAGS = -ldispatch

-include GNUmakefile.preamble
include $(GNUSTEP_MAKEFILES)/application.make
-include GNUmakefile.postamble
