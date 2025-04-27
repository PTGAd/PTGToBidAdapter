//
//  AppDelegate.m
//  PTGToBidDemo
//
//  Created by yongjiu on 2025/4/15.
//

#import "AppDelegate.h"
#import <WindMillSDK/WindMillSDK.h>
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyWindow];
    
    [WindMillAds setupSDKWithAppId:@"57507"];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    return YES;
}


@end
