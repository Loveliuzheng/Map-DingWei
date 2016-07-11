//
//  ViewController.m
//  大头针高级操作
//
//  Created by GG on 16/5/25.
//  Copyright © 2016年 GG. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "AnnotationModel.h"
#import "CustomAnnatationView.h"
@interface ViewController ()<MKMapViewDelegate>
{
    MKMapView *_mapView;
    CLLocationManager *locationManager;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc]init];
    
    [locationManager requestWhenInUseAuthorization];
    _mapView = [[MKMapView alloc]initWithFrame:self.view.frame];
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    //延迟调用加载大头针数据模型的方法
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1];

}

- (void)loadData{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"PinData.plist" ofType:nil];
    
    NSArray *tempArray = [NSArray arrayWithContentsOfFile:path];
    
    /*
     * 大头针显示在地图试图上面，三步
     
     * 1、准备大头针数据模型
     * 2、将大头针数据模型放到地图试图上
     * 3、通过代理方法，将数据模型包装到大头针试图上
     */
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    //遍历，转model
    for (NSDictionary *dict in tempArray) {
        
        AnnotationModel *model = [[AnnotationModel alloc]initWithDict:dict];
        
        [dataArray addObject:model];
        
    }
    
    [_mapView addAnnotations:dataArray];
    
}


#pragma mark mapView delegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.5, 0.5);
    
    [_mapView setRegion:MKCoordinateRegionMake(center, span) animated:YES];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if([annotation isKindOfClass:[MKUserLocation class]]){
        
        return nil;
    }

    
   // **MKAnnotationView**
    CustomAnnatationView *annotationView = (CustomAnnatationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"ID"];
    
    if (annotationView == nil) {
        
        annotationView = [[CustomAnnatationView alloc]initWithAnnotation:annotation reuseIdentifier:@"ID"];
        
    }
    
    annotationView.canShowCallout = YES;
    
    AnnotationModel *model = (AnnotationModel *)annotation;
    
    switch ([model.type intValue]) {
            
        case 0:{
            
            annotationView.image = [UIImage imageNamed:@"buy"];
            annotationView.label.text = @"超市";
            
        }break;
            
        case 1:{
            
            annotationView.image = [UIImage imageNamed:@"fire"];
            annotationView.label.text = @"火化场";
            
        }break;
            
        case 2:{
            
            annotationView.image = [UIImage imageNamed:@"cammer"];
            annotationView.label.text = @"景点";
            
        }break;

    }
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 100, 50);
    [rightBtn setTitle:@"点击查看" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    annotationView.rightCalloutAccessoryView = rightBtn;
    
    
    return annotationView;
    
    
    
//    //**MKPinAnnotationView
//    MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"ID"];
//    
//    if (pinAnnotationView == nil) {
//        
//        pinAnnotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"ID"];
//    }
//    
////    pinAnnotationView.image = [UIImage imageNamed:@"buy"];
//    
//    //大头针的颜色
//    pinAnnotationView.pinTintColor = [UIColor orangeColor];
//    
//    //设置大头针的动画效果
//    pinAnnotationView.animatesDrop = YES;
//    
//    return pinAnnotationView;
    
}

//大头针添加到试图上面时调用
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views{
    
    CGRect visibleRect = _mapView.frame;
    
    for (MKAnnotationView *view in views) {
        
        if ([view.annotation isKindOfClass:[MKUserLocation class]]) {
            
            return;
        }
        
        CGRect startFrame = view.frame;
        CGRect endFrame = view.frame;
        
        startFrame.origin.y = visibleRect.origin.y - startFrame.size.height;
        
        view.frame = startFrame;
        
        [UIView animateWithDuration:0.5 animations:^{
        
            view.frame = endFrame;
            
        }];
        
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
    NSLog(@"%@",view.annotation.title);
    
}





@end
