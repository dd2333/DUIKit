//
//  DUITextField.m
//  knight
//
//  Created by dd2333 on 2019/6/10.
//  Copyright © 2019 dd2333. All rights reserved.
//

#import "DUITextField.h"
#import "DUITextFieldCell.h"

@interface DUITextField () <DUITextFieldCellDelegate>

@property (nonatomic, strong) DUIView *lineView;
@property (nonatomic, assign) double xInterval;

@end

@implementation DUITextField
    
- (instancetype)init{
    self = [super init];
    if (self) {
        self.bordered = NO;
        self.focusRingType = NSFocusRingTypeNone;
        self.backgroundColor = [NSColor clearColor];
        self.maximumNumberOfLines = 1;
        self.textColor = [NSColor whiteColor];
        self.inputColor = RGBA(255, 255, 255, 0.7);
        [(DUITextFieldCell*)self.cell setDui_delegate:self];
    }
    
    return self;
}

- (BOOL)becomeFirstResponder {
    BOOL success = [super becomeFirstResponder];
    if(success) {
        NSTextView * textView = (NSTextView *)[self currentEditor];
        if([textView respondsToSelector:@selector(setInsertionPointColor:)]) {
            [textView setInsertionPointColor:self.inputColor];
        }
    }
    _xInterval = [[NSDate date] timeIntervalSince1970];
    if (self.showLineView && self.lineHighlightColor) {
        [self.lineView setBackgroundColor:self.lineHighlightColor];
    }
    if ([_dui_delegate respondsToSelector:@selector(textFieldBecomeFirstResponder:)]) {
        [_dui_delegate textFieldBecomeFirstResponder:self];
    }
    return success;
}

- (void)textFieldEndEditing:(DUITextFieldCell *)textField{
    //Fix:由于某些问题引起的错误调用
    if ([[NSDate date] timeIntervalSince1970] - _xInterval > 0.01) {
        if (self.showLineView && self.lineHighlightColor) {
            [self.lineView setBackgroundColor:self.lineColor];
        }
        if ([_dui_delegate respondsToSelector:@selector(textFieldResignFirstResponder:)]) {
            [_dui_delegate textFieldResignFirstResponder:self];
        }
    }
}

- (BOOL)performKeyEquivalent:(NSEvent *)event
{
    if (([event modifierFlags] & NSDeviceIndependentModifierFlagsMask) == NSCommandKeyMask) {
        // The command key is the ONLY modifier key being pressed.
        if ([[event charactersIgnoringModifiers] isEqualToString:@"x"]) {
            return [NSApp sendAction:@selector(cut:) to:[[self window] firstResponder] from:self];
        } else if ([[event charactersIgnoringModifiers] isEqualToString:@"c"]) {
            return [NSApp sendAction:@selector(copy:) to:[[self window] firstResponder] from:self];
        } else if ([[event charactersIgnoringModifiers] isEqualToString:@"v"]) {
            return [NSApp sendAction:@selector(paste:) to:[[self window] firstResponder] from:self];
        } else if ([[event charactersIgnoringModifiers] isEqualToString:@"a"]) {
            return [NSApp sendAction:@selector(selectAll:) to:[[self window] firstResponder] from:self];
        } else if ([[event charactersIgnoringModifiers] isEqualToString:@"z"]) {
            return [NSApp sendAction:@selector(keyDown:) to:[[self window] firstResponder] from:self];
        }
    }
    return [super performKeyEquivalent:event];
}
    
+ (Class)cellClass{
    return DUITextFieldCell.class;
}

- (BOOL)textShouldBeginEditing:(NSText *)textObject{
    if ([_dui_delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [_dui_delegate textFieldShouldBeginEditing:self];
    }
    return YES;
}

- (BOOL)textShouldEndEditing:(NSText *)textObject{
    if ([_dui_delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [_dui_delegate textFieldShouldEndEditing:self];
    }
    return YES;
}

- (void)setText:(NSString *)text{
    if (text) {
        self.stringValue = text;
    }
}
    
- (NSString *)text{
    return self.stringValue;
}

- (void)setShowLineView:(BOOL)showLineView{
    _showLineView = showLineView;
    if (_showLineView) {
        [self.lineView setBackgroundColor:self.lineColor];
        [self addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(2);
        }];
    }else{
        [self.lineView removeFromSuperview];
    }
}

- (void)setLineColor:(NSColor *)lineColor{
    _lineColor = lineColor;
    [self.lineView setBackgroundColor:self.lineColor];
}

- (DUIView *)lineView{
    if (!_lineView) {
        _lineView = [[DUIView alloc] init];
    }
    return _lineView;
}
@end
