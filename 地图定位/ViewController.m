//
//  ViewController.m
//  地图定位
//
//  Created by cqy on 16/5/21.
//  Copyright © 2016年 刘征. All rights reserved.
//

#import "ViewController.h"
//1.导入框架
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<CLLocationManagerDelegate>{
    //2.声明全局的定位管理器对象，必须是全局的
    CLLocationManager *locationManger;
    float allDistance;
    float allTime;
    CLLocation *lastLocation;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     *1.CoreLocation框架
     
     *2.CLLocationManger定位管理器
     
     *3.CLLocation保存位置信息
     */
    /*精简定位-》GPS
     
      *1.导入CoreLcoation
      *2.创建定位管理器，需为全局变量
      *3.获取到定位授权
      *4.挂代理遵守协议
      *5. 开始定位
      *6.实现代理方法
     
     *导航方向定位-》磁性传感器，不需要定位授权，使用之前先判断方向服务是否可用
        
        1.导入CoreLocation 
        2.创建定位管理器，需为全局变量
        3.挂代理遵守协议
        4.开始导航定位
        5.实现代理方法
     
     */
    
    
    //3.首先实例化管理对象
    
    locationManger = [[CLLocationManager alloc]init];
    
    //4.判断手机是否打开定位服务
    
    
    BOOL isOpenLocationManger = [CLLocationManager locationServicesEnabled];
    
    if (isOpenLocationManger ==NO) {
        
        NSLog(@"请到设置-隐私-定位服务器里面打开定位");
        
        return;
    }
   //5.获取定位服务权限，并在info.plist进行相应配置
    
    [locationManger requestAlwaysAuthorization];
    
    //6.设置定位精度和频率
    //精度
    locationManger.desiredAccuracy = 10;
    //频率
    locationManger.distanceFilter = 10;
    //7.代理方法挂代理
    
    locationManger.delegate = self;
    
    
    //8.开始定位
    
    [locationManger startUpdatingLocation];
    
    
    
    
    
}
static int isFirst = 0;
//9.实现代理方法，定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //获取到代表当前位置信息 CLLocation对象
    CLLocation *curLocation = locations.lastObject;
    
   // NSLog(@"经度=%f \n 纬度=%f",curLocation.coordinate.longitude,curLocation.coordinate.latitude);
    
    if (isFirst == 0) {
        
        isFirst = 1;
    }else{
        
    int distance =[curLocation distanceFromLocation:lastLocation];
    
        allDistance +=  distance;
      float time =  [curLocation.timestamp timeIntervalSinceDate:lastLocation.timestamp];
        allTime += time;
        
    }
    NSLog(@"行驶了%f米 速度%f 行驶%f秒",allDistance,allDistance/allTime,allTime);
    lastLocation = curLocation;
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    
}


@end
