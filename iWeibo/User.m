//
//  User.m
//  iWeibo
//
//  Created by Steve on 11/2/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize access_token = _access_token;
@synthesize user_id = _user_id;
@synthesize screen_name = _screen_name;
@synthesize name = _name;
@synthesize description = _description;
@synthesize profile_image_url = _profile_image_url;
@synthesize gender = _gender;
@synthesize followers_count = _followers_count;
@synthesize friends_count = _friends_count;
@synthesize statuses_count = _statuses_count;
@synthesize favourites_count = _favourites_count;
@synthesize avatar_large = _avatar_large;

@synthesize feed = _feed;

-(id)init
{
    self = [super init];
    return self;
}

-(void) getUserInfo:(NSMutableDictionary *) filters
         onComplete:(RequestCompleteBlock) completionHandler
            onError:(RequestErrorBlock) errorHandler;
{
    [[self api] getUserInfo:filters onComplete:^(NSDictionary *data){
        [self initWithData:data];
        NSLog(@"data is :%@",_screen_name);
         completionHandler(data);
    } onError:^(NSString *msg){
         errorHandler(msg);
    } ssl:YES];
}

-(void)initWithData:(NSDictionary *)data
{
    _user_id = [data valueForKey:@"id"];
    _screen_name = [data valueForKey:@"screen_name"];
    _name = [data valueForKey:@"name"];
    _description = [data valueForKey:@"description"];
    _profile_image_url = [data valueForKey:@"profile_image_url"];
    _gender = [data valueForKey:@"gender"];
    _followers_count = [[data valueForKey:@"followers_count"] integerValue];
    _statuses_count = [[data valueForKey:@"statuses_count"] integerValue];
    _friends_count = [[data valueForKey:@"friends_count"] integerValue];
    _favourites_count = [[data valueForKey:@"favourites_count"] integerValue];
    _avatar_large = [data valueForKey:@"avatar_large"];
}

-(void) listOpenWeibo:(NSMutableDictionary *) filters
           onComplete:(RequestCompleteBlock) completionHandler
              onError:(RequestErrorBlock) errorHandler;
{
    [[self api] listOpenWeibo:filters onComplete:^(NSDictionary *data){
        completionHandler(data);
    } onError:^(NSString *msg){
        errorHandler(msg);
    } ssl:YES];
}
@end
