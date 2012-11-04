//
//  UIFeedListCell.m
//  iWeibo
//
//  Created by Steve on 11/3/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import "UIFeedListCell.h"
#import "Photo.h"

@implementation UIFeedListCell

@synthesize avatarView = _avatarView;
@synthesize nameLabel = _nameLabel;
@synthesize textView = _textView;

-(void)setupCell:(Feed *)feed
{
    _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 4, 40, 40)];
    _avatarView.backgroundColor = [UIColor grayColor];
   // [self addSubview:_avatarView];
    [self downloadPhotoWithUrl:feed.feed_user.profile_image_url onView:_avatarView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(57, 4, 250, 18.0)];\
    _nameLabel.textColor = [UIColor colorWithRed:0.33f green:0.33f blue:0.33f alpha:1.00f];
    _nameLabel.text = feed.feed_user.screen_name;
    _nameLabel.font = [UIFont systemFontOfSize:18.0];
    _nameLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_nameLabel];
    
    CGFloat textHeight = [self cellHeight:feed.text width:250-10 font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0]];
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(57-5, 22, 250, textHeight)];
    _textView.text = feed.text;
    _textView.textColor = [UIColor colorWithRed:0.33f green:0.33f blue:0.33f alpha:1.00f];
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
    }
    
}

-(void)setupCell;
{
    
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
