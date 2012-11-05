//
//  Comment.m
//  iWeibo
//
//  Created by Steve on 11/5/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import "Comment.h"

@implementation Comment

@synthesize created_at = _created_at;
@synthesize comment_id = _comment_id;
@synthesize text = _text;
@synthesize user = _user;

-(id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        _created_at = [data valueForKey:@"create_at"];
        _comment_id = [data valueForKey:@"id"];
        _text = [data valueForKey:@"text"];
        _user = [[User alloc] initWithData:[data valueForKey:@"user"]];
    }
    return self;
}
@end
