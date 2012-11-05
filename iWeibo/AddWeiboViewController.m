//
//  AddWeiboViewController.m
//  iWeibo
//
//  Created by Steve on 11/4/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "AddWeiboViewController.h"

@interface AddWeiboViewController ()

@end

@implementation AddWeiboViewController

static const NSTimeInterval kAnimationDuration = 0.40f;

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
	// Do any additional setup after loading the view.
    delegate = [AppDelegate sharedAppDelegate];
    UIView *leftBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 22)];
    self.view.backgroundColor = [UIColor colorWithRed:0xF2/255.0 green:0xF2/255.0 blue:0xF2/255.0 alpha:0xFF/255.0];
    leftBarView.backgroundColor = [UIColor clearColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarView];
    UIButton *addWeiboButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addWeiboButton.frame = CGRectMake(0, 0, 60, 22);
    [addWeiboButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [addWeiboButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //[addWeiboButton setBackgroundImage:[UIImage imageNamed:@"add_feed_hi"] forState:UIControlStateHighlighted];
    [leftBarView addSubview:addWeiboButton];
    
    UIView *rightBarView = [[UIView alloc] initWithFrame:CGRectMake(240, 0, 60, 22)];
    rightBarView.backgroundColor = [UIColor clearColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarView];
    sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(0, 0, 60, 22);
    [sendButton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [sendButton setBackgroundImage:[UIImage imageNamed:@"send"] forState:UIControlStateDisabled];
    [sendButton setEnabled:NO];
    [sendButton setBackgroundImage:[UIImage imageNamed:@"send-hi"] forState:UIControlStateNormal];
    //[addPhotoButton setBackgroundImage:[UIImage imageNamed:@"add_photo"] forState:UIControlStateHighlighted];
    [rightBarView addSubview:sendButton];
    
    CGFloat contentViewHeight = [[UIScreen mainScreen] bounds].size.height-216-60;
    weiboContentView = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(0, 0, 320, contentViewHeight)];
    weiboContentView.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0];
    [weiboContentView becomeFirstResponder];
    weiboContentView.delegate = self;
    [self.view addSubview:weiboContentView];
    
    textCount = [[UILabel alloc] initWithFrame:CGRectMake(270, contentViewHeight-40, 50, 20)];
    textCount.text = @"140";
    textCount.backgroundColor = [UIColor clearColor];
    textCount.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0];
    [self.view addSubview:textCount];
    
    UIButton *camra
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([weiboContentView.text length]> 0 && [weiboContentView.text length]<=140) {
        [sendButton setEnabled:YES];
        textAmount = [weiboContentView.text length];
        textCount.text = [NSString stringWithFormat:@"%d",140 - textAmount];
    }else{
        [sendButton setEnabled:NO];
    }

}

-(void)back
{
    CATransition *transition = [CATransition animation];
    transition.duration = kAnimationDuration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFade;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)showPhoto
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"打开相机" otherButtonTitles:@"从相册选取", nil];
    [actionSheet showInView:delegate.window];
}

-(void)send
{
    NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];
    [filters setValue:delegate.user.access_token forKey:@"access_token"];
    //[filters setValue:[weiboContentView.text stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding] forKey:@"status"];
    [filters setValue:weiboContentView.text forKey:@"status"];
    [delegate.user sendWeiboText:filters onComplete:^(NSDictionary *data){
        [self back];
    } onError:^(NSString *msg){
    
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
