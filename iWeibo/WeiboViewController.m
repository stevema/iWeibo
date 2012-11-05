//
//  weiboViewController.m
//  iWeibo
//
//  Created by Steve on 11/5/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import "WeiboViewController.h"
#import "Photo.h"
#import "UIHRuler.h"
#import "UICommentCell.h"
#import "Comment.h"

@interface WeiboViewController ()

@end

@implementation WeiboViewController

@synthesize feed = _feed;
@synthesize userInfoView = _userInfoView;
@synthesize avatarView = _avatarView;
@synthesize mainContentView = _mainContentView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    delegate = [AppDelegate sharedAppDelegate];
    [self listComments];
    
    self.view.backgroundColor = [UIColor colorWithRed:0xF2/255.0 green:0xF2/255.0 blue:0xF2/255.0 alpha:0xFF/255.0];

    UIView *leftBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 40)];
    leftBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"topBar_bg"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarView];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 0, 32, 40);
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"back-bt"] forState:UIControlStateNormal];
    //[backButton setBackgroundImage:[UIImage imageNamed:@"back-bt"] forState:UIControlStateNormal];
    [backButton setContentMode:UIViewContentModeCenter];
    //[addWeiboButton setBackgroundImage:[UIImage imageNamed:@"add_feed_hi"] forState:UIControlStateHighlighted];
    [leftBarView addSubview:backButton];
    
    _userInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 55)];
    _userInfoView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_userInfoView];
    
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    likeButton.frame = CGRectMake(172,29,26,24);
    [likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [likeButton setContentMode:UIViewContentModeCenter];
    [likeButton addTarget:self action:@selector(addLike) forControlEvents:UIControlEventTouchUpInside];
    [_userInfoView addSubview:likeButton];
    
    UIButton *reportButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reportButton.frame = CGRectMake(227,29,26,24);
    [reportButton setImage:[UIImage imageNamed:@"report"] forState:UIControlStateNormal];
    [reportButton setContentMode:UIViewContentModeCenter];
    [reportButton addTarget:self action:@selector(report) forControlEvents:UIControlEventTouchUpInside];
    [_userInfoView addSubview:reportButton];
    
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.frame = CGRectMake(282,29,26,24);
    [commentButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    [commentButton setContentMode:UIViewContentModeCenter];
    [commentButton addTarget:self action:@selector(addComment) forControlEvents:UIControlEventTouchUpInside];
    [_userInfoView addSubview:commentButton];
    
    UIHRuler *ruler = [[UIHRuler alloc] initWithFrame:CGRectMake(0, 55, 320, 1) withPrimaryColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2] withSecondaryColor:[UIColor clearColor]];
    [self.view addSubview:ruler];
    
    _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 4, 40, 40)];
    _avatarView.backgroundColor = [UIColor grayColor];
    [self downloadPhotoWithUrl:_feed.feed_user.profile_image_url onView:_avatarView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(57, 4, 250, 18.0)];
    nameLabel.textColor = [UIColor colorWithRed:0.33f green:0.33f blue:0.33f alpha:1.00f];
    nameLabel.text = _feed.feed_user.screen_name;
    nameLabel.font = [UIFont systemFontOfSize:18.0];
    nameLabel.backgroundColor = [UIColor clearColor];
    [_userInfoView addSubview:nameLabel];
    
    
    
}

-(void)listComments
{
    NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];
    [filters setValue:delegate.user.access_token forKey:@"access_token"];
    [filters setValue:_feed.feed_id forKey:@"id"];
    [_feed listComments:filters onComplete:^(NSDictionary *data) {
        _mainContentView = [[UITableView alloc] initWithFrame:CGRectMake(0, 57, 320, [[UIScreen mainScreen] bounds].size.height-55-100) style:UITableViewStylePlain];
        _mainContentView.backgroundColor = [UIColor clearColor];
        _mainContentView.delegate = self;
        _mainContentView.dataSource = self;
        [self.view addSubview:_mainContentView];
    } onError:^(NSString *msg) {
    
    }];
}

-(void)addLike
{
    
}

-(void)report
{

}

-(void)addComment
{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (_feed.comments_count+1);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Comment Cell";
    UICommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UICommentCell alloc] init];
        [cell setupCell:_feed atIndex:indexPath.row];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0;
    if (indexPath.row == 0) {
        height = [self cellHeight:_feed.text width:288-10 font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0]];
        if (_feed.thumbnail_pic) {
            height = height + 70;
        }
        return height + 40;
    }else {
        Comment *comment = [[Comment alloc] initWithData:[_feed.comments objectAtIndex:indexPath.row-1]];
        height = 25 + [self cellHeight:comment.text width:288-10 font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0]];
        return height + 10;
    }
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)downloadPhotoWithUrl:(NSString *)url onView:(UIImageView *)imageView
{
    Photo *photo = [[Photo alloc] init];
    photo.url = url;
    [photo download:^(NSDictionary *pdata){
        
        imageView.image = photo.image;
        imageView.clipsToBounds = YES;
        [self.view addSubview:imageView];
    }
onDownloadProgressChanged:^(double progress) {
    
}
            onError:^(NSString *msg){
                
            }];
    
}

-(CGFloat)cellHeight:(NSString*)contentText width:(CGFloat)width font:(UIFont *)font
{
    if ([contentText length] == 0) {
        return 12;
    }
    CGSize size=[contentText sizeWithFont:font constrainedToSize:CGSizeMake(width-10, CGFLOAT_MAX) lineBreakMode:0];
    CGFloat height = size.height + 22;
    return height;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
