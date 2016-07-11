//
//  AnnotationModel.h
//  自定义大头针
//
//  Created by puyantao on 16/5/22.
//  Copyright © 2016年 puyantao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AnnotationModel : NSObject<MKAnnotation>

@property (nonatomic, assign)CLLocationCoordinate2D coordinate;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *subtitle;



@end
