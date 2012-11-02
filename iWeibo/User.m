//
//  User.m
//  iWeibo
//
//  Created by Steve on 11/2/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import "User.h"

@implementation User

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


-(id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
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
    return self;
}
@end
