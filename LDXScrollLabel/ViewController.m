//
//  ViewController.m
//  ScrollLabel
//
//  Created by 刘东旭 on 2017/12/20.
//  Copyright © 2017年 刘东旭. All rights reserved.
//

#import "ViewController.h"
#import "LDXScrollLabel.h"

@interface ViewController ()

@property (nonatomic, strong) LDXScrollLabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];
    self.label = [[LDXScrollLabel alloc] initWithFrame:CGRectMake(0, 100, 130, 30)];
    self.label.scrollType = LDXAutoScroll;
    self.label.scrollDirection = LDXFromLeft;
    self.label.text = @"Hello world!dfgghhhffffsfdfdfdfdf gytytutttyrtrtte";
    [self.view addSubview:self.label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
