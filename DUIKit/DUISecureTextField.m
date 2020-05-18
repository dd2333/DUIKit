//
//  DUISecureTextField.m
//  knight
//
//  Created by dd2333 on 2019/6/10.
//  Copyright © 2019 dd2333. All rights reserved.
//

#import "DUISecureTextField.h"
#import "DUISecureTextFieldCell.h"

@interface DUISecureTextField () <DUISecureTextFieldCellDelegate>

@property (nonatomic, assign) double xInterval;

@end

@implementation DUISecureTextField

- (instancetype)init{
    self = [super init];
    if (self) {
        self.bordered = NO;
        self.focusRingType = NSFocusRingTypeNone;
        self.backgroundColor = [NSColor clearColor];
        self.maximumNumberOfLines = 1;
        self.textColor = [NSColor whiteColor];
        self.inputColor = RGBA(255, 255, 255, 0.7);
        [(DUISecureTextFieldCell*)self.cell setDui_delegate:self];
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
    if ([_dui_delegate respondsToSelector:@selector(textFieldBecomeFirstResponder:)]) {
        [_dui_delegate textFieldBecomeFirstResponder:self];
    }
    return success;
}

- (void)textFieldEndEditing:(DUISecureTextFieldCell *)textField{
    //Fix:由于某些问题引起的错误调用
    if ([[NSDate date] timeIntervalSince1970] - _xInterval > 0.01) {
        if ([_dui_delegate respondsToSelector:@selector(textFieldResignFirstResponder:)]) {
            [_dui_delegate textFieldResignFirstResponder:self];
        }
    }
}

+ (Class)cellClass{
    return DUISecureTextFieldCell.class;
}

- (BOOL)textShouldBeginEditing:(NSText *)textObject{
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

@end
