//
//  DUISecureTextFieldCell.h
//  knight
//
//  Created by dd2333 on 2019/6/10.
//  Copyright © 2019 dd2333. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DUISecureTextFieldCell;

@protocol DUISecureTextFieldCellDelegate <NSObject>

- (void)textFieldEndEditing:(DUISecureTextFieldCell*)textField;

@end

@interface DUISecureTextFieldCell : NSSecureTextFieldCell

@property(nonatomic, weak) id<DUISecureTextFieldCellDelegate> dui_delegate;

@end
