//
//  DUIButton.h
//  knight
//
//  Created by dd2333 on 2019/6/10.
//  Copyright © 2019 dd2333. All rights reserved.
//

#import "DUIView.h"

@class DUIButton,DUILabel,DUIImageView;

typedef void (^DUIButtonClickCompletion) (DUIButton *button);

@interface DUIButton : DUIView
    
@property (strong, nonatomic) DUILabel *titleLabel;
@property (strong, nonatomic) DUIImageView *imageView;

@property (strong, nonatomic) NSImage *normalButtonImage;
@property (strong, nonatomic) NSImage *highlightButtonImage;
@property (strong, nonatomic) NSImage *selectedButtonImage;
@property (strong, nonatomic) NSImage *disableButtonImage;
@property (strong, nonatomic) NSImage *hoverButtonImage;
    
@property (strong, nonatomic) NSString *normalButtonString;
@property (strong, nonatomic) NSString *highlightButtonString;
@property (strong, nonatomic) NSString *selectedButtonString;
@property (strong, nonatomic) NSString *disableButtonString;
@property (strong, nonatomic) NSString *hoverButtonString;

@property (strong, nonatomic) NSColor *normalButtonStringColor;
@property (strong, nonatomic) NSColor *highlightButtonStringColor;
@property (strong, nonatomic) NSColor *selectedButtonStringColor;
@property (strong, nonatomic) NSColor *disableButtonStringColor;
@property (strong, nonatomic) NSColor *hoverButtonStringColor;
    
@property (copy, nonatomic) DUIButtonClickCompletion completion;
    
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL disabled;

@property (nonatomic, assign) BOOL enableKeyEquivalent;

- (void)performHandle;

@end
