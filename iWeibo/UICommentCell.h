//
//  UICommentCell.h
//  iWeibo
//
//  Created by Steve on 11/5/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Feed.h"

@interface UICommentCell : UITableViewCell

-(void)setupCell:(Feed *)feed atIndex:(int)index;
@end
