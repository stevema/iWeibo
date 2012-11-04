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
    UIButton *addPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addPhotoButton.frame = CGRectMake(0, 0, 60, 22);
    [addPhotoButton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [addPhotoButton setBackgroundImage:[UIImage imageNamed:@"send"] forState:UIControlStateNormal];
    //[addPhotoButton setBackgroundImage:[UIImage imageNamed:@"add_photo"] forState:UIControlStateHighlighted];
    [rightBarView addSubview:addPhotoButton];
    
    weiboContentView = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 300, [[UIScreen mainScreen] bounds].size.height-216)];
    
    weiboContentView.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0];
    [weiboContentView becomeFirstResponder];
    [self.view addSubview:weiboContentView];
    
}

-(void)back
{
    CATransition *transition = [CATransition animation];
    transition.duration = kAnimationDuration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)send
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
