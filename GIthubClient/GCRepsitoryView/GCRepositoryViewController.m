//
//  GCRepositoryViewController.m
//  GithubClient
//
//  Created by bytedance on 2022/1/17.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCRepositoryViewController.h"
#import <Masonry.h>
#import "GCTools.h"
#import "GCGithubApi.h"
#import <SDWebImage/SDWebImage.h>
#import "GCRepositoryData.h"
#import <YYModel/YYModel.h>
#import <YYText/YYText.h>
#import "configure.h"
#import "GCActionBar.h"
#import "markdown_lib.h"
#import "markdown_peg.h"
#import "GCFolderViewController.h"

NSMutableDictionary *markDownStyle(void)
{
    
    static NSMutableDictionary* attributes;
    static dispatch_once_t onceToken;   // typedef long dispatch_once_t;
    dispatch_once(&onceToken, ^{
        attributes = [[NSMutableDictionary alloc]init];
        // p
        UIFont *paragraphFont = [UIFont fontWithName:@"AvenirNext-Medium" size:15.0];
        NSMutableParagraphStyle* pParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        pParagraphStyle.paragraphSpacing = 12;
        pParagraphStyle.paragraphSpacingBefore = 12;
        NSDictionary *pAttributes = @{
            NSFontAttributeName : paragraphFont,
            NSParagraphStyleAttributeName : pParagraphStyle,
        };
        
        [attributes setObject:pAttributes forKey:@(PARA)];
        
        // h1
        UIFont *h1Font = [UIFont fontWithName:@"AvenirNext-Bold" size:24.0];
        [attributes setObject:@{NSFontAttributeName : h1Font} forKey:@(H1)];
        
        // h2
        UIFont *h2Font = [UIFont fontWithName:@"AvenirNext-Bold" size:18.0];
        [attributes setObject:@{NSFontAttributeName : h2Font} forKey:@(H2)];
        
        // h3
        UIFont *h3Font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:17.0];
        [attributes setObject:@{NSFontAttributeName : h3Font} forKey:@(H3)];
        
        // em
        UIFont *emFont = [UIFont fontWithName:@"AvenirNext-MediumItalic" size:15.0];
        [attributes setObject:@{NSFontAttributeName : emFont} forKey:@(EMPH)];
        
        // strong
        UIFont *strongFont = [UIFont fontWithName:@"AvenirNext-Bold" size:15.0];
        [attributes setObject:@{NSFontAttributeName : strongFont} forKey:@(STRONG)];
        
        // ul
        NSMutableParagraphStyle* listParagraphStyle = [[NSMutableParagraphStyle alloc]init];
        listParagraphStyle.headIndent = 16.0;
        [attributes setObject:@{NSFontAttributeName : paragraphFont, NSParagraphStyleAttributeName : listParagraphStyle} forKey:@(BULLETLIST)];
        
        // li
        NSMutableParagraphStyle* listItemParagraphStyle = [[NSMutableParagraphStyle alloc]init];
        listItemParagraphStyle.headIndent = 16.0;
        [attributes setObject:@{NSFontAttributeName : paragraphFont, NSParagraphStyleAttributeName : listItemParagraphStyle} forKey:@(LISTITEM)];
        
        // a
        UIColor *linkColor = [UIColor blueColor];
        [attributes setObject:@{NSForegroundColorAttributeName : linkColor} forKey:@(LINK)];
        
        // blockquote
        NSMutableParagraphStyle* blockquoteParagraphStyle = [[NSMutableParagraphStyle alloc]init];
        blockquoteParagraphStyle.headIndent = 16.0;
        blockquoteParagraphStyle.tailIndent = 16.0;
        blockquoteParagraphStyle.firstLineHeadIndent = 16.0;
        [attributes setObject:@{NSFontAttributeName : [emFont fontWithSize:18.0], NSParagraphStyleAttributeName : pParagraphStyle} forKey:@(BLOCKQUOTE)];
        
        // verbatim (code)
        NSMutableParagraphStyle* verbatimParagraphStyle = [[NSMutableParagraphStyle alloc]init];
        verbatimParagraphStyle.headIndent = 12.0;
        verbatimParagraphStyle.firstLineHeadIndent = 12.0;
        UIFont *verbatimFont = [UIFont fontWithName:@"CourierNewPSMT" size:14.0];
        [attributes setObject:@{NSFontAttributeName : verbatimFont, NSParagraphStyleAttributeName : verbatimParagraphStyle} forKey:@(VERBATIM)];
    });
    return attributes;
}

@interface GCRepositoryViewController ()
@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIView *containView;

@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *followBtn;
@property (strong, nonatomic) UILabel *starBtn;
@property (strong, nonatomic) UILabel *forkBtn;
@property (strong, nonatomic) UILabel *fullNameLabel;
@property (strong, nonatomic) UILabel *updateTime;
@property (strong, nonatomic) UILabel *rep_description;
@property (strong, nonatomic) UILabel *issueCount;
@property (strong, nonatomic) UILabel *starCount;
@property (strong, nonatomic) UILabel *forkCount;
@property (strong, nonatomic) UILabel *followCount;
@property (strong, nonatomic) UILabel *forkUrl;

@property (strong, nonatomic) GCActionBar *submitBar;
@property (strong, nonatomic) GCActionBar *branchBar;
@property (strong, nonatomic) GCActionBar *languageBar;
@property (strong, nonatomic) GCActionBar *codeBar;
@property (strong, nonatomic) GCActionBar *actionBar;
@property (strong, nonatomic) GCActionBar *mergeRequestBar;

@property (strong, nonatomic) YYLabel *readmeView;

@end

@implementation GCRepositoryViewController


- (instancetype) initWithFullName:(NSString*)fullName{
    if(self = [super init]) {
        self.fullName = fullName;
        _scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        _containView = [[UIView alloc] init];
        [_scrollView addSubview:_containView];
        [_containView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_scrollView);
            make.width.equalTo(_scrollView.mas_width);
        }];
        _containView.backgroundColor = repository_backgroundColor;
        
        
        // Do any additional setup after loading the view.
        
#pragma mark -informationView
        UIView *informationView = [[UIView alloc] init];
        
        _avatarImageView = [[UIImageView alloc] init];
        _followBtn = [[UILabel alloc] init];
        _starBtn = [[UILabel alloc] init];
        _forkBtn = [[UILabel alloc] init];
        _fullNameLabel = [[UILabel alloc] init];
        _updateTime = [[UILabel alloc] init];
        _rep_description = [[UILabel alloc] init];
        _issueCount = [[UILabel alloc] init];
        _starCount = [[UILabel alloc] init];
        _forkCount = [[UILabel alloc] init];
        _followCount = [[UILabel alloc] init];
        _followBtn = [[UILabel alloc] init];
        _forkUrl = [[UILabel alloc] init];
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        informationView.backgroundColor = repository_subView_backgroundColor;
        [_containView addSubview:informationView];
        [informationView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(_containView.mas_left).offset(5);
            make.top.mas_equalTo(_containView.mas_top).offset(5);
            make.right.mas_equalTo(_containView.mas_right).offset(-5);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(informationView);
        
        [informationView addSubview:_avatarImageView];
        [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(informationView.mas_left).offset(10);
            make.top.mas_equalTo(informationView.mas_top).offset(5);
            make.height.and.width.mas_equalTo(informationView.mas_width).multipliedBy(0.15);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(_avatarImageView);
        
        _forkBtn.backgroundColor = repository_topButton_backgroundColor;
        _forkBtn.font = repository_topButton_textFont;
        _forkBtn.textColor = repository_topButton_textColor;
        _forkBtn.textAlignment = NSTextAlignmentCenter;
        [informationView addSubview:_forkBtn];
        [_forkBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.mas_equalTo(informationView.mas_right).offset(-5);
            make.centerY.mas_equalTo(_avatarImageView.mas_centerY);
            make.height.mas_equalTo(_avatarImageView.mas_height).multipliedBy(0.3);
            make.width.mas_equalTo(informationView.mas_width).multipliedBy(0.15);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(_forkBtn);
        
        _starBtn.backgroundColor = repository_topButton_backgroundColor;
        _starBtn.font = repository_topButton_textFont;
        _starBtn.textColor = repository_topButton_textColor;
        _starBtn.textAlignment = NSTextAlignmentCenter;
        [informationView addSubview:_starBtn];
        [_starBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.mas_equalTo(_forkBtn.mas_left).offset(-5);
            make.centerY.mas_equalTo(_avatarImageView.mas_centerY);
            make.height.mas_equalTo(_avatarImageView.mas_height).multipliedBy(0.3);
            make.width.mas_equalTo(informationView.mas_width).multipliedBy(0.15);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(_starBtn);
        
        _followBtn.backgroundColor = repository_topButton_backgroundColor;
        _followBtn.font = repository_topButton_textFont;
        _followBtn.textColor = repository_topButton_textColor;
        _followBtn.textAlignment = NSTextAlignmentCenter;
        [informationView addSubview:_followBtn];
        [_followBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.mas_equalTo(_starBtn.mas_left).offset(-5);
            make.centerY.mas_equalTo(_avatarImageView.mas_centerY);
            make.height.mas_equalTo(_avatarImageView.mas_height).multipliedBy(0.3);
            make.width.mas_equalTo(informationView.mas_width).multipliedBy(0.15);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(_followBtn);
        
        _fullNameLabel.backgroundColor = repository_fullName_backgroundColor;
        _fullNameLabel.font = repository_fullName_textFont;
        _fullNameLabel.textColor = repository_fullName_textColor;
        _fullNameLabel.textAlignment = NSTextAlignmentCenter;
        [informationView addSubview:_fullNameLabel];
        [_fullNameLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(informationView.mas_left).offset(10);
            make.top.mas_equalTo(_avatarImageView.mas_bottom).offset(5);
            make.height.mas_equalTo(_avatarImageView.mas_height).multipliedBy(0.4);
            make.width.mas_greaterThanOrEqualTo(informationView.mas_width).multipliedBy(0.15);
        }];
        
        _updateTime.backgroundColor = repository_updateTime_backgroundColor;
        _updateTime.font = repository_updateTime_textFont;
        _updateTime.textColor = repository_updateTime_textColor;
        _updateTime.textAlignment = NSTextAlignmentCenter;
        [informationView addSubview:_updateTime];
        [_updateTime mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(informationView.mas_left).offset(10);
            make.top.mas_equalTo(_fullNameLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(_avatarImageView.mas_height).multipliedBy(0.2);
            make.width.mas_greaterThanOrEqualTo(informationView.mas_width).multipliedBy(0.15);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(_updateTime);
        
        
        //底部四个分别为显示 issue, star, fork, follow 数量的button
        _issueCount.backgroundColor = repository_bottomButton_backgroundColor;
        _issueCount.font = repository_bottomButton_textFont;
        _issueCount.textColor = repository_bottomButton_textColor;
        _issueCount.textAlignment = NSTextAlignmentCenter;
        [informationView addSubview:_issueCount];
        _issueCount.numberOfLines = 0;
        [_issueCount mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(informationView.mas_left);
            make.bottom.mas_equalTo(informationView.mas_bottom).offset(-5);
            make.width.mas_equalTo(informationView.mas_width).multipliedBy(0.25);
            make.height.mas_equalTo(informationView.mas_width).multipliedBy(0.15);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(_issueCount);
        
        _starCount.backgroundColor = repository_bottomButton_backgroundColor;
        _starCount.font = repository_bottomButton_textFont;
        _starCount.textColor = repository_bottomButton_textColor;
        _starCount.textAlignment = NSTextAlignmentCenter;
        _starCount.numberOfLines = 0;
        [informationView addSubview:_starCount];
        [_starCount mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(_issueCount.mas_right);
            make.bottom.mas_equalTo(informationView.mas_bottom).offset(-5);
            make.width.mas_equalTo(informationView.mas_width).multipliedBy(0.25);
            make.height.mas_equalTo(informationView.mas_width).multipliedBy(0.15);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(_starCount);
        
        _forkCount.backgroundColor = repository_bottomButton_backgroundColor;
        _forkCount.font = repository_bottomButton_textFont;
        _forkCount.textColor = repository_bottomButton_textColor;
        _forkCount.numberOfLines = 0;
        _forkCount.textAlignment = NSTextAlignmentCenter;
        [informationView addSubview:_forkCount];
        [_forkCount mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(_starCount.mas_right);
            make.bottom.mas_equalTo(informationView.mas_bottom).offset(-5);
            make.width.mas_equalTo(informationView.mas_width).multipliedBy(0.25);
            make.height.mas_equalTo(informationView.mas_width).multipliedBy(0.15);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(_forkCount);
        
        _followCount.backgroundColor = repository_bottomButton_backgroundColor;
        _followCount.font = repository_bottomButton_textFont;
        _followCount.textColor = repository_bottomButton_textColor;
        _followCount.textAlignment = NSTextAlignmentCenter;
        _followCount.numberOfLines = 0;
        [informationView addSubview:_followCount];
        [_followCount mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(_forkCount.mas_right);
            make.bottom.mas_equalTo(informationView.mas_bottom).offset(-5);
            make.width.mas_equalTo(informationView.mas_width).multipliedBy(0.25);
            make.height.mas_equalTo(informationView.mas_width).multipliedBy(0.15);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(_followCount);
        
        
        _rep_description.numberOfLines = 0;//label最多能显示的行数
        _rep_description.backgroundColor = repository_description_backgroundColor;
        _rep_description.font = repository_description_textFont;
        _rep_description.textColor = repository_description_textColor;
        [informationView addSubview:_rep_description];
        [_rep_description mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(informationView.mas_left).offset(5);
            make.top.mas_equalTo(_updateTime.mas_bottom).offset(10);
            make.bottom.mas_equalTo(_issueCount.mas_top).offset(-10);
            make.right.mas_equalTo(informationView.mas_right).offset(-5);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(_rep_description);
        
#pragma mark -actionBars
        _submitBar =  [[GCActionBar alloc] initWithTitle:@"提交" WithTail:@""];
        _branchBar =  [[GCActionBar alloc] initWithTitle:@"分支" WithTail:@""];
        _languageBar =  [[GCActionBar alloc] initWithTitle:@"语言" WithTail:@""];
        _codeBar =  [[GCActionBar alloc] initWithTitle:@"代码" WithTail:@""];
        _actionBar =  [[GCActionBar alloc] initWithTitle:@"Action" WithTail:@""];
        _mergeRequestBar =  [[GCActionBar alloc] initWithTitle:@"合并请求" WithTail:@""];
        
        NSArray *arr = [[NSArray alloc] initWithObjects:_submitBar,_branchBar,_languageBar,_codeBar,_codeBar,_actionBar,_mergeRequestBar, nil];
        GCActionBar *lastOne = nil;
        for(GCActionBar *bar in arr){
            [_containView addSubview:bar];
            [bar mas_makeConstraints:^(MASConstraintMaker *make){
                make.left.mas_equalTo(_containView.mas_left).offset(10);
                make.right.mas_equalTo(_containView.mas_right).offset(-5);
                make.height.mas_equalTo(_containView.mas_width).multipliedBy(0.1);
                if (lastOne) {
                    make.top.mas_equalTo(lastOne.mas_bottom).offset(5);
                }
                else {
                    make.top.mas_equalTo(informationView.mas_bottom).offset(20);
                }
            }];
            lastOne = bar;
        }
#pragma mark -readme
        
        _readmeView = [[YYLabel alloc] init];
        _readmeView.numberOfLines = 0;
        [_containView addSubview:_readmeView];
        [_readmeView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(_containView.mas_left);
            make.right.mas_equalTo(_containView.mas_right);
            make.top.mas_equalTo(_mergeRequestBar.mas_bottom).offset(20);
            make.bottom.mas_equalTo(_containView.mas_bottom).offset(-10);
        }];
        setRequiredOnVerticalAndHorizontalForUIView(_readmeView);
#pragma mark -getData
        __weak typeof(self) weakSelf = self;
        [[GCGithubApi shareGCGithubApi] getWithUrl:getRepositoryInformation(_fullName) WithAcceptType:JSonContent WithSuccessBlock:^(id responseObj){
            weakSelf.data = [GCRepositoryData yy_modelWithJSON:responseObj];
        } WithFailureBlock:^{
            
        }];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)setData:(GCRepositoryData *)aData{
    _data = aData;
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:aData.owner.avatar_url] placeholderImage:[UIImage imageNamed:@"icons/close.png"]];
    [_avatarImageView.layer setCornerRadius:CGRectGetHeight([_avatarImageView bounds]) / 2];
    [_avatarImageView.layer setMasksToBounds:YES];
    
    _followBtn.text = @"关注";
    
    _starBtn.text = @"标星";
    
    _forkBtn.text = @"拷贝";
    
    _fullNameLabel.text = _fullName;
    
    _rep_description.text = aData.description_;
    
    _updateTime.text = aData.updated_at;
    
    _issueCount.text = [aData.open_issues_count stringByAppendingString:@"\n\n问题"];
    
    _starCount.text = [aData.stargazers_count stringByAppendingString:@"\n\n标星"];
    
    _forkCount.text = [aData.forks_count stringByAppendingString:@"\n\n拷贝"];
    
    _followCount.text = [aData.forks_count stringByAppendingString:@"\n\n关注"];
    
    __weak typeof(self) weakSelf = self;
    
    [[GCGithubApi shareGCGithubApi] getWithUrl:getReadmeUrl(aData.full_name) WithAcceptType:RawContent WithSuccessBlock:^(NSDictionary *responseObj){
        //        NSLog(@"%@", responseObj);
        NSString *readmeText = [responseObj valueForKey:@"content"];
        NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:readmeText options:NSDataBase64DecodingIgnoreUnknownCharacters];
        NSString *decodeText = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", decodeText);
        
        //CocoaMarkDown
        //        CMDocument *docutment = [[CMDocument alloc] initWithData:decodedData options:CMDocumentOptionsSmart];
        //        CMTextAttributes *attribute = [[CMTextAttributes alloc] init];
        //        CMAttributedStringRenderer *render = [[CMAttributedStringRenderer alloc] initWithDocument:docutment attributes:attribute];
        //        [render registerHTMLElementTransformer:[[CMHTMLStrikethroughTransformer alloc] init]];
        //        [render registerHTMLElementTransformer:[[CMHTMLSuperscriptTransformer alloc] init]];
        //        weakSelf.readmeView.attributedText = render.render;
        
        //
        
        NSMutableAttributedString* attr_out = markdown_to_attr_string(decodeText,0,markDownStyle());
        
        weakSelf.readmeView.attributedText = attr_out;
    } WithFailureBlock:^{
        weakSelf.readmeView.text = @"can not get readme";
    }];
    
    [self addEvents];
}

#pragma mark -actions
- (void) addEvents{
    UITapGestureRecognizer *tapCodeBar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(codeBarAction)];
    [_codeBar addGestureRecognizer:tapCodeBar];
    _codeBar.userInteractionEnabled = YES;
}

- (void) codeBarAction{
    GCFolderViewController *folderVC = [[GCFolderViewController alloc] initWithFullName:_data.full_name WithSha:nil];
    [self.navigationController pushViewController:folderVC animated:YES];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
