//
//  CustomAnnatationView.m
//  大头针高级操作
//
//  Created by GG on 16/5/25.
//  Copyright © 2016年 GG. All rights reserved.
//

#import "CustomAnnatationView.h"

@implementation CustomAnnatationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, -15, 50, 15)];
        self.label.font = [UIFont systemFontOfSize:10];
        self.label.textColor = [UIColor blackColor];
        [self addSubview:self.label];
        
    }
    
    return self;
    
}

@end
