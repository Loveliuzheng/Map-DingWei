//
//  ViewController.m
//  编码 反编码
//
//  Created by cqy on 16/5/21.
//  Copyright © 2016年 刘征. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     *编码与反编码
     *CLGeocoder ->CoreLocation 框架，实现编码与反编码
     *CLPlaceMark ->CoreLocation框架，存放地标信息
     *ps：编码与反编码 较耗性能建议放到子线程里面执行
     */
    [self geocoder:@"郑州科技学院"];
    
    CLLocationCoordinate2D coor ;
    coor.latitude = 31.878638;
    coor.longitude =114.787267;
    [self reverseCoder:coor];
}
-(void)geocoder:(NSString *)Myname{
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        //创建一个编码对象
        CLGeocoder *ger = [[CLGeocoder alloc]init];
        //编码
        [ger geocodeAddressString:Myname completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            CLPlacemark *Mark = placemarks.lastObject;
            NSLog(@"经纬度=%f %f",Mark.location.coordinate.longitude,Mark.location.coordinate.latitude);
            
            
            NSLog(@"地址信息字典=%@",Mark.addressDictionary);
            
            NSLog(@"街道%@",Mark.thoroughfare);
            
        }];
        
    });
    
}
-(void)reverseCoder:(CLLocationCoordinate2D )coor{
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
    CLGeocoder *rever = [[CLGeocoder alloc]init];
    
    CLLocation *location = [[CLLocation alloc]initWithLatitude:coor.latitude longitude:coor.longitude];
       [rever reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
           
           CLPlacemark *place = placemarks.lastObject;
           
           NSLog(@"名字=%@",place.name);
           
           NSLog(@"地理信息 %@",location);
       }];
        
    });
}
@end
