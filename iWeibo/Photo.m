//
//  Photo.m
//  iWeibo
//
//  Created by Steve on 11/2/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import "Photo.h"

@implementation Photo

@synthesize url = _url;
@synthesize path = _path;
@synthesize image = _image;

-(id)initWithData:(NSDictionary *)data;
{
    self = [super init];
    
    if (self)
    {
        _url = [data valueForKey:@"url"];
    }
    
    return self;
}

-(id)initWithData:(NSDictionary *)data
     autoDownload:(BOOL) flag;
{
    self = [self initWithData:data];
    if (self && flag == YES)
    {
        [self download:^(NSDictionary *data)
         {
             
         }
onDownloadProgressChanged:^(double progress)
         {
             
         }
               onError:^(NSString *msg)
         {
         }];
    }
    
    return self;
}

-(void)download:(RequestCompleteBlock) completionHandler
onDownloadProgressChanged:(MKNKProgressBlock) downloadProgressHandler
        onError:(RequestErrorBlock) errorHandler;
{
    MKNetworkOperation *op = [self.api imageAtURL:[[NSURL alloc] initWithString:_url]
                                     onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache)
                              {
                                  if([_url isEqualToString:[url absoluteString]]) {
                                      _image = fetchedImage;
                                      completionHandler(self.api.successObject);
                                  }
                              }
                                          onError:^(NSError *error){
                                              errorHandler(@"Failed to download image.");
                                          }];
    
    [op onDownloadProgressChanged:^(double progress)
     {
         downloadProgressHandler(progress);
     }];
}
@end
