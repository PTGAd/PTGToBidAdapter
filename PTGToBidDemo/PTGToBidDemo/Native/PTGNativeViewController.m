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
@property(nonatomic,strong)NSMutableArray<WindMillNativeAdView *> *ads;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation PTGNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ads = [NSMutableArray array];
    [self addChildViewsAndLayout];
}

- (void)addChildViewsAndLayout {
    [self.view insertSubview:self.tableView atIndex:0];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)loadAd:(UIButton *)sender {
    WindMillAdRequest *request = [WindMillAdRequest request];
    request.placementId = @"8842451763315458";
    self.adManager = [[WindMillNativeAdsManager alloc] initWithRequest:request];
    self.adManager.adSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, 200);
    self.adManager.delegate = self;
    [self.adManager loadAdDataWithCount:1];
}

- (void)showAd:(UIButton *)sender {
    [WindMillNativeAdView alloc];
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ads.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass(UITableViewCell.class);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [[cell viewWithTag:100002] removeFromSuperview];
    WindMillNativeAdView *ad = self.ads[indexPath.row];
    ad.tag = 100002;
    [cell.contentView addSubview:ad];
    [ad mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WindMillNativeAdView *view = self.ads[indexPath.row];
    if (view.nativeAd.feedADMode == WindMillFeedADModeNativeExpress) {
        return view.bounds.size.height;
    }
    return [PTGNativeSelfRenderAdView cellHeightWithModel:view.nativeAd width:UIScreen.mainScreen.bounds.size.width];
}

#pragma mark - PTGNativeSelfRenderAdViewDislikeDelgate -
- (void)feedCustomDislike:(PTGNativeSelfRenderAdView *)nativeAdView {
    [self.ads removeObject:nativeAdView];
    [self.tableView reloadData];
}

#pragma mark - WindMillNativeAdsManagerDelegate -
- (void)nativeAdsManagerSuccessToLoad:(WindMillNativeAdsManager *)adsManager {
    if (adsManager.getAllNativeAds.count == 0) { return; }
    NSLog(@"信息流广告加载成功");
    NSMutableArray *views = [NSMutableArray new];
    [adsManager.getAllNativeAds enumerateObjectsUsingBlock:^(WindMillNativeAd * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.feedADMode == WindMillFeedADModeNativeExpress) {
            WindMillNativeAdView *view = [[WindMillNativeAdView alloc] init];
            view.delegate = self;
            view.viewController = self;
            [view refreshData:obj];
            [views addObject:view];
        } else {
            PTGNativeSelfRenderAdView *view = [[PTGNativeSelfRenderAdView alloc] init];
            view.delegate = self;
            view.dislikeDelegate = self;
            view.viewController = self;
            [view refreshData:obj];
            [views addObject:view];
        }
    }];
    [self.ads addObjectsFromArray:views];
    [self.tableView reloadData];
}

- (void)nativeAdsManager:(WindMillNativeAdsManager *)adsManager didFailWithError:(NSError *)error {
    NSLog(@"信息流广告加载失败");
}


#pragma mark - WindMillNativeAdViewDelegate
- (void)nativeExpressAdViewRenderSuccess:(WindMillNativeAdView *)nativeExpressAdView {
    NSLog(@"信息流广告渲染成功");
    [self.tableView reloadData];
}

- (void)nativeExpressAdViewRenderFail:(WindMillNativeAdView *)nativeExpressAdView error:(NSError *)error {
    NSLog(@"信息流广告渲染失败");
    [self.ads removeObject:nativeExpressAdView];
    [self.tableView reloadData];
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
    [self.ads removeObject:nativeAdView];
    [self.tableView reloadData];
}

/**
 视频广告播放状态更改回调
 
 @param nativeAdView WindMillNativeAdView 实例
 @param status 视频广告播放状态
 @param userInfo 视频广告信息
 */
- (void)nativeAdView:(WindMillNativeAdView *)nativeAdView playerStatusChanged:(WindMillMediaPlayerStatus)status userInfo:(NSDictionary *)userInfo {

}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    return _tableView;
}
@end
