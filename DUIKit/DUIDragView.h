//
//  DUIDragView.h
//  knight
//
//  Created by dd2333 on 2019/6/10.
//  Copyright © 2019 dd2333. All rights reserved.
//

#import "DUIView.h"

typedef void(^DUIDragViewCompletion)(NSString *path);

@interface DUIDragView : DUIView

- (void)setCompletion:(DUIDragViewCompletion)completion;

- (void)hideDesc;

- (void)showDesc;

@end
