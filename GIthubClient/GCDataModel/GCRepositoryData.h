//
//  GCRepositoryData.h
//  GithubClient
//
//  Created by bytedance on 2022/1/20.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCOwner.h"
#import "GCPermissions.h"

NS_ASSUME_NONNULL_BEGIN

@class GCOwner;
@class GCPermissions;

@interface GCRepositoryData :NSObject
@property (nonatomic , assign) NSInteger              id_;
@property (nonatomic , copy) NSString              * node_id;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * full_name;
@property (nonatomic , assign) BOOL              private_;
@property (nonatomic , strong) GCOwner              * owner;
@property (nonatomic , copy) NSString              * html_url;
@property (nonatomic , copy) NSString              * description_;
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
@property (nonatomic , copy) NSString              * homepage;
@property (nonatomic , assign) NSInteger              size;
@property (nonatomic , assign) NSString*              stargazers_count;
@property (nonatomic , assign) NSString*              watchers_count;
@property (nonatomic , copy) NSString              * language;
@property (nonatomic , assign) BOOL              has_issues;
@property (nonatomic , assign) BOOL              has_projects;
@property (nonatomic , assign) BOOL              has_downloads;
@property (nonatomic , assign) BOOL              has_wiki;
@property (nonatomic , assign) BOOL              has_pages;
@property (nonatomic , assign) NSString*              forks_count;
@property (nonatomic , assign) BOOL              archived;
@property (nonatomic , assign) BOOL              disabled;
@property (nonatomic , assign) NSString*              open_issues_count;
@property (nonatomic , assign) BOOL              allow_forking;
@property (nonatomic , assign) BOOL              is_template;
@property (nonatomic , copy) NSString              * visibility;
@property (nonatomic , assign) NSInteger              forks;
@property (nonatomic , assign) NSInteger              open_issues;
@property (nonatomic , assign) NSString*              watchers;
@property (nonatomic , copy) NSString              * default_branch;
@property (nonatomic , strong) GCPermissions              * permissions;
@property (nonatomic , copy) NSString              * temp_clone_token;
@property (nonatomic , assign) BOOL              allow_squash_merge;
@property (nonatomic , assign) BOOL              allow_merge_commit;
@property (nonatomic , assign) BOOL              allow_rebase_merge;
@property (nonatomic , assign) BOOL              allow_auto_merge;
@property (nonatomic , assign) BOOL              delete_branch_on_merge;
@property (nonatomic , assign) BOOL              allow_update_branch;
@property (nonatomic , assign) NSString*              network_count;
@property (nonatomic , assign) NSString*              subscribers_count;

@end

NS_ASSUME_NONNULL_END
