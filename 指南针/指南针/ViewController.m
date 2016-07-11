//
//  ViewController.m
//  指南针
//
//  Created by cqy on 16/5/21.
//  Copyright © 2016年 刘征. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<CLLocationManagerDelegate>{
    UIImageView *image;
    
    CLLocationManager *locationManger;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   /*
    *导航方向定位-》磁性传感器，不需要定位授权，使用之前先判断方向服务是否可用
    
    1.导入CoreLocation
    2.创建定位管理器，需为全局变量
    3.挂代理遵守协议
    4.开始导航定位
    5.实现代理方法
    */
    
    image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 200, 414, 414)];
    image.backgroundColor = [UIColor redColor];
    image.image = [UIImage imageNamed:@"0.jpg"];
    [self.view addSubview:image];
    locationManger = [[CLLocationManager alloc]init];
    locationManger.delegate = self;
    
    [locationManger startUpdatingHeading];
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    //判断方向
    if (newHeading.headingAccuracy<0) {
        NSLog(@"导航方向定位服务不可用");
        return;
    }
    //角度
   CLLocationDirection direction = newHeading.magneticHeading;
    
    //角度弧度
    
    float cor = direction /180 * M_PI;
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
    image.transform = CGAffineTransformRotate(image.transform, cor);
        
        
    }];
}

@end
