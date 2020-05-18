//
//  DUIDragView.m
//  knight
//
//  Created by dd2333 on 2019/6/10.
//  Copyright © 2019 dd2333. All rights reserved.
//

#import "DUIDragView.h"

@interface DUIDragContentView : DUIView

@property (nonatomic, assign) BOOL isDragIn;
@property (nonatomic, copy) DUIDragViewCompletion completion;

@end

@implementation DUIDragContentView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
    [self registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType,nil]];
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender{
    _isDragIn = YES;
    [self setNeedsDisplay:YES];
    return NSDragOperationCopy;
}

- (void)draggingExited:(id<NSDraggingInfo>)sender{
    _isDragIn = NO;
    [self setNeedsDisplay:YES];
}

- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender{
    _isDragIn = NO;
    [self setNeedsDisplay:YES];
    return YES;
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender{
    if ([sender draggingSource] != self) {
        NSArray* filePaths = [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType];
        if (self.completion) {
            self.completion(filePaths.firstObject);
        }
    }
    return YES;
}

@end

@interface DUIDragView()

@property (nonatomic, strong) DUIButton *dragBtn;
@property (nonatomic, strong) DUILabel *dragTip;
@property (nonatomic, strong) DUIDragContentView *dragContentView;
@property (nonatomic, strong) NSOpenPanel *panel;

@end

@implementation DUIDragView

- (instancetype)init{
    self = [super init];
    if (self) {
        
        _dragBtn = [[DUIButton alloc] init];
        [_dragBtn setNormalButtonString:DDLocalMsg(@"添加PDF文件")];
        [_dragBtn setNormalButtonStringColor:RGBAHex(0xffffff, 0.8)];
        [_dragBtn setNormalButtonImage:DDImage(@"sign_photo")];
        [_dragBtn.titleLabel setFont:DDFont(18)];
        @weakify(self)
        [_dragBtn setCompletion:^(DUIButton *button) {
            @strongify(self)
            [self fileBtnClick];
        }];
        [self addSubview:_dragBtn];
        [_dragBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [_dragBtn.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(-8);
            make.centerX.mas_equalTo(8);
        }];
        [_dragBtn.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.dragBtn.titleLabel.mas_left).mas_offset(-8);
            make.centerY.mas_equalTo(self.dragBtn.titleLabel);
        }];
        
        _dragTip = [[DUILabel alloc] init];
        [_dragTip setText:DDLocalMsg(@"拖拽文件至此区域，可直接添加")];
        [_dragTip setFont:DDFont(12)];
        [_dragTip setTextColor:RGBAHex(0xffffff, 0.6)];
        [self addSubview:_dragTip];
        [_dragTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.dragBtn);
            make.top.mas_equalTo(self.dragBtn.titleLabel.mas_bottom).mas_offset(12);
        }];
        
        _dragContentView = [[DUIDragContentView alloc] init];
        [_dragContentView setBackgroundColor:RGBA(0, 0, 0, 0.1)];
        [_dragContentView setCornerRadius:10];
        [self addSubview:_dragContentView];
        [_dragContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        _panel = [NSOpenPanel openPanel];
        _panel.extensionHidden = NO;
        _panel.allowsOtherFileTypes = NO;
        _panel.allowedFileTypes = @[@"pdf"];
        _panel.directoryURL = [NSURL URLWithString:[NSHomeDirectory() stringByAppendingPathComponent:@"Desktop"]];
    }
    return self;
}

- (void)setCompletion:(DUIDragViewCompletion)completion{
    _dragContentView.completion = completion;
}

- (void)fileBtnClick{
    if ([_panel runModal] == NSModalResponseOK) {
        if (_dragContentView.completion) {
            _dragContentView.completion(_panel.URL.path);
        }
    }
}

- (void)hideDesc{
    [_dragBtn setNormalButtonString:@""];
    [_dragBtn setNormalButtonImage:nil];
    [_dragContentView setBackgroundColor:[NSColor clearColor]];
    [_dragTip setHidden:YES];
}

- (void)showDesc{
    [_dragBtn setNormalButtonString:DDLocalMsg(@"添加PDF文件")];
    [_dragBtn setNormalButtonImage:DDImage(@"sign_photo")];
    [_dragContentView setBackgroundColor:RGBA(0, 0, 0, 0.1)];
    [_dragTip setHidden:NO];
}


@end
