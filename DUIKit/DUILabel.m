//
//  DUILabel.m
//  knight
//
//  Created by dd2333 on 2019/6/10.
//  Copyright © 2019 dd2333. All rights reserved.
//

#import "DUILabel.h"

@implementation DUILabel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.editable = NO;
        self.selectable = NO;
        self.bordered = NO;
        self.focusRingType = NSFocusRingTypeNone;
        self.backgroundColor = [NSColor clearColor];
        self.maximumNumberOfLines = 1;
        self.textColor = [NSColor whiteColor];
    }
    
    return self;
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
