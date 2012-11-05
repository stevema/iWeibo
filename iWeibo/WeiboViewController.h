//
//  weiboViewController.h
//  iWeibo
//
//  Created by Steve on 11/5/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Feed.h"

@interface WeiboViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    AppDelegate *delegate;
}
@property(nonatomic,strong)Feed *feed;
@property(nonatomic,strong)UIView *userInfoView;
@property(nonatomic,strong)UIImageView *avatarView;
@property(nonatomic,strong)UITableView *mainContentView;
@end
