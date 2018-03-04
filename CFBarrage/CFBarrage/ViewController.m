//
//  ViewController.m
//  CFBarrage
//
//  Created by cf on 2017/12/16.
//  Copyright © 2017年 chenfeng. All rights reserved.
//

#import "ViewController.h"
#import "CFBarrageView.h"
#import "UIView+Frame.h"

@interface ViewController ()<CFBarrageViewDelegate>

@property (nonatomic, strong) CFBarrageView *barrageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _barrageView = [[CFBarrageView alloc] initWithFrame:self.view.frame];
    _barrageView.animationTimeInterval = 8;
    _barrageView.delegate = self;
    _barrageView.displayMode = CFBarrageViewDisplayModeWithDefault;
    [self.view addSubview:_barrageView];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(self.view.width/2 - 50, self.view.height - 200, 100, 50);
    [button setTitleColor:[UIColor darkTextColor] forState:(UIControlStateNormal)];
    [button setTitle:@"发送弹幕" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
}

- (void)buttonAction
{
    [_barrageView sendBarrage:@[@"我哈哈哈哈哈哈哈1",@"我哈哈哈哈哈哈哈2",@"我哈哈哈哈哈哈哈3",@"我哈哈哈哈哈哈哈4",@"我哈哈哈哈哈哈哈5",@"我哈哈哈哈哈哈哈6",@"我哈哈哈哈哈哈哈7",@"我哈哈哈哈哈哈哈8",@"我哈哈哈哈哈哈哈9"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <CFBarrageViewDelegate>

- (void)barrageViewDidselectTextlabel:(UILabel *)label
{

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:label.text
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                     
                                                          }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

@end
