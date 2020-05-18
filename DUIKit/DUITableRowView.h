//
//  DUITableRowView.h
//  knight
//
//  Created by dd2333 on 2019/6/10.
//  Copyright © 2019 dd2333. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DUITableRowView : NSTableRowView

@property (nonatomic, strong) NSColor *bgColor;
@property (nonatomic, assign) float cornerRadius;
@property (nonatomic, assign) float widthPadding;
@property (nonatomic, assign) float heightPadding;

@end
