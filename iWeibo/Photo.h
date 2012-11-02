//
//  Photo.h
//  iWeibo
//
//  Created by Steve on 11/2/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import "BaseModel.h"

@interface Photo : BaseModel

@property(nonatomic,strong)NSString *url;
@property (nonatomic, strong)NSString *path;
@property (nonatomic, strong)UIImage *image;

/*!
 *  @abstract initialize with data
 *
 *  @discussion
 *	This method is used to initialize photo with provided data
 *
 *  @param data
 *      dict data of photo
 */
-(id)initWithData:(NSDictionary *)data;

/*!
 *  @abstract initialize with data
 *
 *  @discussion
 *	This method is used to initialize photo with provided data
 *
 *  @param data
 *      dict data of photo
 */
-(id)initWithData:(NSDictionary *)data
     autoDownload:(BOOL) flag;

/*!
 *  @abstract download photo
 *
 *  @discussion
 *	This method is used to download the photo
 *
 */
-(void)download:(RequestCompleteBlock) completionHandler
onDownloadProgressChanged:(MKNKProgressBlock) downloadProgressHandler
        onError:(RequestErrorBlock) errorHandler;

@end
