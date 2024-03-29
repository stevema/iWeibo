//
//  UIFeedListCell.m
//  iWeibo
//
//  Created by Steve on 11/3/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "UIFeedListCell.h"
#import "Photo.h"
#import "UISummaryPhotoView.h"

@implementation UIFeedListCell

static const NSTimeInterval kAnimationDuration = 0.40f;

@synthesize avatarView = _avatarView;
@synthesize nameLabel = _nameLabel;
@synthesize textView = _textView;

-(void)setupCell:(Feed *)feed
{
    self.backgroundColor = [UIColor clearColor];
    currentFeed = feed;
    delegate = [AppDelegate sharedAppDelegate];
    contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor colorWithRed:((double)arc4random() / ARC4RANDOM_MAX) green:((double)arc4random() / ARC4RANDOM_MAX) blue:((double)arc4random() / ARC4RANDOM_MAX) alpha:0.8];
    //[self addSubview:contentView];
    
    _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 4, 40, 40)];
    _avatarView.backgroundColor = [UIColor grayColor];
   // [self addSubview:_avatarView];
    [self downloadPhotoWithUrl:feed.feed_user.profile_image_url onView:_avatarView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(57, 4, 250, 18.0)];
    _nameLabel.textColor = [UIColor colorWithRed:0.33f green:0.33f blue:0.33f alpha:1.00f];
    //_nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.text = feed.feed_user.screen_name;
    _nameLabel.font = [UIFont systemFontOfSize:18.0];
    _nameLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_nameLabel];
    
    CGFloat textHeight = [self cellHeight:feed.text width:250 font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0]];
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(57-5, 22, 260, textHeight)];
    _textView.text = feed.text;
    _textView.textColor = [UIColor colorWithRed:0.33f green:0.33f blue:0.33f alpha:1.00f];
   // _textView.textColor = [UIColor whiteColor];
    _textView.editable = NO;
    _textView.scrollEnabled = NO;
    _textView.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.userInteractionEnabled = NO;
    _textView.backgroundColor = [UIColor clearColor];
    [self addSubview:_textView];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (feed.thumbnail_pic) {
       // UIImageView *feedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(57, 22+textHeight+10, 200, 60)];
        UIImageView *feedImageView = [[UIImageView alloc] init];
        [self downloadPhoto:feed.thumbnail_pic onView:feedImageView withHeight:(22+textHeight)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigPhoto)];
        feedImageView.userInteractionEnabled = YES;
        [feedImageView addGestureRecognizer:tap];
        contentView.frame = CGRectMake(10, 10, 300, 22+textHeight+60);
    }else {
        contentView.frame = CGRectMake(10, 10, 300, 22+textHeight);
    }
    
}

-(void)showBigPhoto
{
    Photo *photo = [[Photo alloc] init];
    photo.url = currentFeed.original_pic;
    showImageView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,320 , [[UIScreen mainScreen] bounds].size.height)];
    showImageView.backgroundColor = [UIColor blackColor];
    UISummaryPhotoView *summaryImageView = [[UISummaryPhotoView alloc] initWithFrame:CGRectMake(0, 0,320 , [[UIScreen mainScreen] bounds].size.height) withPhoto:photo onScrolView:showImageView];
    CATransition *transition = [CATransition animation];
    transition.duration = kAnimationDuration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFade;
    transition.delegate = self;
    [showImageView.layer addAnimation:transition forKey:nil];
    [showImageView addSubview:summaryImageView];
    [delegate.window addSubview:showImageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSummaryView)];
    showImageView.userInteractionEnabled = YES;
    [showImageView addGestureRecognizer:tap];
}

-(void)removeSummaryView
{
    [showImageView removeFromSuperview];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)downloadPhotoWithUrl:(NSString *)url onView:(UIImageView *)imageView
{
    Photo *photo = [[Photo alloc] init];
    photo.url = url;
    [photo download:^(NSDictionary *pdata){
        
        imageView.image = photo.image;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
    }
onDownloadProgressChanged:^(double progress) {
    
}
            onError:^(NSString *msg){
                
            }];
    
}

-(void)downloadPhoto:(NSString *)url onView:(UIImageView *)imageView withHeight:(CGFloat)imageHeight
{
    Photo *photo = [[Photo alloc] init];
    photo.url = url;
    [photo download:^(NSDictionary *pdata){
        
        imageView.image = photo.image;
        CGFloat vs = photo.image.size.width / photo.image.size.height;
        CGFloat height = 60.0;
        CGFloat width = height * vs;
        imageView.frame = CGRectMake(57, imageHeight, width, 60);
        [self addSubview:imageView];
    }
onDownloadProgressChanged:^(double progress) {
    
}
            onError:^(NSString *msg){
                
            }];
    
}

- (void)refreshUserAvatar
{
    if (!_avatarView.image)
    {
        [self performSelector:@selector(refreshUserAvatar) withObject:nil afterDelay:2];
    }
}

//calculate text height。
-(CGFloat)cellHeight:(NSString*)contentText width:(CGFloat)width font:(UIFont *)font
{
    if ([contentText length] == 0) {
        return 12;
    }
    CGSize size=[contentText sizeWithFont:font constrainedToSize:CGSizeMake(width-10, CGFLOAT_MAX) lineBreakMode:0];
    CGFloat height = size.height + 22;
    return height;
}

@end
