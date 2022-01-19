//
//  confige.h
//  GithubClient
//
//  Created by bytedance on 2022/1/12.
//  Copyright © 2022 iosByYH. All rights reserved.
//
#import <UIKit/UIKit.h>

#ifndef configure.h
#define configure_h

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

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
#endif /* configure_h */
