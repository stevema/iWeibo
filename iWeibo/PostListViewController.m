//
//  PostListViewController.m
//  iWeibo
//
//  Created by Steve on 10/10/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import "PostListViewController.h"
#import "User.h"
#import "UIFeedListCell.h"


@interface PostListViewController ()
{
    AppDelegate *delegate;
    User *user;
}
@end

@implementation PostListViewController
static int max_count = 30;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topBar_bg"] forBarMetrics:UIBarMetricsDefault];
    UIView *leftBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    leftBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"topBar_bg"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarView];
    UIButton *addWeiboButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addWeiboButton.frame = CGRectMake(10, 2, 21, 18);
    [addWeiboButton addTarget:self action:@selector(addWeibo) forControlEvents:UIControlEventTouchUpInside];
    [addWeiboButton setBackgroundImage:[UIImage imageNamed:@"add_feed"] forState:UIControlStateNormal];
    //[addWeiboButton setBackgroundImage:[UIImage imageNamed:@"add_feed_hi"] forState:UIControlStateHighlighted];
    [leftBarView addSubview:addWeiboButton];
    
    UIView *rightBarView = [[UIView alloc] initWithFrame:CGRectMake(280, 0, 50, 20)];
    rightBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"topBar_bg"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarView];
    UIButton *addPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addPhotoButton.frame = CGRectMake(20, 2, 22, 17);
    [addPhotoButton addTarget:self action:@selector(addWeibo) forControlEvents:UIControlEventTouchUpInside];
    [addPhotoButton setBackgroundImage:[UIImage imageNamed:@"add_photo"] forState:UIControlStateNormal];
    //[addPhotoButton setBackgroundImage:[UIImage imageNamed:@"add_photo"] forState:UIControlStateHighlighted];
    [rightBarView addSubview:addPhotoButton];
    
    self.view.backgroundColor = [UIColor colorWithRed:0xF2/255.0 green:0xF2/255.0 blue:0xF2/255.0 alpha:0xFF/255.0];
    delegate = [AppDelegate sharedAppDelegate];
    self.title = delegate.user.screen_name;
    user = delegate.user;
   // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getNews];
}

-(void)getNews
{
    NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];
    [filters setValue:user.access_token forKey:@"access_token"];
    [filters setObject:[NSNumber numberWithInt:max_count] forKey:@"count"];
    
    [user listOpenWeibo:filters onComplete:^(NSDictionary *data){
        [self.tableView reloadData];
    } onError:^(NSString *msg){
    
    }];
}

-(void)addWeibo
{
    
}

-(void)addPhoto
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [user.feeds count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"List Cell";
    UIFeedListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UIFeedListCell alloc] init];
        if (indexPath.row == [user.feeds count]) {
            UILabel *listMore = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 300, 30)];
            listMore.backgroundColor = [UIColor clearColor];
            listMore.text = @"加载更多……";
            [cell addSubview:listMore];
        }else  {
            [cell setupCell:[user.feeds objectAtIndex:indexPath.row]];
        }
        
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [user.feeds count]) {
        return 36;
    }else {
        CGFloat height = 24.0;
        Feed *feed = [user.feeds objectAtIndex:indexPath.row];
        height = height + [self cellHeight:feed.text width:250-10 font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0]];
        if (feed.thumbnail_pic) {
            height = height + 70;
        }
        return height;
    }
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)refresh 
{
    NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];
    [filters setValue:user.access_token forKey:@"access_token"];
    [filters setObject:[NSNumber numberWithInt:max_count] forKey:@"count"];
    Feed *last = [user.feeds objectAtIndex:0];
    [filters setValue:last.feed_id forKey:@"since_id"];
    [user listOpenWeibo:filters onComplete:^(NSDictionary *data){
        NSLog(@"more data is %@",data);
        [self stopLoading];
        [self.tableView reloadData];
    } onError:^(NSString *msg){
        
    }];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    if (indexPath.row == [user.feeds count]) {
        NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];
        [filters setValue:user.access_token forKey:@"access_token"];
        [filters setObject:[NSNumber numberWithInt:max_count] forKey:@"count"];
        Feed *last = [user.feeds objectAtIndex:indexPath.row-1];
        [filters setValue:last.feed_id forKey:@"max_id"];
        [user listOpenWeibo:filters onComplete:^(NSDictionary *data){
            NSLog(@"more data is %@",data);
            [self.tableView reloadData];
        } onError:^(NSString *msg){
            
        }];
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
