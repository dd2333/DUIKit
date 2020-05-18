//
//  DUIButton.m
//  knight
//
//  Created by dd2333 on 2019/6/10.
//  Copyright © 2019 dd2333. All rights reserved.
//

#import "DUIButton.h"
#import "DUILabel.h"
#import "DUIImageView.h"

typedef NS_ENUM(NSUInteger, DUIButtonStatus) {
    DUIButtonStatusNormal,
    DUIButtonStatusHover,
    DUIButtonStatusSelected,
    DUIButtonStatusHighlight,
    DUIButtonStatusDisable
};

static double upInterval = 0;
static double downInterval = 0;

@interface DUIButton ()

@property (nonatomic, assign) BOOL hover;
@property (nonatomic, assign) BOOL highlight;

@property (nonatomic, strong) id eventDownMonitor;
@property (nonatomic, strong) id eventUpMonitor;

@property (nonatomic, strong) NSTrackingArea *trackingArea;

@end

@implementation DUIButton

- (instancetype)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateFrame)
                                                     name:NSViewFrameDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc{
    if (self.eventDownMonitor) {
        [NSEvent removeMonitor:self.eventDownMonitor];
    }
    if (self.eventUpMonitor) {
        [NSEvent removeMonitor:self.eventUpMonitor];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)updateFrame{
    [self removeTrackingArea:_trackingArea];
    _trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds] options:NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveAlways owner:self userInfo:nil];
    [self addTrackingArea:_trackingArea];
}

- (DUIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[DUIImageView alloc] init];
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _imageView;
}

- (DUILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[DUILabel alloc] init];
        [_titleLabel setFont:[NSFont systemFontOfSize:16]];
        [_titleLabel setTextColor:[NSColor whiteColor]];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(0);
        }];
    }
    return _titleLabel;
}

- (void)mouseDown:(NSEvent *)event{
    if (_disabled) {
        return;
    }

    _highlight = YES;
    [self refreshStatus];
}

- (void)mouseUp:(NSEvent *)event{
    if (_disabled) {
        return;
    }

    _highlight = NO;
    [self refreshStatus];

    if (event.type == NSEventTypeLeftMouseUp) {
        if (event.clickCount == 1) {
            if (self.completion) {
                self.completion(self);
            }
        }
    }
}

- (void)mouseEntered:(NSEvent *)event{
    if (_disabled) {
        return;
    }

    _hover = YES;
    [self refreshStatus];
}

- (void)mouseExited:(NSEvent *)event{

    if (_disabled) {
        return;
    }

    _hover = NO;
    _highlight = NO;
    [self refreshStatus];
}

- (NSEvent*)keyMaskDown:(NSEvent *)event{
    if (_enableKeyEquivalent && !self.hidden && self.alphaValue > 0.001) {
        if (event.type == NSEventTypeKeyDown) {
            if (event.timestamp - 0.5 > downInterval) {
                if (event.keyCode == 36) {
                    downInterval = event.timestamp;
                    _highlight = YES;
                    [self refreshStatus];
                }
            }
        }
    }
    return event;
}

- (NSEvent*)keyMaskUp:(NSEvent *)event{
    if (_enableKeyEquivalent && !self.hidden && self.alphaValue > 0.001) {
        if (event.type == NSEventTypeKeyUp) {
            if (event.timestamp - 0.5 > upInterval) {
                if (event.keyCode == 36) {
                    upInterval = event.timestamp;
                    _highlight = NO;
                    [self refreshStatus];
                    if (self.completion) {
                        self.completion(self);
                    }
                }
            }
        }
    }
    return event;
}

- (void)setEnableKeyEquivalent:(BOOL)enableKeyEquivalent{
    _enableKeyEquivalent = enableKeyEquivalent;
    if (_enableKeyEquivalent) {
        self.eventDownMonitor = [NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskKeyDown handler:^NSEvent * _Nullable(NSEvent * _Nonnull aEvent) {
            return [self keyMaskDown:aEvent];
        }];
        self.eventUpMonitor = [NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskKeyUp handler:^NSEvent * _Nullable(NSEvent * _Nonnull aEvent) {
            return [self keyMaskUp:aEvent];
        }];
    }else{
        [NSEvent removeMonitor:self.eventUpMonitor];
        [NSEvent removeMonitor:self.eventDownMonitor];
    }
}

- (void)setNormalButtonImage:(NSImage *)normalButtonImage{
    _normalButtonImage = normalButtonImage;
    self.imageView.image = normalButtonImage;
}

- (void)setNormalButtonString:(NSString *)normalButtonString{
    _normalButtonString = normalButtonString;
    [self.titleLabel setText:self.normalButtonString];
}

- (void)setNormalButtonStringColor:(NSColor *)normalButtonStringColor{
    _normalButtonStringColor = normalButtonStringColor;
    [self.titleLabel setTextColor:self.normalButtonStringColor];
}

- (void)setSelected:(BOOL)selected{
    _selected = selected;
    [self refreshStatus];
}

- (void)setDisabled:(BOOL)disabled{
    _disabled = disabled;
    [self refreshStatus];
}

- (void)performHandle{
    self.highlight = YES;
    [self refreshStatus];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.highlight = NO;
        [self refreshStatus];
        if (self.completion) {
            self.completion(self);
        }
    });
}

- (void)refreshString{
    if (_disabled) {
        if (_disableButtonString) {
            [self.titleLabel setText:_disableButtonString];
            return;
        }
    }
    
    if (_highlight) {
        if (_highlightButtonString) {
            [self.titleLabel setText:_highlightButtonString];
            return;
        }
    }
    
    if (_hover) {
        if (_hoverButtonString) {
            [self.titleLabel setText:_hoverButtonString];
            return;
        }
    }
    
    if (_selected) {
        if (_selectedButtonString) {
            [self.titleLabel setText:_selectedButtonString];
            return;
        }
    }
    
    [self.titleLabel setText:self.normalButtonString];
}

- (void)refreshColor{
    if (_disabled) {
        if (_disableButtonStringColor) {
            [self.titleLabel setTextColor:_disableButtonStringColor];
            return;
        }
    }
    
    if (_highlight) {
        if (_highlightButtonStringColor) {
            [self.titleLabel setTextColor:_highlightButtonStringColor];
            return;
        }
    }
    
    if (_hover) {
        if (_hoverButtonStringColor) {
            [self.titleLabel setTextColor:_hoverButtonStringColor];
            return;
        }
    }
    
    if (_selected) {
        if (_selectedButtonStringColor) {
            [self.titleLabel setTextColor:_selectedButtonStringColor];
            return;
        }
    }
    
    [self.titleLabel setTextColor:self.normalButtonStringColor];
}

- (void)refreshImage{
    if (_disabled) {
        if (_disableButtonImage) {
            [self.imageView setImage:_disableButtonImage];
            return;
        }
    }
    
    if (_highlight) {
        if (_highlightButtonImage) {
            [self.imageView setImage:_highlightButtonImage];
            return;
        }
    }
    
    if (_hover) {
        if (_hoverButtonImage) {
            [self.imageView setImage:_hoverButtonImage];
            return;
        }
    }
    
    if (_selected) {
        if (_selectedButtonImage) {
            [self.imageView setImage:_selectedButtonImage];
            return;
        }
    }
    
    [self.imageView setImage:self.normalButtonImage];
}

- (void)refreshStatus{
    [self refreshString];
    [self refreshImage];
    [self refreshColor];
}

@end
