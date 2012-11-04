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
    currentFeed = feed;
    _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 4, 40, 40)];
    _avatarView.backgroundColor = [UIColor grayColor];
   // [self addSubview:_avatarView];
    [self downloadPhoto];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(57, 4, 250, 18.0)];\
    _nameLabel.textColor = [UIColor colorWithRed:0.33f green:0.33f blue:0.33f alpha:1.00f];
    _nameLabel.text = feed.feed_user.screen_name;
    _nameLabel.font = [UIFont systemFontOfSize:18.0];
    _nameLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_nameLabel];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(57-5, 22, 250, [self cellHeight:feed.text width:250-10 font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0]])];
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


-(void)downloadPhoto
{
    Photo *photo = [[Photo alloc] init];
    photo.url = currentFeed.feed_user.profile_image_url;
    [photo download:^(NSDictionary *pdata){
        
        _avatarView.image = photo.image;
        [self addSubview:_avatarView];
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
