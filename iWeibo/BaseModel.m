//
//  BaseModel.m
//  iWeibo
//
//  Created by Steve on 11/2/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import "BaseModel.h"
#import "AppDelegate.h"

@implementation BaseModel
@synthesize pk = _pk;
@synthesize api = _api;

-(id)init
{
    self = [super init];
    if (self) {
        AppDelegate *delegate = [AppDelegate sharedAppDelegate];
        _api = delegate.sinaAPI;
    }
    return self;
}
@end
