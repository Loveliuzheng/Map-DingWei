//
//  ViewController.m
//  自定义大头针
//
//  Created by puyantao on 16/5/22.
//  Copyright © 2016年 puyantao. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AnnotationModel.h"
/*
 一、地图显示
 
 1、创建一个全局的定位管理器
 2、获得定位权限
 3、地图试图，MKMapView
 4、显示用户当前位置 showUserlocation
 5、设置追踪类型 userTrackingMode
 
 6、通过setRegin设置地图显示区域
 经纬度coor  经纬跨度span
 
 
 二、自定义大头针
 
 1、找到大头针数据模型
 2、添加数据模型到地图试图上，会调用代理方法
 3、通过代理方法，将数据模型包装到数据模型上
 
 三、 杂谈
 
 MKUerlocation  当前位置的数据模型
 
 MKAnnatation   大头针数据模型的协议
 
 MKAnnatationView  大头针试图
 
 */



@interface ViewController ()<MKMapViewDelegate>
{
    MKMapView *_mapView;
    CLLocationManager *_locationManger;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _locationManger = [[CLLocationManager alloc]init];
    [_locationManger requestAlwaysAuthorization];
    
    _mapView = [[MKMapView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_mapView];
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    _mapView.delegate = self;
    
    /*
     * 大头针显示的原理
     * 1、找到当前用户位置的数据模型
     * 2、往试图上添加数据模型
     * 3、调用代理方法将数据模型包装到大头针试图上面，然后返回该大头针试图
     */

    
    //添加长按手势
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longAn:)];
    [_mapView addGestureRecognizer:longGesture];
    
    
    
}


//用户位置发生改变时触发
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        
        CLGeocoder *geocoder = [[CLGeocoder alloc]init];
        [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            CLPlacemark *placemark = placemarks.lastObject;
            userLocation.title = placemark.name;
            userLocation.subtitle = placemark.ISOcountryCode;
            
            
        }];
        
    });
    
}

//点击选中某个大头针时触发
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    NSLog(@"===");
    
    
}


//显示大头针时触发，返回大头针视图，通常自定义大头针可以通过此方法进行
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    //判断当前大头针数据模型是不是用户位置的数据模型
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"annotationView"];
        if (annotationView == nil) {
            //将数据模型包装到大头针试图上面
            annotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
            
        }
        
        annotationView.image = [UIImage imageNamed:@"user"];
        
        //显示一个辅助视图
        annotationView.canShowCallout = YES;
        
        //大头针拖动
        annotationView.draggable = YES;
        
        //插入视图
        annotationView.leftCalloutAccessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"vip"]];
        annotationView.rightCalloutAccessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"电话@3x"]];
        
        //详细视图
//        annotationView.detailCalloutAccessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"vip"]];
//        
        
        
        
        return annotationView;
        
    }
    
    return nil;
    
}




-(void)longAn:(UILongPressGestureRecognizer *)longGesture{
  
    
    if (longGesture.state != UIGestureRecognizerStateBegan) {
        return;
        
    }
    
    
    //获取点击的坐标
    CGPoint point = [longGesture locationInView:longGesture.view];
    NSLog(@"%f,%f",point.x,point.y);
    
    //获取经纬度
    CLLocationCoordinate2D coordinate = [_mapView convertPoint:point toCoordinateFromView:longGesture.view];
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
    
        CLGeocoder *geocoder = [[CLGeocoder alloc]init];
        CLLocation *location = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            CLPlacemark *placeMark = placemarks.lastObject;
            
            AnnotationModel *annotationModel = [[AnnotationModel alloc]init];
            annotationModel.coordinate = coordinate;
            annotationModel.title = placeMark.name;
            
            [_mapView addAnnotation:annotationModel];
            
        }];
        
    });
    
    
    
}















@end






















