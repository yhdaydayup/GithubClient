//
//  GCFolderTableViewCell.m
//  GithubClient
//
//  Created by bytedance on 2022/1/26.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCFolderTableViewCell.h"
#import "GCFolderData.h"
#import <Masonry/Masonry.h>
#import "configure.h"

@interface GCFolderTableViewCell ()
@property (strong, nonatomic) UIImageView *titleImage;
@property (strong, nonatomic) UILabel *fileName;
@end

@implementation GCFolderTableViewCell
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleImage = [[UIImageView alloc] init];
        _fileName = [[UILabel alloc] init];
        UIImageView *rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow-right.png"]];
        
        [self.contentView addSubview:_titleImage];
        [_titleImage mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(self.contentView.mas_left).offset(5);
            make.height.and.width.mas_equalTo(self.contentView.mas_height).multipliedBy(0.6);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        [self.contentView addSubview:rightArrow];
        [rightArrow mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
            make.height.and.width.mas_equalTo(self.contentView.mas_height).multipliedBy(0.3);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        [self.contentView addSubview:_fileName];
        [_fileName mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(_titleImage.mas_right).offset(5);
            make.width.mas_greaterThanOrEqualTo(20);
//            make.right.mas_lessThanOrEqualTo(rightArrow.mas_left).offset(-5);
            make.top.mas_equalTo(self.contentView.mas_top);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
        _fileName.font = folder_fileName_textFont;
        _fileName.textColor = folder_fileName_textColor;
        _fileName.textAlignment = NSTextAlignmentLeft;
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

- (void)setData:(GCTreeItem*) tree
{
    NSString *imagePath;
    if([tree.type isEqualToString:@"blob"]) {
        imagePath = @"file.png";
    }
    else {
        imagePath = @"folder.png";
    }
    self.titleImage.image = [UIImage imageNamed:imagePath];
    
    self.fileName.text = tree.path;
}

@end
