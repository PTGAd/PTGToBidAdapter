//
//  BaseAdViewController.m
//  PTGSDKDemo
//
//  Created byttt on 2024/10/27.
//

#import "BaseAdViewController.h"
#import "YYCategories/YYCategories.h"

@interface BaseAdViewController ()


@end

@implementation BaseAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.confirmButton.frame = CGRectMake(100, UIScreen.mainScreen.bounds.size.height - 80, 175, 30);
    [self.view addSubview:self.confirmButton];
}


- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton setBackgroundImage:[UIImage imageWithColor:UIColor.grayColor size:CGSizeMake(175, 30)] forState:UIControlStateNormal];
    }
    return _confirmButton;
}

@end
