//
//  DUITextFieldCell.h
//  knight
//
//  Created by dd2333 on 2019/6/10.
//  Copyright © 2019 dd2333. All rights reserved.
//

#import "DUIView.h"

@class DUITextFieldCell;

@protocol DUITextFieldCellDelegate <NSObject>

- (void)textFieldEndEditing:(DUITextFieldCell*)textField;

@end

@interface DUITextFieldCell : NSTextFieldCell
    
@property(nonatomic, weak) id<DUITextFieldCellDelegate> dui_delegate;

@end
