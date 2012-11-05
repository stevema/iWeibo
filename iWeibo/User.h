//
//  User.h
//  iWeibo
//
//  Created by Steve on 11/2/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "Feed.h"

@interface User :BaseModel

@property(nonatomic,strong)NSString *access_token;
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *screen_name;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *description;
@property(nonatomic,strong)NSString *profile_image_url;
@property(nonatomic,strong)NSString *gender;
@property(nonatomic)int followers_count;
@property(nonatomic)int friends_count;
@property(nonatomic)int statuses_count;
@property(nonatomic)int favourites_count;
@property(nonatomic,strong)NSString *avatar_large;
@property(nonatomic,strong)NSMutableArray *feeds;

-(id)initWithData:(NSDictionary *)data;

-(void) getUserInfo:(NSMutableDictionary *) filters
          onComplete:(RequestCompleteBlock) completionHandler
             onError:(RequestErrorBlock) errorHandler;

-(void) listOpenWeibo:(NSMutableDictionary *) filters
         onComplete:(RequestCompleteBlock) completionHandler
            onError:(RequestErrorBlock) errorHandler;

-(void) sendWeiboText:(NSMutableDictionary *) filters
           onComplete:(RequestCompleteBlock) completionHandler
              onError:(RequestErrorBlock) errorHandler;
@end
