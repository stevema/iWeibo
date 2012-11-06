//
//  Feed.m
//  iWeibo
//
//  Created by Steve on 11/2/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import "Feed.h"

@implementation Feed

@synthesize feed_id = _feed_id;
@synthesize created_at = _created_at;
@synthesize text = _text;
@synthesize comments_count = _comments_count;
@synthesize reports_count = _reports_count;
@synthesize feed_user = _feed_user;
@synthesize retweeted_feed = _retweeted_feed;
@synthesize isRetweet = _isRetweet;
@synthesize thumbnail_pic = _thumbnail_pic;
@synthesize bmiddle_pic = _bmiddle_pic;
@synthesize original_pic = _original_pic;
@synthesize comments = _comments;


-(id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        _feed_id = [data valueForKey:@"id"];
        _created_at = [data valueForKey:@"created_at"];
        _text = [data valueForKey:@"text"];
        _comments_count = [[data valueForKey:@"comments_count"] integerValue];
        _reports_count = [[data valueForKey:@"reports_count"] integerValue];
        _feed_user = [[User alloc] initWithData:[data valueForKey:@"user"]];
        NSLog(@"feed user is :%@",_feed_user.screen_name);
        //_feed_user = [[User alloc] initWithData:[[data valueForKey:@"retweeted_status"] valueForKey:@"user"]];
//        if ([data objectForKey:@"retweeted_status"]) {
//            _retweeted_feed = [self initWithData:[data valueForKey:@"retweeted_status"]];
//            _isRetweet = YES;
//        }else {
//            _retweeted_feed = nil;
//            _isRetweet = NO;
//        }
        _thumbnail_pic = [data valueForKey:@"thumbnail_pic"]==nil?nil:[data valueForKey:@"thumbnail_pic"];
        _bmiddle_pic = [data valueForKey:@"bmiddle_pic"]==nil?nil:[data valueForKey:@"bmiddle_pic"];
        _original_pic = [data valueForKey:@"original_pic"]==nil?nil:[data valueForKey:@"original_pic"];
        _comments = [[NSMutableArray alloc] init];
        
    }
    return self;
}

-(void) listComments:(NSMutableDictionary *) filters
          onComplete:(RequestCompleteBlock) completionHandler
             onError:(RequestErrorBlock) errorHandler;
{
    [[self api] listWeiboComments:filters onComplete:^(NSDictionary *data){
        _comments = [data valueForKey:@"comments"];
        completionHandler(data);
    } onError:^(NSString *msg){
        errorHandler(msg);
    } ssl:YES];
}

@end
