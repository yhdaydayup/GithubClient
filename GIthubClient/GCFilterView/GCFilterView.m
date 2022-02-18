//
//  GCFilterView.m
//  GithubClient
//
//  Created by bytedance on 2022/2/7.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCFilterView.h"
#import <Masonry/Masonry.h>
@interface GCFilterView () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) UIPickerView *languagePickView;
@property (strong, nonatomic) UIPickerView *sortPickView;
@property (strong, nonatomic) UILabel *languageLabel;
@property (strong, nonatomic) UILabel *sortLabel;
@property (strong, nonatomic) UILabel *completeLabel;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) NSArray *languages;
@property (strong, nonatomic) NSArray *sortWays;
@end

@implementation GCFilterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype) init {
    if(self = [super init]) {
        _contentView = [[UIView alloc] init];
        _languagePickView = [[UIPickerView alloc] init];
        _sortPickView = [[UIPickerView alloc] init];
        _languageLabel = [[UILabel alloc] init];
        _sortLabel = [[UILabel alloc] init];
        _completeLabel = [[UILabel alloc] init];
        
        _sortPickView.delegate = self;
        _sortPickView.dataSource = self;
        
        _languagePickView.delegate = self;
        _languagePickView.dataSource = self;
        
        _languages = @[@"Any", @"C++", @"Java", @"Objective-c"];
        _sortWays =  @[@"Best Match", @"Most Stars", @"Most forks", @"Recently updated"];

        self.backgroundColor = [UIColor blackColor] ;
        self.alpha = 0.7f;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapBackgroundView:)];
        [self addGestureRecognizer:myTap];

        _contentView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tapBlock = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blockTap)];
        [_contentView addGestureRecognizer:tapBlock];
        [self addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.mas_top);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.width.mas_equalTo(300);
        }];

        UILabel *sortText = [[UILabel alloc] init];
        sortText.text = @"排序";
        [_contentView addSubview:sortText];
        [sortText mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(_contentView.mas_left).offset(5);
            make.top.mas_equalTo(_contentView.mas_top).offset(5);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(30);
        }];

        _languageLabel.text = @"Any";
        _languageLabel.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:_languageLabel];
        [_languageLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(_contentView.mas_left).offset(5);
            make.top.mas_equalTo(sortText.mas_bottom).offset(5);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(30);
        }];

        UILabel *languageText = [[UILabel alloc] init];
        languageText.text = @"语言";
        [_contentView addSubview:languageText];
        [languageText mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(_contentView.mas_left).offset(5);
            make.top.mas_equalTo(_languageLabel.mas_bottom).offset(5);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(30);
        }];

        [self addSubview:_sortLabel];
        _sortLabel.text = @"Best Match";
        _sortLabel.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:_sortLabel];
        [_sortLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(_contentView.mas_left).offset(5);
            make.top.mas_equalTo(languageText.mas_bottom).offset(5);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(30);
        }];

        [self addSubview:_completeLabel];
        _completeLabel.text = @"完成";
        [_contentView addSubview:_completeLabel];
        [_completeLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.mas_equalTo(_contentView.mas_right).offset(-5);
            make.bottom.mas_equalTo(_contentView.mas_bottom).offset(-10);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(30);
        }];
        
        [self addSubview:_languagePickView];
        _languagePickView.backgroundColor = [UIColor whiteColor];
        [_languagePickView mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY).offset(-20);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(400);
        }];
        
        [self addSubview:_sortPickView];
        _sortPickView.backgroundColor = [UIColor whiteColor];
        [_sortPickView mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY).offset(-20);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(400);
        }];
        [self blockTap];
        
        [self addEvents];
    }
    return self;
}
- (void) addEvents {
    _languageLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapLanguageLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLanguagePickView)];
    [_languageLabel addGestureRecognizer:tapLanguageLabel];
    
    _sortLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapSortLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSortPickView)];
    [_sortLabel addGestureRecognizer:tapSortLabel];
}
- (void) showLanguagePickView {
    _languagePickView.hidden = NO;
}
- (void) showSortPickView {
    _sortPickView.hidden = NO;
}
- (void) didTapBackgroundView:(UITapGestureRecognizer *)sender {
    self.hidden = YES;
}
- (void) blockTap {
    _languagePickView.hidden = YES;
    _sortPickView.hidden = YES;
}
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(pickerView == _sortPickView) {
        return _sortWays.count;
    }
    else if(pickerView == _languagePickView) {
        return _languages.count;
    }
    return 0;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(pickerView == _sortPickView) {
        return @"排序规则";
    }
    else if(pickerView == _languagePickView) {
        return @"语言";
    }
    return @"";
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    if(pickerView == _sortPickView) {
        label.text = _sortWays[row];
    }
    else if(pickerView == _languagePickView) {
        label.text = _languages[row];
    }
    return label;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(pickerView == _sortPickView) {
        _sortLabel.text = _sortWays[row];
    }
    else if(pickerView == _languagePickView) {
        _languageLabel.text = _languages[row];
    }
}
@end
