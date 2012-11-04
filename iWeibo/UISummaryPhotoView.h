//
//  UISummaryPhotoView.h
//  sanya
//
//  Created by Steve on 10/24/12.
//
//

#import <UIKit/UIKit.h>
#import "Photo.h"
#import "DDProgressView.h"

@interface UISummaryPhotoView : UIView


@property(nonatomic,strong)Photo *photo;
@property(nonatomic,strong)UIImageView *photoView;

@property(nonatomic,strong)DDProgressView *progressView;
@property(nonatomic,strong)UIButton *reloadButton;
//@property(nonatomic,strong)UIButton *reloadIcon;



-(id)initWithFrame:(CGRect)frame withPhoto:(Photo*)photo;

@end
