//
//  Comment.h
//  iWeibo
//
//  Created by Steve on 11/5/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import "BaseModel.h"
#import "User.h"

@interface Comment : BaseModel

@property(nonatomic,strong)NSString *created_at;
@property(nonatomic,strong)NSString *comment_id;
@property(nonatomic,strong)NSString *text;
@property(nonatomic,strong)User *user;
@end
