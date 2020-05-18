//
//  DUIImageView.h
//  knight
//
//  Created by dd2333 on 2019/6/10.
//  Copyright © 2019 dd2333. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DUIImageView : NSImageView
    
@property (nonatomic, strong) NSImage *selectedImage;
@property (nonatomic, assign) BOOL selected;

@property (nonatomic, strong) NSColor *backgroundColor;
@property (nonatomic, strong) NSColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat alpha;

@end
