//
//  DUITextFieldCell.m
//  knight
//
//  Created by dd2333 on 2019/6/10.
//  Copyright © 2019 dd2333. All rights reserved.
//

#import "DUITextFieldCell.h"

@implementation DUITextFieldCell

- (NSRect)adjustedFrameToVerticallyCenterText:(NSRect)frame{
    // super would normally draw text at the top of the cell
    NSInteger offset = floor((NSHeight(frame)/2 - ([[self font] ascender] + [[self font] descender])));
    return NSInsetRect(frame, 0.0, offset);
}

- (void)editWithFrame:(NSRect)aRect inView:(NSView *)controlView editor:(NSText *)editor delegate:(id)delegate event:(NSEvent *)event{
    [super editWithFrame:[self adjustedFrameToVerticallyCenterText:aRect] inView:controlView editor:editor delegate:delegate event:event];
}

- (void)selectWithFrame:(NSRect)aRect inView:(NSView *)controlView editor:(NSText *)editor delegate:(id)delegate start:(NSInteger)start length:(NSInteger)length{
    [super selectWithFrame:[self adjustedFrameToVerticallyCenterText:aRect] inView:controlView editor:editor delegate:delegate start:start length:length];
}

- (void)drawInteriorWithFrame:(NSRect)frame inView:(NSView *)view{
    [super drawInteriorWithFrame:
    [self adjustedFrameToVerticallyCenterText:frame] inView:view];
}

- (void)endEditing:(NSText *)textObj{
    [super endEditing:textObj];
    [self.dui_delegate textFieldEndEditing:self];
}
@end

