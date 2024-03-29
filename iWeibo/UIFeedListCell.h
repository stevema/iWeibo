//
//  UIFeedListCell.h
//  iWeibo
//
//  Created by Steve on 11/3/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Feed.h"


@interface UIFeedListCell : UITableViewCell
{
    Feed *currentFeed;
    AppDelegate *delegate;
    UIScrollView *showImageView;
    UIView *contentView;
}
@property(nonatomic,strong)UIImageView *avatarView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UITextView *textView;
-(void)setupCell:(Feed *)feed;

@end
