//
//  ViewController.m
//  HelloOpenGL
//
//  Created by guoyf on 2018/3/1.
//  Copyright © 2018年 guoyf. All rights reserved.
//

#import "ViewController.h"
#import "OpenGLView.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()
{
    OpenGLView * openglView;
}
@property (nonatomic, strong) CMMotionManager *manager;

@end

@implementation ViewController

#pragma mark - 懒加载
- (CMMotionManager *)manager
{
    if (_manager == nil) {
        _manager = [[CMMotionManager alloc] init];
    }
    
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    openglView = [[OpenGLView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:openglView];
    
    [self startManager];
}

-(void)startManager{
    if (!self.manager.isGyroAvailable) {
        NSLog(@"");
        return;
    }
    
//    https://www.cnblogs.com/wayne23/p/3671101.html
    // 2.设置采样间隔
    self.manager.gyroUpdateInterval = 0.1;
    // 3.开始采样
    [self.manager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXMagneticNorthZVertical toQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {

        /*
         CMDeviceMotion 被分成两部分Gravity和UserAcceleration。还包含一个速率CMRotationRate
         1、Gravity代表重力1g在设备的分布情况
         2、UserAcceleration代表设备运动中的加速度分布情况。
         将前两者相加就等于实际加速度。Gravity的三个轴所受的重力加起来始终等于1g，而UserAcceleration取决于单位时间内动作的幅度大小
         3、CMRotationRate的X，Y,Z分别代表三个轴上的旋转速率，单位为弧度/秒
         4、CMAttitude的三个属性Yaw,Pitch和Roll分别代表左右摆动、俯仰以及滚动
         */
        
        if(motion){
            CMRotationRate rotationRate = motion.rotationRate;
            double rotationX = rotationRate.x;
            double rotationY = rotationRate.y;
            double rotationZ = rotationRate.z;
            
            double value = rotationX * rotationX + rotationY * rotationY + rotationZ * rotationZ;
            
            // 防抖处理，阀值以下的朝向改变将被忽略
            if (value > 0.001) {
                CMAttitude *attitude = motion.attitude;
                
                [openglView updateWithX:attitude.quaternion.x Y:attitude.quaternion.y Z:attitude.quaternion.z W:attitude.quaternion.w];
                
            }
        }
        
    }];
}

@end
