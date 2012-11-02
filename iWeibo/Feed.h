//
//  Feed.h
//  iWeibo
//
//  Created by Steve on 11/2/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import "BaseModel.h"
#import "User.h"

@class User;
@interface Feed : BaseModel

@property(nonatomic,strong)NSString *text;
@property(nonatomic,strong)NSString *created_at;
@property(nonatomic,strong)NSString *feed_id;
@property(nonatomic)int comments_count;
@property(nonatomic,strong)User *feed_user;
@property(nonatomic,strong)Feed *retweeted_feed;

-(id)initWithData:(NSDictionary *)data;
@end
