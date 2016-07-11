//
//  AudModel.m
//  大头针高级操作
//
//  Created by cqy on 16/5/25.
//  Copyright © 2016年 刘征. All rights reserved.
//

#import "AudModel.h"

@implementation AudModel



//将字典转化为数据模型
-(instancetype)initWithDict:(NSDictionary *)dict{
    
    self = [super init];
    if (self) {
        //将字典的经纬度转化为coor变量
      self.coordinate = CLLocationCoordinate2DMake([dict[@"coordinate"][@"latitude"] floatValue], [dict[@"coordinate"][@"longitude"] floatValue]);
        self.title = dict[@"title"];
        self.subtitle = dict[@"subtitle"];
        
        self.type = dict[@"type"];
    }
    return self;
}

@end
