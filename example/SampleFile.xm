#import "SampleImport.h"
// This file is a simple example of CustomPreprocessor in action.

@interface SampleContentView : UIView 
@end

%hook SampleContentView 
    -(void)layoutSubviews { 
        %orig; 
        self.backgroundColor = [UIColor blackColor]; 
    } 
%end

@interface SampleBackgroundView : UIView 
@end

%hook SampleBackgroundView 
    -(void)layoutSubviews { 
        %orig; 
        self.backgroundColor = [UIColor grayColor]; 
    } 
%end

@interface SampleLabel : UILabel 
@end

%hook SampleLabel 
    -(void)layoutSubviews { 
        %orig;
    self.backgroundColor = [UIColor clearColor];

    } 
%end
