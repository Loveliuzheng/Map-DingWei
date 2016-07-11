//
//  AudModel.h
//  大头针高级操作
//
//  Created by cqy on 16/5/25.
//  Copyright © 2016年 刘征. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface AudModel : NSObject<MKAnnotation>


@property(nonatomic,assign)CLLocationCoordinate2D coordinate;

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subtitle;
//指代大头针类型
@property(nonatomic,strong)NSNumber *type;
//将字典转化为数据模型
-(instancetype)initWithDict:(NSDictionary *)dict;


@end
