//
//  DUITableView.m
//  knight
//
//  Created by dd2333 on 2019/6/10.
//  Copyright © 2019 dd2333. All rights reserved.
//

#import "DUITableView.h"
#import "DUIScrollView.h"
#import "DUITableRowView.h"

@interface DUITableView () <NSTableViewDelegate, NSTableViewDataSource>
    
@property (nonatomic, strong) DUIScrollView *scrollView;

@end

@implementation DUITableView
    
- (instancetype)init{
    self = [super init];
    if (self) {
        self.scrollView = [[DUIScrollView alloc] init];
        [self addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
        
        _tableView = [[NSTableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setHeaderView:nil];
        [_tableView setBackgroundColor:[NSColor clearColor]];
        
        [_tableView addTableColumn:[[NSTableColumn alloc] initWithIdentifier:@""]];
        [self.scrollView setDocumentView:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setSelectRow:(NSUInteger)row{
    [_tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:row] byExtendingSelection:NO];
    _selectIndex = row;
    [self.dui_delegate tableView:self didSelectedRow:_selectIndex];
}

- (void)reloadData{
    [_tableView reloadData];
}
    
#pragma mark - tableView
    
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return [self.dui_delegate numberOfRowsInTableView:self];
}
    
- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row{
    return [self.dui_delegate tableView:self rowViewForRow:row];;
}
    
- (NSIndexSet *)tableView:(NSTableView *)tableView selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes{
    
    if (proposedSelectionIndexes.count > 0) {
        NSUInteger index = proposedSelectionIndexes.firstIndex;
        
        BOOL ret = [self.dui_delegate tableView:self shouldSelectRow:index];
        
        if (!ret) {
            return [NSIndexSet indexSetWithIndex:self.selectIndex];
        }
        
        _selectIndex = index;
        [self.dui_delegate tableView:self didSelectedRow:index];
        
        return proposedSelectionIndexes;
    }
    
    return [NSIndexSet indexSetWithIndex:self.selectIndex];
}
    
- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return [self.dui_delegate tableView:self heightForRow:row];
}
    
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    return [self.dui_delegate tableView:self viewForRow:row];
}


@end
