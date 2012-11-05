//
//  AddWeiboViewController.h
//  iWeibo
//
//  Created by Steve on 11/4/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"

@interface AddWeiboViewController : UIViewController<UITextViewDelegate,UIActionSheetDelegate>
{
    UIPlaceHolderTextView *weiboContentView;
    UILabel *textCount;
    int textAmount;
    AppDelegate *delegate;
    UIButton *sendButton;
}
@end
