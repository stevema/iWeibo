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

@synthesize feeds = _feeds;

-(id)init
{
    self = [super init];
    _feeds = [[NSMutableArray alloc] init];
    return self;
}

-(void) getUserInfo:(NSMutableDictionary *) filters
         onComplete:(RequestCompleteBlock) completionHandler
            onError:(RequestErrorBlock) errorHandler;
{
    [[self api] getUserInfo:filters onComplete:^(NSDictionary *data){
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

         completionHandler(data);
    } onError:^(NSString *msg){
         errorHandler(msg);
    } ssl:YES];
}

-(id)initWithData:(NSDictionary *)data
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
    return self;
}

-(void) listOpenWeibo:(NSMutableDictionary *) filters
           onComplete:(RequestCompleteBlock) completionHandler
              onError:(RequestErrorBlock) errorHandler;
{
    [[self api] listOpenWeibo:filters onComplete:^(NSDictionary *data){
        NSMutableArray *items = [[NSMutableArray alloc] initWithArray:[data valueForKey:@"statuses"]];
        for (int i=0; i<[items count]; i++) {
            if ([filters objectForKey:@"max_id"] && i == 0) {
                
            }else if ([filters objectForKey:@"since_id"]) {
                Feed *feed = [[Feed alloc] initWithData:[items objectAtIndex:i]];
                [_feeds insertObject:feed atIndex:i];
            }else {
                Feed *feed = [[Feed alloc] initWithData:[items objectAtIndex:i]];
                [_feeds addObject:feed];
            }
            
        }
        completionHandler(data);
    } onError:^(NSString *msg){
        errorHandler(msg);
    } ssl:YES];
}
@end
