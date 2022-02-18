//
//  GCActionBar.m
//  GithubClient
//
//  Created by bytedance on 2022/1/21.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCActionBar.h"
#import "configure.h"
#import <Masonry/Masonry.h>

@interface GCActionBar ()
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *tailer;
@end

@implementation GCActionBar

- (instancetype)initWithTitle:(NSString*)title WithTail:(NSString*)tail{
    if(self = [super init]) {
        _title = [[UILabel alloc] init];
        _tailer = [[UILabel alloc] init];
        
        self.backgroundColor = repository_actionBar_backgroundColor;
        
        _title.text = title;
        _title.font = repository_actionBar_title_textFont;
        _title.textColor = repository_actionBar_title_textColor;
        _title.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(self.mas_left).offset(5);
            make.top.mas_equalTo(self.mas_top);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.width.mas_greaterThanOrEqualTo(self.mas_width).multipliedBy(0.2);
        }];
        
        UIImageView *rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow-right.png"]];
        [self addSubview:rightArrow];
        [rightArrow mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.mas_equalTo(self.mas_right).offset(-5);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.and.width.mas_equalTo(self.mas_height).multipliedBy(0.4);
        }];
        
        _tailer.text = tail;
        _tailer.font = repository_actionBar_tail_textFont;
        _tailer.textColor = repository_actionBar_tail_textColor;
        _tailer.textAlignment = NSTextAlignmentRight;
        [self addSubview:_tailer];
        [_tailer mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.mas_equalTo(rightArrow.mas_left).offset(-5);
            make.top.mas_equalTo(self.mas_top);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.width.mas_greaterThanOrEqualTo(self.mas_width).multipliedBy(0.1);
        }];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
