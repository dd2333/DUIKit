//
//  DUISecureTextField.h
//  knight
//
//  Created by dd2333 on 2019/6/10.
//  Copyright © 2019 dd2333. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DUISecureTextField;

@protocol DUISecureTextFieldDelegate <NSObject>

@optional

- (void)textFieldBecomeFirstResponder:(DUISecureTextField*)textField;
- (void)textFieldResignFirstResponder:(DUISecureTextField*)textField;

- (BOOL)textFieldShouldStartEditing:(DUISecureTextField*)textField;
- (BOOL)textFieldShouldEndEditing:(DUISecureTextField*)textField;

@end

@interface DUISecureTextField : NSSecureTextField

@property (nonatomic, strong) NSColor *inputColor;
@property (nonatomic, strong) NSString *text;

@property (nonatomic, weak) id<DUISecureTextFieldDelegate> dui_delegate;

@end
