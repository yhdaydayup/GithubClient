//
//  GCSearchRepositoryResultData.h
//  GithubClient
//
//  Created by bytedance on 2022/1/28.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCOwner.h"

NS_ASSUME_NONNULL_BEGIN

@interface GCSearchRepositoryResultDatum :NSObject
@property (nonatomic , assign) NSInteger              _id;
@property (nonatomic , copy) NSString              * node_id;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * full_name;
@property (nonatomic , assign) BOOL              _private;
@property (nonatomic , strong) GCOwner              * owner;
@property (nonatomic , copy) NSString              * html_url;
@property (nonatomic , copy) NSString              *_description;
@property (nonatomic , assign) BOOL              fork;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * forks_url;
@property (nonatomic , copy) NSString              * keys_url;
@property (nonatomic , copy) NSString              * collaborators_url;
@property (nonatomic , copy) NSString              * teams_url;
@property (nonatomic , copy) NSString              * hooks_url;
@property (nonatomic , copy) NSString              * issue_events_url;
@property (nonatomic , copy) NSString              * events_url;
@property (nonatomic , copy) NSString              * assignees_url;
@property (nonatomic , copy) NSString              * branches_url;
@property (nonatomic , copy) NSString              * tags_url;
@property (nonatomic , copy) NSString              * blobs_url;
@property (nonatomic , copy) NSString              * git_tags_url;
@property (nonatomic , copy) NSString              * git_refs_url;
@property (nonatomic , copy) NSString              * trees_url;
@property (nonatomic , copy) NSString              * statuses_url;
@property (nonatomic , copy) NSString              * languages_url;
@property (nonatomic , copy) NSString              * stargazers_url;
@property (nonatomic , copy) NSString              * contributors_url;
@property (nonatomic , copy) NSString              * subscribers_url;
@property (nonatomic , copy) NSString              * subscription_url;
@property (nonatomic , copy) NSString              * commits_url;
@property (nonatomic , copy) NSString              * git_commits_url;
@property (nonatomic , copy) NSString              * comments_url;
@property (nonatomic , copy) NSString              * issue_comment_url;
@property (nonatomic , copy) NSString              * contents_url;
@property (nonatomic , copy) NSString              * compare_url;
@property (nonatomic , copy) NSString              * merges_url;
@property (nonatomic , copy) NSString              * archive_url;
@property (nonatomic , copy) NSString              * downloads_url;
@property (nonatomic , copy) NSString              * issues_url;
@property (nonatomic , copy) NSString              * pulls_url;
@property (nonatomic , copy) NSString              * milestones_url;
@property (nonatomic , copy) NSString              * notifications_url;
@property (nonatomic , copy) NSString              * labels_url;
@property (nonatomic , copy) NSString              * releases_url;
@property (nonatomic , copy) NSString              * deployments_url;
@property (nonatomic , copy) NSString              * created_at;
@property (nonatomic , copy) NSString              * updated_at;
@property (nonatomic , copy) NSString              * pushed_at;
@property (nonatomic , copy) NSString              * git_url;
@property (nonatomic , copy) NSString              * ssh_url;
@property (nonatomic , copy) NSString              * clone_url;
@property (nonatomic , copy) NSString              * svn_url;
@property (nonatomic , assign) NSInteger              size;
@property (nonatomic , assign) NSInteger              stargazers_count;
@property (nonatomic , assign) NSInteger              watchers_count;
@property (nonatomic , copy) NSString              * language;
@property (nonatomic , assign) BOOL              has_issues;
@property (nonatomic , assign) BOOL              has_projects;
@property (nonatomic , assign) BOOL              has_downloads;
@property (nonatomic , assign) BOOL              has_wiki;
@property (nonatomic , assign) BOOL              has_pages;
@property (nonatomic , assign) NSInteger              forks_count;
@property (nonatomic , assign) BOOL              archived;
@property (nonatomic , assign) BOOL              disabled;
@property (nonatomic , assign) NSInteger              open_issues_count;
@property (nonatomic , assign) BOOL              allow_forking;
@property (nonatomic , assign) BOOL              is_template;
@property (nonatomic , copy) NSString              * visibility;
@property (nonatomic , assign) NSInteger              forks;
@property (nonatomic , assign) NSInteger              open_issues;
@property (nonatomic , assign) NSInteger              watchers;
@property (nonatomic , copy) NSString              * default_branch;
@property (nonatomic , assign) NSInteger              score;

@end


@interface GCSearchRepositoryResultData :NSObject
@property (nonatomic , assign) NSInteger              total_count;
@property (nonatomic , assign) BOOL              incomplete_results;
@property (nonatomic , strong) NSArray <GCSearchRepositoryResultDatum *>              * items;

@end


NS_ASSUME_NONNULL_END
