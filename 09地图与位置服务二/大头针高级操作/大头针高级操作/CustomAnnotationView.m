//
//  CustomAnnotationView.m
//  大头针高级操作
//
//  Created by cqy on 16/5/25.
//  Copyright © 2016年 刘征. All rights reserved.
//

#import "CustomAnnotationView.h"

@implementation CustomAnnotationView


-(instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self= [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
    
        
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, -15, 50, 15)];
        self.label.font = [UIFont systemFontOfSize:10];
        
        self.label.textColor = [UIColor greenColor];
        
        [self addSubview:self.label];
    }
    
    return self;
}
@end
