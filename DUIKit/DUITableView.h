//
//  DUITableView.h
//  knight
//
//  Created by dd2333 on 2019/6/10.
//  Copyright © 2019 dd2333. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DUITableView,DUITableRowView;

@protocol DUITableViewDelegate <NSObject>

@required
    
- (NSUInteger)numberOfRowsInTableView:(DUITableView *)tableView;
    
- (BOOL)tableView:(DUITableView *)tableView shouldSelectRow:(NSInteger)row;
    
- (void)tableView:(DUITableView *)tableView didSelectedRow:(NSInteger)row;
    
- (float)tableView:(DUITableView *)tableView heightForRow:(NSInteger)row;
    
- (DUIView *)tableView:(DUITableView *)tableView viewForRow:(NSInteger)row;
    
- (DUITableRowView *)tableView:(DUITableView *)tableView rowViewForRow:(NSInteger)row;

@end

@interface DUITableView : DUIView
    
@property (nonatomic, weak) id<DUITableViewDelegate> dui_delegate;
    
@property (nonatomic, assign, readonly) NSUInteger selectIndex;
    
@property (nonatomic, strong, readonly) NSTableView *tableView;

- (void)setSelectRow:(NSUInteger)row;

- (void)reloadData;
    
@end
