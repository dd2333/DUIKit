//
//  DUISecureTextFieldCell.m
//  knight
//
//  Created by dd2333 on 2019/6/10.
//  Copyright © 2019 dd2333. All rights reserved.
//

#import "DUISecureTextFieldCell.h"

@implementation DUISecureTextFieldCell

- (void)endEditing:(NSText *)textObj{
    [super endEditing:textObj];
    [self.dui_delegate textFieldEndEditing:self];
}

@end
