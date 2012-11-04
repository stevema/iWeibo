//
//  UISummaryPhotoView.m
//  sanya
//
//  Created by Steve on 10/24/12.
//
//

#import "UISummaryPhotoView.h"

@implementation UISummaryPhotoView

@synthesize photoView = _photoView;

@synthesize progressView = _progressView;
@synthesize reloadButton = _reloadButton;
@synthesize photo = _photo;

-(id)initWithFrame:(CGRect)frame withPhoto:(Photo*)photo

{
    self = [self initWithFrame:frame];
    
    _photo = photo;
    _photoView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x, 0, frame.size.width-(frame.origin.x * 2), frame.size.height)];
    _photoView.contentMode = UIViewContentModeScaleAspectFill;
    
    _progressView = [[DDProgressView alloc] initWithFrame:CGRectMake(105, (frame.size.height - 5) / 2, 100, 5)];
    [self addSubview:_progressView];
    
    
    _reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _reloadButton.frame = CGRectMake(10, (frame.size.height - 150) / 2, 290, 150);
    _reloadButton.backgroundColor = [UIColor clearColor];
    [_reloadButton setTitle:@"加载失败，点击重新加载." forState:UIControlStateNormal];
    [_reloadButton setTitleColor:[UIColor colorWithRed:0.42f green:0.48f blue:0.55f alpha:1.00f] forState:UIControlStateNormal];
    _reloadButton.titleLabel.textAlignment = UITextAlignmentCenter;
    _reloadButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [_reloadButton addTarget:self action:@selector(downloadPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_reloadButton];
    
    [self downloadPhoto];
   
    
    return self;
}

-(void)downloadPhoto
{
    _progressView.hidden = NO;
    _reloadButton.hidden = YES;
    _progressView.progress = 0.0f;

    [_photo download:^(NSDictionary *pdata){
        _progressView.hidden = YES;
        _reloadButton.hidden = YES;
        _photoView.image = _photo.image;
        _photoView.clipsToBounds = YES;
        [self addSubview:_photoView];
    }
onDownloadProgressChanged:^(double progress)
     {
         _progressView.progress = progress;
     }
             onError:^(NSString *msg){
                 _progressView.hidden = YES;
                 _reloadButton.hidden = NO;
             }];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
@end
