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
@synthesize feed_user = _feed_user;
@synthesize retweeted_feed = _retweeted_feed;
@synthesize isRetweet = _isRetweet;

-(id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        _feed_id = [data valueForKey:@"id"];
        _created_at = [data valueForKey:@"created_at"];
        _text = [data valueForKey:@"text"];
        _comments_count = [[data valueForKey:@"comments_count"] integerValue];
        _feed_user = [[User alloc] initWithData:[data valueForKey:@"user"]];
        if ([data objectForKey:@"retweeted_status"]) {
            _retweeted_feed = [self initWithData:[data valueForKey:@"retweeted_status"]];
            _isRetweet = YES;
        }else {
            _retweeted_feed = nil;
            _isRetweet = NO;
        }
        
    }
    return self;
}
@end
