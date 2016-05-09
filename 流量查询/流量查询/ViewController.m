//
//  ViewController.m
//  流量查询
//
//  Created by ly on 16/5/9.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "ViewController.h"
#import "ProgressView.h"
@interface ViewController ()
@property(nonatomic ,strong)ProgressView *progress;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat  viewWidth = self.view.bounds.size.width;
    _progress = [[ProgressView alloc]initWithFrame:CGRectMake((viewWidth -220)/2,100, 220, 220)];
    
    _progress.haveFinished = 0.60;
    _progress.haveFinished = 0.85;
    [self.view addSubview:_progress];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)move:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
