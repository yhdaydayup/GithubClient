//
//  GCPersonalTableViewCell.m
//  GithubClient
//
//  Created by ByteDance on 2022/3/22.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCPersonalTableViewCell.h"
#import <Masonry/Masonry.h>

@interface GCPersonalTableViewCell()
@property (strong, nonatomic) UILabel *infoLabel;
@end

@implementation GCPersonalTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:17];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(self.contentView.mas_left).offset(20);
            make.width.mas_equalTo(50);
            make.top.mas_equalTo(self.contentView.mas_top).offset(10);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_infoLabel];
        _infoLabel.textAlignment = NSTextAlignmentRight;
        _infoLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
        [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.mas_equalTo(self.contentView.mas_right).offset(-30);
            make.left.mas_lessThanOrEqualTo(self.contentView.mas_right).offset(20);
            make.top.mas_equalTo(self.contentView.mas_top).offset(10);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        [self.contentView bringSubviewToFront:_infoLabel];
        
        
    }
    return self;
}

-(void)setCellWithTitle:(NSString*)title WithText:(NSString *)text {
    [self.textLabel setText:title];
    [self.infoLabel setText: text != [NSNull null] ? text : @"unknown"];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
