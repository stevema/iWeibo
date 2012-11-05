//
//  SinaAPI.m
//  iWeibo
//
//  Created by Steve on 11/2/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import "SinaAPI.h"
#import "SBJson.h"

@implementation SinaAPI

@synthesize successObject = _successObject;

-(id)initWithHostName:(NSString *)hostName
              apiPath:(NSString *)apiPath
   customHeaderFields:(NSMutableDictionary *)headers;
{
    _parser = [[SBJsonParser alloc] init];
    _successObject = [[NSMutableDictionary alloc] init];
    [_successObject setValue:@"true" forKey:@"success"];
    
    return [super initWithHostName:hostName
                           apiPath:apiPath
                customHeaderFields:headers];
}

-(NSDictionary*) parseResponseWithOperation:(MKNetworkOperation *) operation
{
    return [self parseResponseWithOperation:operation useCachedData:NO];
    
}

-(NSDictionary*) parseResponseWithOperation:(MKNetworkOperation *) operation useCachedData:(BOOL)flag;
{
    NSString *response = [operation responseString];
    NSDictionary *data = [_parser objectWithString:response];
    
    if (!flag && operation.isCachedResponse)
    {
        return nil;
    }
    
    return data;
}

-(MKNetworkOperation*) sendOperation:(MKNetworkOperation*) operation;
{
    
    [self enqueueOperation:operation];
    
    return operation;
}

-(MKNetworkOperation *)getUserInfo:(NSMutableDictionary *)filters
                        onComplete:(RequestCompleteBlock) completionHandler
                           onError:(RequestErrorBlock) errorHandler
                            ssl:(BOOL)ssl;
{
    NSString *url = [[NSString alloc] initWithFormat:@"users/show.json"];
    
    MKNetworkOperation *op = [self operationWithPath:url
                                              params:filters
                                          httpMethod:@"GET"
                              ssl:ssl];
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary *data = [self parseResponseWithOperation:completedOperation];
        
        if (data!=nil)
        {
            completionHandler(data);
        }
        
        
    } onError:^(NSError *error) {
        
        errorHandler(@"Request Error");
        
    }];
    
    return [self sendOperation:op];
}


-(MKNetworkOperation *)listOpenWeibo:(NSMutableDictionary *)filters
                          onComplete:(RequestCompleteBlock) completionHandler
                             onError:(RequestErrorBlock) errorHandler
                            ssl:(BOOL)ssl;
{
    NSString *url = [[NSString alloc] initWithFormat:@"statuses/home_timeline.json"];
    
    MKNetworkOperation *op = [self operationWithPath:url
                                              params:filters
                                          httpMethod:@"GET"
                                                 ssl:ssl];
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary *data = [self parseResponseWithOperation:completedOperation];
        
        if (data!=nil)
        {
            completionHandler(data);
        }
        
        
    } onError:^(NSError *error) {
        
        errorHandler(@"Request Error");
        
    }];
    
    return [self sendOperation:op];
}

-(MKNetworkOperation *)sendWeiboText:(NSMutableDictionary *)filters
                          onComplete:(RequestCompleteBlock) completionHandler
                             onError:(RequestErrorBlock) errorHandler
                                 ssl:(BOOL)ssl;
{
    NSString *url = [[NSString alloc] initWithFormat:@"statuses/update.json"];
    NSLog(@"filters is :%@",filters);
    MKNetworkOperation *op = [self operationWithPath:url
                                              params:filters
                                          httpMethod:@"POST"
                                                 ssl:ssl];
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary *data = [self parseResponseWithOperation:completedOperation];
        
        if (data!=nil)
        {
            completionHandler(data);
        }
        
        
    } onError:^(NSError *error) {
        
        errorHandler(@"Request Error");
        
    }];
    
    return [self sendOperation:op];
}

-(MKNetworkOperation*) downloadFileFrom:(NSString *)url
                                 saveTo:(NSString *)path
                             onComplete:(RequestCompleteBlock) completionHandler
                                onError:(RequestErrorBlock) errorHandler;
{
    MKNetworkOperation *op = [self operationWithURLString:url
                                                   params:nil
                                               httpMethod:@"GET"];
    
    [op addDownloadStream:[NSOutputStream outputStreamToFileAtPath:path
                                                            append:YES]];
    
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        
        completionHandler(_successObject);
        
    } onError:^(NSError *error) {
        
        errorHandler(@"Request Error");
        
    }];
    
    [self enqueueOperation:op];
    return op;
}

@end
