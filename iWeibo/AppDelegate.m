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
@synthesize appViewController = _appViewController;
@synthesize friendsNavController = _friendsNavController;
@synthesize moreNavController = _moreNavController;

@synthesize postListViewController = _postListViewController;
@synthesize notificationViewController = _notificationViewController;
@synthesize appNavController = _appNavController;
@synthesize friendsViewController = _friendsViewController;
@synthesize moreViewController = _moreViewController;

@synthesize tabBarController = _tabBarController;

@synthesize sinaAPI = _sinaAPI;
@synthesize user = _user;

@synthesize weibo = _weibo;

@synthesize splashView = _splashView;

+(AppDelegate*)sharedAppDelegate
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    _splashView = [[UIImageView alloc] initWithFrame:self.window.frame];
    _splashView.image = [UIImage imageNamed:@"Default"];
    [self.window addSubview:_splashView];
    [self.window makeKeyAndVisible];

    NSMutableDictionary *headerFields = [NSMutableDictionary dictionary];
    [headerFields setValue:@"iOS"
                    forKey:@"x-client-identifier"];
    [headerFields setValue:[NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]
                    forKey:@"x-client-version"];
    _sinaAPI = [[SinaAPI alloc] initWithHostName:HOSTS customHeaderFields:headerFields];
    [_sinaAPI useCache];
    _user = [[User alloc] init];
    _weibo = [[SinaWeibo alloc] initWithAppKey:APP_KEY appSecret:APP_SCRRET appRedirectURI:@"http://weibo.com/chunlinpage" ssoCallbackScheme:@"sinaweibosso562653073" andDelegate:self];
    
    
    //NSString *authToken = [[[NSUserDefaults standardUserDefaults] objectForKey:@"authData"] valueForKey:@"accessToken"];
    NSDictionary *authData = [[NSUserDefaults standardUserDefaults] objectForKey:@"authData"];
    
    NSLog(@"access token is :%@",[authData valueForKey:@"accessToken"]);
   
    if ([authData valueForKey:@"accessToken"] == nil ) {
        [_weibo logIn];
    }else {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        [format setTimeZone:gmt];
        [format setDateFormat:@"yy-MM-dd HH:mm:ss Z"];
        NSLog(@"auth exp date is :%@",[authData valueForKey:@"expDate"]);
        NSDate *date = [format dateFromString:[NSString stringWithFormat:@"%@",[authData valueForKey:@"expDate"]]];
        NSTimeInterval timeInt = [date timeIntervalSince1970];
        NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
        if (now > timeInt) {
            [_weibo logIn];
        }else {
            _user.access_token = [authData valueForKey:@"accessToken"];
            _user.user_id = [authData valueForKey:@"userID"];
            [self setUpMainUI];
        }
         
    }
    
    
    return YES;
}

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    [self storeAuthData];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [_weibo handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [_weibo handleOpenURL:url];
}

- (void)storeAuthData
{
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              _weibo.accessToken, @"accessToken",
                              _weibo.expirationDate, @"expDate",
                              _weibo.userID, @"userID",
                              _weibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"authData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    _user.access_token = _weibo.accessToken;
    _user.user_id = _weibo.userID ;
    [self setUpMainUI];
}

-(void)setUpMainUI
{
    NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];
    [filters setValue:_user.access_token forKey:@"access_token"];
    [filters setValue:[NSString stringWithFormat:@"%@",_user.user_id] forKey:@"uid"];
    [_user getUserInfo:filters onComplete:^(NSDictionary *data){
        [_splashView removeFromSuperview];
        _postListViewController = [[PostListViewController alloc] initWithStyle:UITableViewStylePlain];
        _notificationViewController = [[NotificationViewController alloc] initWithStyle:UITableViewStylePlain];
        _appViewController = [[AppViewController alloc] initWithNibName:nil bundle:nil];
        _friendsViewController = [[FriendsViewController alloc] initWithNibName:nil bundle:nil];
        _moreViewController = [[MoreViewController alloc] initWithNibName:nil bundle:nil];
        
        _postListNavController = [[UINavigationController alloc] initWithRootViewController:_postListViewController];
        _notificationNavController = [[UINavigationController alloc] initWithRootViewController:_notificationViewController];
        _appNavController = [[UINavigationController alloc] initWithRootViewController:_appViewController];
        _friendsNavController = [[UINavigationController alloc] initWithRootViewController:_friendsViewController];
        _moreNavController = [[UINavigationController alloc] initWithRootViewController:_moreViewController];
        
        NSArray *controllers = [[NSArray alloc] initWithObjects:_postListNavController,_notificationNavController,_appNavController,_friendsNavController,_moreNavController, nil];
        _tabBarController = [[UITabBarController alloc] init];
        [_tabBarController setViewControllers:controllers];
        [_tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tob-bg"]];
        //_tabBarController.tabBar.hidden = YES;
        self.window.rootViewController = _tabBarController;
        
        
        
    } onError:^(NSString *msg){
        
    }];
    
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
