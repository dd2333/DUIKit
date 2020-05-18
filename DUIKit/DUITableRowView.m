//
//  DUITableRowView.m
//  knight
//
//  Created by dd2333 on 2019/6/10.
//  Copyright © 2019 dd2333. All rights reserved.
//

#import "DUITableRowView.h"


@implementation DUITableRowView
    
- (instancetype)init{
    self = [super init];
    if (self) {
        _bgColor = RGBA(120, 120, 120, 0.3);
        _cornerRadius = 10;
        _widthPadding = 5;
        _heightPadding = 0;
    }
    return self;
}
    
- (void)drawRect:(NSRect)dirtyRect {
    if (self.selectionHighlightStyle != NSTableViewSelectionHighlightStyleNone) {
        if (self.selected) {
            NSRect selectionRect = NSInsetRect(self.bounds, _widthPadding, _heightPadding);
            [_bgColor setFill];
            NSBezierPath *selectionPath = [NSBezierPath bezierPathWithRoundedRect:selectionRect xRadius:_cornerRadius yRadius:_cornerRadius];
            [selectionPath fill];
        }
    }
}
    
@end
