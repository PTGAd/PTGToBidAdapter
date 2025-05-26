//
//  PTGNativeViewController.m
//  PTGToBidDemo
//
//  Created by yongjiu on 2025/4/23.
//

#import "PTGNativeViewController.h"
#import <Masonry/Masonry.h>
#import "PTGNativeSelfRenderAdView.h"

@interface PTGNativeViewController ()
<
WindMillNativeAdsManagerDelegate,
WindMillNativeAdViewDelegate,
UITableViewDataSource,
UITableViewDelegate,
PTGNativeSelfRenderAdViewDislikeDelgate
>

@property(nonatomic,strong)WindMillNativeAdsManager *adManager;
@property(nonatomic,strong)WindMillNativeAd *nativeAd;
@property(nonatomic,strong)UIView *nativeAdView;


@end

@implementation PTGNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)loadAd:(UIButton *)sender {
    self.statusLabel.text = @"广告加载中";
    WindMillAdRequest *request = [WindMillAdRequest request];
    request.placementId = @"8842451763315458";
    self.adManager = [[WindMillNativeAdsManager alloc] initWithRequest:request];
    self.adManager.adSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, 200);
    self.adManager.delegate = self;
    [self.adManager loadAdDataWithCount:1];
}

- (void)showAd:(UIButton *)sender {
    if (!self.nativeAd.isAdReady) {
        NSLog(@"广告已过期");
        return;
    }
    if (self.nativeAd.feedADMode == WindMillFeedADModeNativeExpress) {
        WindMillNativeAdView *view = [[WindMillNativeAdView alloc] init];
        view.delegate = self;
        view.viewController = self;
        [view refreshData:self.nativeAd];
        view.frame = CGRectMake(0, 100, view.bounds.size.width, view.bounds.size.height);
        self.nativeAdView = view;
        [self.view addSubview:view];
    } else {
        PTGNativeSelfRenderAdView *view = [[PTGNativeSelfRenderAdView alloc] init];
        view.delegate = self;
        view.dislikeDelegate = self;
        view.viewController = self;
        [view refreshData:self.nativeAd];
        CGFloat h = [PTGNativeSelfRenderAdView cellHeightWithModel:view.nativeAd width:UIScreen.mainScreen.bounds.size.width];
        view.frame = CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, h);
        self.nativeAdView = view;
        [self.view addSubview:view];
    }
    self.statusLabel.text = @"广告展示中";
}

#pragma mark - PTGNativeSelfRenderAdViewDislikeDelgate -
- (void)feedCustomDislike:(PTGNativeSelfRenderAdView *)nativeAdView {
    self.nativeAd = nil;
    [self.nativeAdView removeFromSuperview];
    self.nativeAdView = nil;
}

#pragma mark - WindMillNativeAdsManagerDelegate -
- (void)nativeAdsManagerSuccessToLoad:(WindMillNativeAdsManager *)adsManager {
    if (adsManager.getAllNativeAds.count == 0) { return; }
    NSLog(@"信息流广告加载成功");
    self.statusLabel.text = @"广告加载成功";
    WindMillNativeAd *nativeAd = adsManager.getAllNativeAds.firstObject;
    self.nativeAd = nativeAd;
}

- (void)nativeAdsManager:(WindMillNativeAdsManager *)adsManager didFailWithError:(NSError *)error {
    NSLog(@"信息流广告加载失败");
    self.statusLabel.text = @"广告加载失败";
}


#pragma mark - WindMillNativeAdViewDelegate
- (void)nativeExpressAdViewRenderSuccess:(WindMillNativeAdView *)nativeExpressAdView {
    NSLog(@"信息流广告渲染成功");
    self.statusLabel.text = @"广告渲染成功";
}

- (void)nativeExpressAdViewRenderFail:(WindMillNativeAdView *)nativeExpressAdView error:(NSError *)error {
    NSLog(@"信息流广告渲染失败");
    self.statusLabel.text = @"广告渲染失败";
    self.nativeAd = nil;
    [self.nativeAdView removeFromSuperview];
    self.nativeAdView = nil;
}

/**
 广告曝光回调
 
 @param nativeAdView WindMillNativeAdView 实例
 */
- (void)nativeAdViewWillExpose:(WindMillNativeAdView *)nativeAdView {
    NSLog(@"信息流广告曝光");
}


/**
 广告点击回调
 
 @param nativeAdView WindMillNativeAdView 实例
 */
- (void)nativeAdViewDidClick:(WindMillNativeAdView *)nativeAdView {
    NSLog(@"信息流广告点击");
}


/**
 广告详情页关闭回调
 
 @param nativeAdView WindMillNativeAdView 实例
 */
- (void)nativeAdDetailViewClosed:(WindMillNativeAdView *)nativeAdView {
    NSLog(@"信息流广告详情页关闭");
}


/**
 广告详情页面即将展示回调
 
 @param nativeAdView WindMillNativeAdView 实例
 */
- (void)nativeAdDetailViewWillPresentScreen:(WindMillNativeAdView *)nativeAdView {
    NSLog(@"信息流广告详情页展示");
}

- (void)nativeAdView:(WindMillNativeAdView *)nativeAdView dislikeWithReason:(NSArray<WindMillDislikeWords *> *)filterWords {
    NSLog(@"信息流广告关闭");
    self.statusLabel.text = @"广告待加载";
    self.nativeAd = nil;
    [self.nativeAdView removeFromSuperview];
    self.nativeAdView = nil;
}

/**
 视频广告播放状态更改回调
 
 @param nativeAdView WindMillNativeAdView 实例
 @param status 视频广告播放状态
 @param userInfo 视频广告信息
 */
- (void)nativeAdView:(WindMillNativeAdView *)nativeAdView playerStatusChanged:(WindMillMediaPlayerStatus)status userInfo:(NSDictionary *)userInfo {

}


@end
