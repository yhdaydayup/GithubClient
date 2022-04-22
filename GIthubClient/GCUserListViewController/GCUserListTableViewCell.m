//
//  GCUserListTableViewCell.m
//  GithubClient
//
//  Created by ByteDance on 2022/4/5.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCUserListTableViewCell.h"
#import <Masonry/Masonry.h>
#import "GCUserModel.h"
#import <SDWebImage/SDWebImage.h>

@interface GCUserListTableViewCell ()
@property (strong, nonatomic) UILabel *userNameLabel;
@property (strong, nonatomic) UIImageView *avatarImageView;
@end

@implementation GCUserListTableViewCell
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.userNameLabel = [[UILabel alloc] init];
        self.avatarImageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_avatarImageView];
        [_avatarImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.mas_equalTo(self.contentView.mas_left).offset(30);
            make.top.mas_equalTo(self.contentView.mas_top).offset(15);
            make.height.and.width.mas_equalTo(self.contentView.mas_height).multipliedBy(0.6);
        }];
        
        [self.contentView addSubview:_userNameLabel];
        [_userNameLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.mas_equalTo(self.avatarImageView.mas_right).offset(30);
            make.top.mas_equalTo(self.contentView.mas_top).offset(15);
            make.height.mas_equalTo(self.contentView.mas_height).multipliedBy(0.5);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        }];
        _userNameLabel.numberOfLines = 0;
        _userNameLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
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
- (void)setModel:(GCUserModel *)model {
    _model = model;
     
    _userNameLabel.text = model.login;
    [_userNameLabel sizeToFit];
    
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:_model.avatar_url] placeholderImage:[UIImage imageNamed:@"icons/close.png"]];
    [_avatarImageView.layer setCornerRadius:CGRectGetHeight([_avatarImageView bounds]) / 2];
    [_avatarImageView.layer setMasksToBounds:YES];
}
@end
