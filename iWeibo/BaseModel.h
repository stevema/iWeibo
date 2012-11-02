//
//  BaseModel.h
//  iWeibo
//
//  Created by Steve on 11/2/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SinaAPI.h"

@interface BaseModel : NSObject

@property(nonatomic,strong)NSString *pk;
@property(nonatomic,strong)SinaAPI *api;
@end
