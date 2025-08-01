//
//  PTGInterstitialViewController.m
//  PTGToBidDemo
//
//  Created by yongjiu on 2025/4/23.
//

#import "PTGInterstitialViewController.h"

@interface PTGInterstitialViewController ()<WindMillIntersititialAdDelegate>

@property (nonatomic, strong) WindMillIntersititialAd *intersititialAd;
@property (nonatomic, assign) BOOL isLoading;

@end

@implementation PTGInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)loadAd:(UIButton *)sender {
    if (self.isLoading) {
        return;
    }
    self.isLoading = YES;
    self.statusLabel.text = @"广告开始加载";
    WindMillAdRequest *request = [WindMillAdRequest request];
    request.placementId = @"8524263791991043";
    request.options = @{@"test_key":@"test_value"};
    self.intersititialAd = [[WindMillIntersititialAd alloc] initWithRequest:request];
    self.intersititialAd.delegate = self;
    [self.intersititialAd loadAdData];
}

- (void)showAd:(UIButton *)sender {
    if (!self.intersititialAd.isAdReady) {
        self.statusLabel.text = @"广告已过期";
        return;
    }
    self.statusLabel.text = @"";
    [self.intersititialAd showAdFromRootViewController:self options:@{
        WindMillAdSceneDesc: @"测试场景",
        WindMillAdSceneId: @"1"
    }];
    self.statusLabel.text = @"广告展示中";
}

#pragma mark - WindMillIntersititialAdDelegate -
- (void)intersititialAdDidLoad:(WindMillIntersititialAd *)intersititialAd {
    self.isLoading = NO;
    self.statusLabel.text = @"广告加载成功";
    NSLog(@"插屏广告加载成功");
}

- (void)intersititialAdDidLoad:(WindMillIntersititialAd *)intersititialAd didFailWithError:(NSError *)error {
    self.statusLabel.text = @"广告加载失败";
    self.isLoading = NO;
    NSLog(@"插屏广告加载失败 error = %@",error);
}

- (void)intersititialAdWillVisible:(WindMillIntersititialAd *)intersititialAd {
    NSLog(@"插屏广告将要展示");
}

- (void)intersititialAdDidVisible:(WindMillIntersititialAd *)intersititialAd {
    NSLog(@"插屏广告展示");
}

- (void)intersititialAdDidClick:(WindMillIntersititialAd *)intersititialAd {
    NSLog(@"插屏广告点击");
}
- (void)intersititialAdDidCloseOtherController:(WindMillIntersititialAd *)intersititialAd withInteractionType:(WindMillInteractionType)interactionType {
    NSLog(@"插屏详情页关闭%@ interactionType = %zd", NSStringFromSelector(_cmd), interactionType);
}

- (void)intersititialAdDidClickSkip:(WindMillIntersititialAd *)intersititialAd {
    
}

- (void)intersititialAdDidClose:(WindMillIntersititialAd *)intersititialAd {
    NSLog(@"插屏广告关闭");
    self.statusLabel.text = @"广告待加载";
}

- (void)intersititialAdDidPlayFinish:(WindMillIntersititialAd *)intersititialAd didFailWithError:(NSError *)error {
    NSLog(@"插屏广告展示失败");
}

@end
