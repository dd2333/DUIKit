//
//  DUITextField.h
//  knight
//
//  Created by dd2333 on 2019/6/10.
//  Copyright © 2019 dd2333. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DUITextField;

@protocol DUITextFieldDelegate <NSObject>

@optional

- (void)textFieldBecomeFirstResponder:(DUITextField*)textField;
- (void)textFieldResignFirstResponder:(DUITextField*)textField;

- (BOOL)textFieldShouldBeginEditing:(DUITextField*)textField;
- (BOOL)textFieldShouldEndEditing:(DUITextField*)textField;

@end

@interface DUITextField : NSTextField
    
@property (nonatomic, strong) NSColor *inputColor;

@property (nonatomic, assign) BOOL showLineView;
@property (nonatomic, strong) NSColor *lineHighlightColor;
@property (nonatomic, strong) NSColor *lineColor;
@property (nonatomic, strong) NSString *text;

@property (nonatomic, weak) id<DUITextFieldDelegate> dui_delegate;

@end
