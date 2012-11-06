//
//  UICommentCell.m
//  iWeibo
//
//  Created by Steve on 11/5/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import "UICommentCell.h"
#import "Photo.h"
#import "Comment.h"

@implementation UICommentCell

-(void)setupCell:(Feed *)feed atIndex:(int)index;
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (index == 0) {
        CGFloat height = 0.0;
        CGFloat textHeight = [self cellHeight:feed.text width:296 font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0]];
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 2, 305, textHeight)];
        textView.text = feed.text;
        textView.textColor = [UIColor colorWithRed:0.33f green:0.33f blue:0.33f alpha:1.00f];
        textView.editable = NO;
        textView.scrollEnabled = NO;
        textView.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0];
        textView.userInteractionEnabled = NO;
        textView.backgroundColor = [UIColor clearColor];
        [self addSubview:textView];
        
        height = textHeight + 22;
        
        if (feed.thumbnail_pic) {
            // UIImageView *feedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(57, 22+textHeight+10, 200, 60)];
            UIImageView *feedImageView = [[UIImageView alloc] init];
            [self downloadPhoto:feed.thumbnail_pic onView:feedImageView withHeight:(22+textHeight)];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigPhoto)];
            feedImageView.userInteractionEnabled = YES;
            [feedImageView addGestureRecognizer:tap];
            [self addSubview:feedImageView];
            height = height + 60;
        }
        
        UILabel *metaLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, height, 100, 13.0)];
        metaLabel.text = [NSString stringWithFormat:@"转发:%d|评论:%d",feed.reports_count,feed.comments_count];
        metaLabel.font = [UIFont systemFontOfSize:12.0];
        metaLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:metaLabel];
        
    }else {
        Comment *comment = [[Comment alloc] initWithData:[feed.comments objectAtIndex:index-1]];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 6, 200, 18.0)];
        nameLabel.text = comment.user.screen_name;
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor colorWithRed:0.33f green:0.33f blue:0.33f alpha:1.00f];
        [self addSubview:nameLabel];
        
        CGFloat textHeight = [self cellHeight:comment.text width:296 font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0]];
        UITextView *commentView = [[UITextView alloc] initWithFrame:CGRectMake(10, 25, 305, textHeight)];
        commentView.text = comment.text;
        commentView.backgroundColor = [UIColor clearColor];
        commentView.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0];
        [self addSubview:commentView];
    }
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
        imageView.frame = CGRectMake(15, imageHeight, width, 60);
        [self addSubview:imageView];
    }
onDownloadProgressChanged:^(double progress) {
    
}
            onError:^(NSString *msg){
                
            }];
    
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
