//
//  confige.h
//  GithubClient
//
//  Created by bytedance on 2022/1/12.
//  Copyright © 2022 iosByYH. All rights reserved.
//
#import <UIKit/UIKit.h>

#ifndef configure_h
#define configure_h

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define CommonBackGroundColor UIColorFromRGB(0xFAFAFA)

#pragma mark-- loginPage
#define loginPage_TextField_Font_Size 100
#define loginPage_TextField_Font_Color [UIColor whiteColor]
#define loginPage_TextField_Background_Color [UIColor grayColor]

#define loginPage_Login_Btn_Font_Size 40
#define loginPage_Login_Btn_Font_Color [UIColor whiteColor]
#define loginPage_Login_Btn_Font_Background_Color [UIColor grayColor]

#define TabBarPage_Background_color UIColorFromRGB(0xFAFAFA)
#define TabBarPage_Element_Background_Color [UIColor whiteColor]
#define TabBarPage_TextColor [UIColor blackColor]


#pragma mark - WorkSpace
#define WorkSpace_TopTitle_Font [UIFont fontWithName:@"Helvetica" size:27]
#define WorkSpace_Section_Font [UIFont fontWithName:@"Helvetica-bold" size:25]
#define WorkSpaceCell_Title_Font [UIFont fontWithName:@"Helvetica" size:20]

#define WorkSpace_TopTitle_TextColor [UIColor blackColor]
#define WorkSpace_Section_TextColor [UIColor blackColor]
#define WorkSpaceCell_Title_TextColor [UIColor blackColor]

#pragma mark - RepositoryList
#define RepositoryList_username_font [UIFont fontWithName:@"Helvetica" size:12]
#define RepositoryList_username_TextColor [UIColor blackColor]

#define RepositoryList_repositoryName_font [UIFont fontWithName:@"Helvetica-bold" size:15]
#define RepositoryList_repositoryName_textColor [UIColor blackColor]

#define RepositoryList_language_font [UIFont fontWithName:@"Helvetica" size:12]
#define RepositoryList_language_textColor [UIColor blackColor]

#define RepositoryList_description_font [UIFont fontWithName:@"Helvetica" size:12]
#define RepositoryList_description_textColor [UIColor grayColor]

#define RepositoryList_star_font [UIFont fontWithName:@"Helvetica" size:12]
#define RepositoryList_star_textColor [UIColor grayColor]

#define RepositoryList_fork_font [UIFont fontWithName:@"Helvetica" size:12]
#define RepositoryList_fork_textColor [UIColor grayColor]

#pragma mark - Repository
#define repository_backgroundColor UIColorFromRGB(0xFAFAFA)

#define repository_subView_backgroundColor [UIColor whiteColor]

#define repository_topButton_backgroundColor UIColorFromRGB(0xFAFAFA)
#define repository_topButton_textFont [UIFont fontWithName:@"Helvetica-bold" size:12]
#define repository_topButton_textColor [UIColor blackColor]

#define repository_fullName_backgroundColor [UIColor clearColor]
#define repository_fullName_textFont [UIFont fontWithName:@"Helvetica-bold" size:14]
#define repository_fullName_textColor [UIColor blackColor]

#define repository_updateTime_backgroundColor [UIColor clearColor]
#define repository_updateTime_textFont [UIFont fontWithName:@"Helvetica" size:11]
#define repository_updateTime_textColor [UIColor grayColor]

#define repository_description_backgroundColor [UIColor clearColor]
#define repository_description_textFont [UIFont fontWithName:@"Helvetica" size:13]
#define repository_description_textColor [UIColor grayColor]

#define repository_bottomButton_backgroundColor [UIColor clearColor]
#define repository_bottomButton_textFont [UIFont fontWithName:@"Helvetica-bold" size:14]
#define repository_bottomButton_textColor [UIColor blackColor]

#define repository_actionBar_backgroundColor [UIColor whiteColor]
#define repository_actionBar_title_textColor [UIColor blackColor]
#define repository_actionBar_title_textFont [UIFont fontWithName:@"Helvetica-bold" size:17]
#define repository_actionBar_tail_textColor [UIColor grayColor]
#define repository_actionBar_tail_textFont [UIFont fontWithName:@"Helvetica" size:14]

#define folder_fileName_textColor [UIColor blackColor]
#define folder_fileName_textFont [UIFont fontWithName:@"Helvetica-bold" size:15]

#define search_result_filterLabel_textColor [UIColor grayColor]
#define search_result_filterLabel_selected_textColor [UIColor blackColor]
#endif /* configure_h */
