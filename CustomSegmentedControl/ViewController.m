//
//  ViewController.m
//  CustomSegmentedControl
//
//  Created by Kirill Ushkov on 30/03/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//

#import "ViewController.h"
#import "SegmentNavigationView.h"

@interface ViewController ()<SegmentNavigationViewProtocol>

@property (weak, nonatomic) IBOutlet SegmentNavigationView *segmentNavigationView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)didChangeSegmentInNavigationView:(SegmentNavigationView *)view segmentControl:(UISegmentedControl *)segmentControl {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
