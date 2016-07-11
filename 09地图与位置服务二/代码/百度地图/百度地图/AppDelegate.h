//
//  AppDelegate.h
//  百度地图
//
//  Created by GG on 16/5/25.
//  Copyright © 2016年 GG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKMapManager.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BMKMapManager* _mapManager;
}
@property (strong, nonatomic) UIWindow *window;


@end

