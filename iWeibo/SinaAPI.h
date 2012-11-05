//
//  SinaAPI.h
//  iWeibo
//
//  Created by Steve on 11/2/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import "MKNetworkEngine.h"

typedef void (^RequestCompleteBlock)(NSDictionary *data);
typedef void (^RequestErrorBlock)(NSString *msg);

@class SBJsonParser;
@class SBJsonWriter;

@interface SinaAPI : MKNetworkEngine
{
    @private
    SBJsonParser *_parser;
    SBJsonWriter *_writer;
}

@property (nonatomic, strong)NSMutableDictionary *successObject;

-(MKNetworkOperation *)getUserInfo:(NSMutableDictionary *)filters
                          onComplete:(RequestCompleteBlock) completionHandler
                             onError:(RequestErrorBlock) errorHandler
                            ssl:(BOOL)ssl;

-(MKNetworkOperation *)listOpenWeibo:(NSMutableDictionary *)filters
                          onComplete:(RequestCompleteBlock) completionHandler
                             onError:(RequestErrorBlock) errorHandler
                            ssl:(BOOL)ssl;

-(MKNetworkOperation*) downloadFileFrom:(NSString *)url
                                 saveTo:(NSString *)path
                             onComplete:(RequestCompleteBlock) completionHandler
                                onError:(RequestErrorBlock) errorHandler;

-(MKNetworkOperation *)sendWeiboText:(NSMutableDictionary *)filters
                          onComplete:(RequestCompleteBlock) completionHandler
                             onError:(RequestErrorBlock) errorHandler
                                 ssl:(BOOL)ssl;

-(MKNetworkOperation *)deleteWeiboText:(NSMutableDictionary *)filters
                          onComplete:(RequestCompleteBlock) completionHandler
                             onError:(RequestErrorBlock) errorHandler
                                 ssl:(BOOL)ssl;

-(MKNetworkOperation *)getUserFans:(NSMutableDictionary *)filters
                            onComplete:(RequestCompleteBlock) completionHandler
                               onError:(RequestErrorBlock) errorHandler
                                   ssl:(BOOL)ssl;

-(MKNetworkOperation *)getUserFollows:(NSMutableDictionary *)filters
                        onComplete:(RequestCompleteBlock) completionHandler
                           onError:(RequestErrorBlock) errorHandler
                               ssl:(BOOL)ssl;

@end
