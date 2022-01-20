#import <Foundation/Foundation.h>

@interface Owner :NSObject
@property (nonatomic , copy) NSString              * login;
@property (nonatomic , assign) NSInteger              id_;
@property (nonatomic , copy) NSString              * node_id;
@property (nonatomic , copy) NSString              * avatar_url;
@property (nonatomic , copy) NSString              * gravatar_id;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * html_url;
@property (nonatomic , copy) NSString              * followers_url;
@property (nonatomic , copy) NSString              * following_url;
@property (nonatomic , copy) NSString              * gists_url;
@property (nonatomic , copy) NSString              * starred_url;
@property (nonatomic , copy) NSString              * subscriptions_url;
@property (nonatomic , copy) NSString              * organizations_url;
@property (nonatomic , copy) NSString              * repos_url;
@property (nonatomic , copy) NSString              * events_url;
@property (nonatomic , copy) NSString              * received_events_url;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , assign) BOOL              site_admin;

@end


@interface License :NSObject
@property (nonatomic , copy) NSString              * key;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * spdx_id;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * node_id;

@end


@interface Permissions :NSObject
@property (nonatomic , assign) BOOL              admin;
@property (nonatomic , assign) BOOL              maintain;
@property (nonatomic , assign) BOOL              push;
@property (nonatomic , assign) BOOL              triage;
@property (nonatomic , assign) BOOL              pull;

@end


@interface GCRepositoryListDatum :NSObject
@property (nonatomic , assign) NSInteger              id_;
@property (nonatomic , copy) NSString              * node_id;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * full_name;
@property (nonatomic , assign) BOOL              private_;
@property (nonatomic , strong) Owner              * owner;
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
@property (nonatomic , assign) NSString            * stargazers_count;
@property (nonatomic , assign) NSInteger              watchers_count;
@property (nonatomic , assign) BOOL              has_issues;
@property (nonatomic , assign) BOOL              has_projects;
@property (nonatomic , assign) BOOL              has_downloads;
@property (nonatomic , assign) BOOL              has_wiki;
@property (nonatomic , assign) BOOL              has_pages;
@property (nonatomic , assign) NSString          *forks_count;
@property (nonatomic , assign) BOOL              archived;
@property (nonatomic , assign) BOOL              disabled;
@property (nonatomic , assign) NSInteger              open_issues_count;
@property (nonatomic , strong) License              * license;
@property (nonatomic , assign) BOOL              allow_forking;
@property (nonatomic , assign) BOOL              is_template;
@property (nonatomic , copy) NSString              * visibility;
@property (nonatomic , assign) NSInteger              forks;
@property (nonatomic , assign) NSInteger              open_issues;
@property (nonatomic , assign) NSInteger              watchers;
@property (nonatomic , copy) NSString              * default_branch;
@property (nonatomic , strong) Permissions              * permissions;

@end

typedef NSArray<GCRepositoryListDatum*> GCRepositoryListData;
