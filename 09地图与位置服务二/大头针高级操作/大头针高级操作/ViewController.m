//
//  ViewController.m
//  大头针高级操作
//
//  Created by cqy on 16/5/25.
//  Copyright © 2016年 刘征. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "AudModel.h"
#import "CustomAnnotationView.h"
@interface ViewController ()<MKMapViewDelegate>{
    MKMapView *_mapView;
    
    CLLocationManager *manger;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    manger = [[CLLocationManager alloc]init];
    [manger requestWhenInUseAuthorization];
    
    
    _mapView = [[MKMapView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_mapView];

    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
        _mapView.delegate = self;
    //延迟调用加载大头针数据模型的方法
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1];
}
-(void)loadData{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"PinData.plist" ofType:nil];
    
    NSArray *tempArray = [NSArray arrayWithContentsOfFile:path];
    
    /*
     *大头针显示在地图试图上面，三步
     *1.准备大头针数据模型
     *2.将大头针数据模型放到地图试图上
     *3.通过代理方法，将数据模型包装到大头针试图上
     */
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dict in tempArray) {
        
      AudModel *model =[[AudModel alloc]initWithDict:dict];
        
        [array addObject:model];
    }
    
    [_mapView addAnnotations:array];
}
#pragma mark mapView dalegate
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    _mapView.centerCoordinate = userLocation.coordinate;
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.5, 0.5);
    
    [_mapView setRegion:MKCoordinateRegionMake(center, span) animated:YES];
}
#pragma mark 自定义设置大头针图片
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
                return nil;
}

    CustomAnnotationView *annView = (CustomAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:@"ID"];
    
    if (annView == nil) {
        
        annView = [[CustomAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"ID"];
        
    }
    
    annView.canShowCallout =YES;
    
    AudModel *model = (AudModel *)annotation;
    
    switch ([model.type intValue]) {
            
        case 0:{
            
            annView.image = [UIImage imageNamed:@"buy"];
            annView.label.text = @"超市";
    
        }break;
            
        case 1:{
            
            annView.image = [UIImage imageNamed:@"fire"];
            annView.label.text = @"火葬场";

        }break;
            
        case 2:{
            
            annView.image = [UIImage imageNamed:@"cammer"];
            annView.label.text = @"广场";

        }break;
            
    }
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 100, 50);
    [rightBtn setTitle:@"点击查看" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    annView.rightCalloutAccessoryView = rightBtn;
    return annView;
}
#pragma mark 设置颜色动画效果
//-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
//    
//    
//    if ([annotation isKindOfClass:[MKUserLocation class]]) {
//        return nil;
//    }
//    
//    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"ID"];
//    
//    if (pinView == nil) {
//        
//        pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"ID"];
//    }
//    //大头针的颜色
//    pinView.pinTintColor = [UIColor yellowColor];
//    //大头针的动画效果
//    
//    
//    pinView.animatesDrop = YES;
//    
//    return pinView;
//}
#pragma mark 自定义动画效果
-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views{
    
   
    CGRect visibleRect = _mapView.frame;
    for (MKAnnotationView *view in views) {
        
        
        if ([view.annotation isKindOfClass:[MKUserLocation class]]) {
            
            return;
        }
        CGRect endFrame = view.frame;
        CGRect startFrame = endFrame;
        startFrame.origin.y = visibleRect.origin.y - startFrame.size.height;
        view.frame = startFrame;
        
        [UIView animateWithDuration:1 animations:^{
            
            view.frame = endFrame;
        }];
        
    }
}
#pragma mark 辅助图标
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{

    
    
    
}
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
    
    NSLog(@"%@",view.annotation.title);
    

}
@end
