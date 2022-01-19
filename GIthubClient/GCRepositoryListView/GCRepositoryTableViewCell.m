//
//  GCRepositoryTableViewCell.m
//  GithubClient
//
//  Created by bytedance on 2022/1/13.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCRepositoryTableViewCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import "GCTools.h"
#import "configure.h"



@interface GCRepositoryTableViewCell ()
@property (strong, nonatomic) UIView *cellView;
@property (strong, nonatomic) UILabel *repositoryNameLabel;
@property (strong, nonatomic) UILabel *userNameLabel;
@property (strong, nonatomic) UIImageView *headsImageView;
@property (strong, nonatomic) UILabel *languageLabel;
@property (strong, nonatomic) UILabel *briefDescription;
@property (strong, nonatomic) UILabel *forkCount;
@property (strong, nonatomic) UILabel *starCount;
@property (strong, nonatomic) UIImageView *forkImageView;
@property (strong, nonatomic) UIImageView *starImageView;
@property BOOL isStar;
@end

@implementation GCRepositoryTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _cellView = [[UIView alloc] init];
        _repositoryNameLabel = [[UILabel alloc] init];
        _userNameLabel = [[UILabel alloc] init];
        _headsImageView = [[UIImageView alloc] init];
        _languageLabel = [[UILabel alloc] init];
        _briefDescription = [[UILabel alloc] init];
        _forkCount = [[UILabel alloc] init];
        _starCount = [[UILabel alloc] init];
        _forkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fork.png"]];
        _starImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star.png"]];
        _isStar = NO;
        
        self.backgroundColor = TabBarPage_Background_color;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.cellView.backgroundColor = TabBarPage_Element_Background_Color;
        [self.contentView addSubview:_cellView];
        [self.cellView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(self.contentView.mas_left).offset(5);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
            make.top.mas_equalTo(self.contentView.mas_top).offset(5);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
        }];

        
        [self.cellView addSubview:_headsImageView];
        [_headsImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.mas_equalTo(self.cellView.mas_left).offset(10);
            make.top.mas_equalTo(self.cellView.mas_top).offset(5);
            make.height.and.width.mas_equalTo(self.cellView.mas_width).multipliedBy(0.15);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(_headsImageView);

        _repositoryNameLabel.font = RepositoryList_repositoryName_font;
        _repositoryNameLabel.textColor = RepositoryList_repositoryName_textColor;
        [self.cellView addSubview:_repositoryNameLabel];
        [_repositoryNameLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.mas_equalTo(_headsImageView.mas_right).offset(10);
            make.top.mas_equalTo(self.cellView.mas_top).offset(5);
            make.height.mas_equalTo(self.cellView.mas_width).multipliedBy(0.1);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(_repositoryNameLabel);

        _userNameLabel.font = RepositoryList_username_font;
        _userNameLabel.textColor = RepositoryList_username_TextColor;
        [self.cellView addSubview:_userNameLabel];
        [_userNameLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.mas_equalTo(_headsImageView.mas_right).offset(10);
            make.top.mas_equalTo(_repositoryNameLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(self.cellView.mas_width).multipliedBy(0.1);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(_userNameLabel);

        _languageLabel.font = RepositoryList_language_font;
        _languageLabel.textColor = RepositoryList_language_textColor;
        [self.cellView addSubview:_languageLabel];
        [_languageLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.mas_equalTo(_userNameLabel.mas_right).offset(10);
            make.top.mas_equalTo(_userNameLabel.mas_top);
            make.height.mas_equalTo(self.cellView.mas_width).multipliedBy(0.1);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(_languageLabel);

        _forkCount.font = RepositoryList_fork_font;
        _forkCount.textColor = RepositoryList_fork_textColor;
        [self.cellView addSubview:_forkCount];
        [_forkCount mas_makeConstraints:^(MASConstraintMaker* make){
            make.right.mas_equalTo(self.cellView.mas_right).multipliedBy(0.9);
            make.bottom.mas_equalTo(self.cellView.mas_bottom).offset(-5);
            make.height.and.width.mas_equalTo(self.cellView.mas_width).multipliedBy(0.05);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(_forkCount);

        [self.cellView addSubview:_forkImageView];
        [_forkImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.right.mas_equalTo(_forkCount.mas_left).offset(-5);
            make.bottom.mas_equalTo(self.cellView.mas_bottom).offset(-5);
            make.height.width.mas_equalTo(self.cellView.mas_width).multipliedBy(0.05);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(_forkImageView);

        _starCount.font = RepositoryList_star_font;
        _starCount.textColor = RepositoryList_star_textColor;
        [self.cellView addSubview:_starCount];
        [_starCount mas_makeConstraints:^(MASConstraintMaker* make){
            make.right.mas_equalTo(_forkImageView.mas_left).offset(-20);
            make.bottom.mas_equalTo(self.cellView.mas_bottom).offset(-5);
            make.height.width.mas_equalTo(self.cellView.mas_width).multipliedBy(0.05);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(_starCount);

        [self.cellView addSubview:_starImageView];
        [_starImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.right.mas_equalTo(_starCount.mas_left).offset(-5);
            make.bottom.mas_equalTo(self.cellView.mas_bottom).offset(-5);
            make.height.width.mas_equalTo(self.cellView.mas_width).multipliedBy(0.05);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(_starImageView);

        _briefDescription.font = RepositoryList_description_font;
        _briefDescription.textColor = RepositoryList_description_textColor;
        _briefDescription.numberOfLines = 5;//label最多能显示的行数
        [self.cellView addSubview:_briefDescription];
        [_briefDescription mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_userNameLabel.mas_bottom).with.offset(5);
            make.left.equalTo(_headsImageView.mas_right).with.offset(5);
            make.right.equalTo(self.cellView.mas_right).with.offset(-20);
            make.bottom.mas_equalTo(_forkCount.mas_top).offset(-20);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(_briefDescription);
        
        [self addEvents];
    }
    return self;
}
#pragma mark -addEvents
- (void) addEvents{
    UITapGestureRecognizer *tapStar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(starAction)];
    [_starImageView addGestureRecognizer:tapStar];
    _starImageView.userInteractionEnabled = YES;
    return;
}
- (void) starAction{
    if(_isStar) {
        [_starImageView setImage:[UIImage imageNamed:@"star-fill-yellow.png"]];
    }
    else {
        [_starImageView setImage:[UIImage imageNamed:@"star.png"]];
    }
    _isStar = !_isStar;
    return;
}
- (void) setData:(NSMutableDictionary*)aData{
//    self.data = [aData mutableCopy];
    // @"owner" @"name" @"starazers-count" @"forks-count" @"description" @"language"
    //owner.login owner.avatar_url
    [self.cellView layoutIfNeeded];
    _userNameLabel.text = [aData valueForKeyPath:@"owner.login"];
    [_userNameLabel sizeToFit];
    
    _repositoryNameLabel.text = [aData valueForKeyPath:@"name"];
    [_repositoryNameLabel sizeToFit];
    
    [_headsImageView sd_setImageWithURL:[NSURL URLWithString:[aData valueForKeyPath:@"owner.avatar_url"]] placeholderImage:[UIImage imageNamed:@"icons/close.png"]];
    [_headsImageView.layer setCornerRadius:CGRectGetHeight([_headsImageView bounds]) / 2];
    [_headsImageView.layer setMasksToBounds:YES];
    
    _languageLabel.text = [@"" stringByAppendingFormat:@"%@",[aData valueForKey:@"language"]];
    [_languageLabel sizeToFit];
    
    _briefDescription.text = [aData valueForKey:@"description"];

    _forkCount.text = [NSString stringWithFormat:@"%@", [aData valueForKey:@"forks_count"]];
    [_forkCount sizeToFit];

    _starCount.text = [NSString stringWithFormat:@"%@", [aData valueForKey:@"stargazers_count"]];
    [_forkCount sizeToFit];
}

@end
