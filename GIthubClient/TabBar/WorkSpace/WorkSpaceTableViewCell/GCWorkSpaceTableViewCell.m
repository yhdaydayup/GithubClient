//
//  GCWorkSpaceTableViewCell.m
//  GithubClient
//
//  Created by bytedance on 2022/1/12.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCWorkSpaceTableViewCell.h"
#import "configure.h"
#import <Masonry/Masonry.h>
#import "GCTools.h"

@interface GCWorkSpaceTableViewCell ()
@property(copy, nonatomic) GCWorkSpaceTableViewCellModel *data;
@property (strong, nonatomic) UILabel *title;
@end

@implementation GCWorkSpaceTableViewCell
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _title = [[UILabel alloc] init];
        self.imageArea = [[UIImageView alloc] init];
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = TabBarPage_Element_Background_Color;
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(self.mas_left).offset(5);
            make.right.mas_equalTo(self.mas_right).offset(-5);
            make.top.mas_equalTo(self.mas_top).offset(5);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
        }];
        
        [self.contentView addSubview:self.imageArea];
        [self.imageArea mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(self.contentView.mas_left).offset(5);
            make.width.height.mas_equalTo(self.contentView.mas_height).multipliedBy(0.6);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(self.imageArea);
        
        _title.font = WorkSpaceCell_Title_Font;
        _title.textColor = WorkSpaceCell_Title_TextColor;
        [self.contentView addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(self.imageArea.mas_right).offset(5);
            make.top.mas_equalTo(self.contentView.mas_top);
            make.height.mas_equalTo(self.contentView.mas_height);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(self.title);
        
        UIImageView *rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow-right"]];
        [self.contentView addSubview:rightArrow];
        [rightArrow mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.and.width.mas_equalTo(self.contentView.mas_height).multipliedBy(0.4);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(rightArrow);
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void) setModel:(GCWorkSpaceTableViewCellModel *)model
{
    _data = model;
    
    _title.text = _data.title;
    [_title sizeToFit];
    
    self.imageArea.image = [UIImage imageNamed:_data.imagePath];
    [self.contentView layoutIfNeeded];
    [self.imageArea.layer setCornerRadius:CGRectGetHeight([self.imageArea frame]) / 2];
    [self.imageArea.layer setMasksToBounds:YES];
    
}
@end
