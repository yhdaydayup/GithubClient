//
//  GCFolderViewController.m
//  GithubClient
//
//  Created by bytedance on 2022/1/26.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCFolderViewController.h"
#import "GCFolderData.h"
#import <Masonry/Masonry.h>
#import "GCGithubApi.h"
#import "GCFolderTableViewCell.h"
#import <YYModel/YYModel.h>
#import "GCBlobViewController.h"

@interface GCFolderViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSString *fullName;
@property (strong, nonatomic) GCFolderData *data;
@end

@implementation GCFolderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top).offset(5);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-5);
    }];
    [_tableView registerClass:[GCFolderTableViewCell class] forCellReuseIdentifier:@"GCFolderTableViewCell"];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GCFolderTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"GCFolderTableViewCell"];
    [cell setData:_data.tree[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIScreen mainScreen].bounds.size.height / 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([_data.tree[indexPath.row].type isEqualToString:@"dir"] || [_data.tree[indexPath.row].type isEqualToString:@"tree"]) {
        GCFolderViewController *folderVC = [[GCFolderViewController alloc] initWithFullName:self.fullName WithSha:self.data.tree[indexPath.row].sha];
        [self.navigationController pushViewController:folderVC animated:YES];
    }
    else {
        GCBlobViewController *blobVC = [[GCBlobViewController alloc] initWithFullName:self.fullName WithSha:self.data.tree[indexPath.row].sha];
        [self.navigationController pushViewController:blobVC animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.tree.count;
}

- (instancetype)initWithFullName:(NSString*)fullName WithSha:(NSString*)sha {
    if([self init]) {
        _fullName = fullName;
        __weak typeof(self) weakSelf = self;
        if(sha != nil) {
            [[GCGithubApi shareGCGithubApi] getWithUrl:getFolderUrl(fullName, sha) WithAcceptType:JSonContent WithSuccessBlock:^(id responseObj){
                weakSelf.data = [GCFolderData yy_modelWithJSON:responseObj];
                NSLog(@"%@", weakSelf.data);
                [weakSelf.tableView reloadData];
            } WithFailureBlock:^{}];
        }
        else {
            [[GCGithubApi shareGCGithubApi] getWithUrl:getFolderUrl(fullName, sha) WithAcceptType:JSonContent WithSuccessBlock:^(id responseObj){
                GCFolderData *folderData = [[GCFolderData alloc] init];
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                for(NSDictionary *dic in responseObj) {
                    GCTreeItem *item = [[GCTreeItem alloc] init];
                    item.path = [dic objectForKey:@"path"];
                    item.sha = [dic objectForKey:@"sha"];
                    item.type = [dic objectForKey:@"type"];
                    [arr addObject:item];
                }
                folderData.sha = @"";
                folderData.tree =arr;
                weakSelf.data = folderData;
                NSLog(@"%@", weakSelf.data);
                [weakSelf.tableView reloadData];
            } WithFailureBlock:^{}];
        }
        
    }
    return self;
}

@end
