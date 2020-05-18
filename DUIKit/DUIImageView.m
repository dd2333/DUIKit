//
//  DUIImageView.m
//  knight
//
//  Created by dd2333 on 2019/6/10.
//  Copyright © 2019 dd2333. All rights reserved.
//

#import "DUIImageView.h"

@interface DUIImageView()
    
@property (nonatomic, strong) NSImage *normalImage;
    
@end

@implementation DUIImageView

- (void)setSelected:(BOOL)selected{
    if (selected) {
        self.normalImage = self.image;
        self.image = self.selectedImage;
    }else{
        self.image = self.normalImage;
    }
    _selected = selected;
}

-(void)setBackgroundColor:(NSColor *)backgroundColor{
    [self setWantsLayer:YES];
    [self.layer setBackgroundColor:backgroundColor.CGColor];
    [self setNeedsDisplay:YES];
}

-(void)setBorderColor:(NSColor *)borderColor{
    [self setWantsLayer:YES];
    [self.layer setBorderColor:borderColor.CGColor];
    [self setNeedsDisplay:YES];
}

-(void)setBorderWidth:(CGFloat)borderWidth{
    [self setWantsLayer:YES];
    [self.layer setBorderWidth:borderWidth];
    [self setNeedsDisplay:YES];
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    [self setWantsLayer:YES];
    [self.layer setCornerRadius:cornerRadius];
    [self setNeedsDisplay:YES];
}

- (void)setAlpha:(CGFloat)alpha{
    [[self layer] setOpacity:alpha];
    [self setNeedsDisplay:YES];
}


@end
