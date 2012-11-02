//
//  mclAppDelegate.m
//  iWeibo
//
//  Created by Steve on 10/10/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

@synthesize postListNavController = _postListNavController;
@synthesize notificationNavController = _notificationNavController;
@synthesize friendsNavController = _friendsNavController;
@synthesize moreNavController = _moreNavController;

@synthesize postListViewController = _postListViewController;
@synthesize notificationViewController = _notificationViewController;
@synthesize friendsViewController = _friendsViewController;
@synthesize moreViewController = _moreViewController;

@synthesize tabBarController = _tabBarController;

@synthesize sinaAPI = _sinaAPI;

+(AppDelegate*)sharedAppDelegate
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    NSMutableDictionary *headerFields = [NSMutableDictionary dictionary];
    [headerFields setValue:@"iOS"
                    forKey:@"x-client-identifier"];
    [headerFields setValue:[NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]
                    forKey:@"x-client-version"];
    _sinaAPI = [[SinaAPI alloc] initWithHostName:HOSTS customHeaderFields:headerFields];
    NSString *authToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"SinaAccessToken"];
    if (authToken == nil) {
        [self setUpMainUI];
    }else {
       [self setUpMainUI]; 
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)setUpMainUI
{
    _postListViewController = [[PostListViewController alloc] initWithStyle:UITableViewStylePlain];
    _notificationViewController = [[NotificationViewController alloc] initWithStyle:UITableViewStylePlain];
    _friendsViewController = [[FriendsViewController alloc] initWithNibName:nil bundle:nil];
    _moreViewController = [[MoreViewController alloc] initWithNibName:nil bundle:nil];
    
    _postListNavController = [[UINavigationController alloc] initWithRootViewController:_postListViewController];
    _notificationNavController = [[UINavigationController alloc] initWithRootViewController:_notificationViewController];
    _friendsNavController = [[UINavigationController alloc] initWithRootViewController:_friendsViewController];
    _moreNavController = [[UINavigationController alloc] initWithRootViewController:_moreViewController];
    
    NSArray *controllers = [[NSArray alloc] initWithObjects:_postListNavController,_notificationNavController,_friendsNavController,_moreNavController, nil];
    _tabBarController = [[UITabBarController alloc] init];
    [_tabBarController setViewControllers:controllers];
    self.window.rootViewController = _tabBarController;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
