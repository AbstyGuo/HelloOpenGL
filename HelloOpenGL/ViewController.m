//
//  ViewController.m
//  HelloOpenGL
//
//  Created by guoyf on 2018/3/1.
//  Copyright © 2018年 guoyf. All rights reserved.
//

#import "ViewController.h"
#import "OpenGLView.h"

@interface ViewController ()
{
    OpenGLView * openglView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    openglView = [[OpenGLView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:openglView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
