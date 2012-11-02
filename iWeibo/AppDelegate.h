//
//  mclAppDelegate.h
//  iWeibo
//
//  Created by Steve on 10/10/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostListViewController.h"
#import "NotificationViewController.h"
#import "FriendsViewController.h"
#import "MoreViewController.h"
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#import "SinaAPI.h"
#import "User.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,SinaWeiboDelegate,SinaWeiboRequestDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *postListNavController;
@property (strong, nonatomic) UINavigationController *notificationNavController;
@property (strong, nonatomic) UINavigationController *friendsNavController;
@property (strong, nonatomic) UINavigationController *moreNavController;

@property (strong, nonatomic) PostListViewController *postListViewController;
@property (strong, nonatomic) NotificationViewController *notificationViewController;
@property (strong, nonatomic) FriendsViewController *friendsViewController;
@property (strong, nonatomic) MoreViewController *moreViewController;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property(strong, nonatomic) SinaAPI *sinaAPI;
@property(strong, nonatomic) User *user;

@property(strong, nonatomic) SinaWeibo *weibo;


+(AppDelegate*)sharedAppDelegate;
@end
