#import "SampleImport.h"

// This file is a simple example of CustomPreprocessor in action.

$def pp_class(a, b): \
@interface !a : !b \
@end

$def pp_classView(a): $use pp_class(!a, UIView)

$def pp_openHook(a): \
%hook !a \
    -(void)layoutSubviews { \
        %orig;

$def pp_closeHook(): \
    } \
%end

$def pp_hookViewColor(a, b): \
%hook !a \
    -(void)layoutSubviews { \
        %orig; \
        self.backgroundColor = [UIColor !b]; \
    } \
%end

$def pp_hookView(a): $use pp_hookViewColor(!a, blackColor)


$use pp_classView(SampleContentView)
$use pp_hookView(SampleContentView)

$use pp_classView(SampleBackgroundView)
$use pp_hookViewColor(SampleBackgroundView, grayColor)

$use pp_class(SampleLabel, UILabel)
$use pp_openHook(SampleLabel)
    self.backgroundColor = [UIColor clearColor];
$use pp_closeHook()
