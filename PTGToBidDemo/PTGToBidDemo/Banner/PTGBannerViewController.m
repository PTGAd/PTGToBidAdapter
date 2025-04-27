//
//  PTGBannerViewController.m
//  PTGToBidDemo
//
//  Created by yongjiu on 2025/4/23.
//

#import "PTGBannerViewController.h"
#import <WindMillSDK/WindMillSDK.h>

@interface PTGBannerViewController ()<WindMillBannerViewDelegate>

@property (nonatomic, strong) WindMillBannerView *bannerView;


@end

@implementation PTGBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showAdButton.hidden = YES;
    // Do any additional setup after loading the view.
}

- (void)loadAd:(UIButton *)sender {
    if (self.bannerView.superview) {
        [self.bannerView removeFromSuperview];
        self.bannerView = nil;
    }
    WindMillAdRequest *request = [WindMillAdRequest request];
    request.placementId = @"2282951722442870";
    self.bannerView = [[WindMillBannerView alloc] initWithRequest:request expectSize:CGSizeMake(300, 80)];
    self.bannerView.delegate = self;
    self.bannerView.viewController = self;
    self.bannerView.animated = true;
    [self.bannerView loadAdData];
}

#pragma mark - WindMillBannerViewDelegate -
//bannerView自动刷新
- (void)bannerAdViewDidAutoRefresh:(WindMillBannerView *)bannerAdView {
    CGSize adSize = bannerAdView.adSize;
    CGFloat space = (UIScreen.mainScreen.bounds.size.width - adSize.width)/2.0;
    bannerAdView.frame = CGRectMake(space, 0, adSize.width, adSize.height);
    
}
//bannerView自动刷新失败
- (void)bannerView:(WindMillBannerView *)bannerAdView failedToAutoRefreshWithError:(NSError *)error {
    
}
//成功加载广告
- (void)bannerAdViewLoadSuccess:(WindMillBannerView *)bannerAdView {
    NSLog(@"横幅广告加载成功");
    CGSize adSize = bannerAdView.adSize;
    CGFloat space = (UIScreen.mainScreen.bounds.size.width - adSize.width)/2.0;
    bannerAdView.frame = CGRectMake(space, 200, adSize.width, adSize.height);
    [self.view addSubview:self.bannerView];
    
}
    
//广告加载失败
- (void)bannerAdViewFailedToLoad:(WindMillBannerView *)bannerAdView error:(NSError *)error {
    NSLog(@"横幅广告加载失败 error = %@",error);
}
//广告将要展示
- (void)bannerAdViewWillExpose:(WindMillBannerView *)bannerAdView {
    NSLog(@"横幅广告将要展示");
}
//广告被点击
- (void)bannerAdViewDidClicked:(WindMillBannerView *)bannerAdView {
    NSLog(@"横幅广告被点击");
}
//当用户由于点击要离开您的应用程序时触发该回调,您的应用程序将移至后台
- (void)bannerAdViewWillLeaveApplication:(WindMillBannerView *)bannerAdView {
    
}
//将打开全屏视图。在打开storekit或在应用程序中打开网页时触发
- (void)bannerAdViewWillOpenFullScreen:(WindMillBannerView *)bannerAdView {
    
}
//将关闭全屏视图。关闭storekit或关闭应用程序中的网页时发送
- (void)bannerAdViewCloseFullScreen:(WindMillBannerView *)bannerAdView {
    NSLog(@"横幅广告详情页关闭");
}
//广告视图被移除
- (void)bannerAdViewDidRemoved:(WindMillBannerView *)bannerAdView {
    NSLog(@"横幅广告关闭");
    [self.bannerView removeFromSuperview];
    self.bannerView.delegate = nil;
    self.bannerView = nil;
}

@end
