//
//  ViewController.m
//  DrawBoard
//
//  Created by Ze yang on 2018/3/12.
//  Copyright © 2018年 Ze yang. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DrawView *view = [[DrawView alloc] initWithFrame:self.view.frame ];
    [self.view addSubview:view];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
