//
//  UIFeedListCell.m
//  iWeibo
//
//  Created by Steve on 11/3/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import "UIFeedListCell.h"

@implementation UIFeedListCell

@synthesize avatarView = _avatarView;
@synthesize nameLabel = _nameLabel;
@synthesize textView = _textView;

-(void)setupCell:(Feed *)feed
{
    _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 4, 40, 40)];
    _avatarView.backgroundColor = [UIColor grayColor];
    [self addSubview:_avatarView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(57, 4, 250, 18.0)];
    _nameLabel.text = feed.feed_user.screen_name;
    _nameLabel.font = [UIFont systemFontOfSize:18.0];
    [self addSubview:_nameLabel];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(57-5, 16, 250, [self cellHeight:feed.text width:250-10 font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0]])];
    _textView.text = feed.text;
    _textView.editable = NO;
    _textView.scrollEnabled = NO;
    _textView.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0];
    _textView.backgroundColor = [UIColor clearColor];
    [self addSubview:_textView];
    
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

//calculate text height。
-(CGFloat)cellHeight:(NSString*)contentText width:(CGFloat)width font:(UIFont *)font
{
    if ([contentText length] == 0) {
        return 12;
    }
    CGSize size=[contentText sizeWithFont:font constrainedToSize:CGSizeMake(width-5, CGFLOAT_MAX) lineBreakMode:0];
    CGFloat height = size.height + 22;
    return height;
}

@end
