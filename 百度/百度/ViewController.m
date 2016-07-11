//
//  ViewController.m
//  百度
//
//  Created by cqy on 16/5/25.
//  Copyright © 2016年 刘征. All rights reserved.
//

#import "ViewController.h"
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<BMKPoiSearchDelegate>{
    BMKPoiSearch *_searcher;
    int curPage;
    
    NSArray *dataArray;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    
    [btn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = btn;
}
- (void)search{
    
    //初始化检索对象
    _searcher =[[BMKPoiSearch alloc]init];
    _searcher.delegate = self;
    
    //发起检索
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    
    option.pageIndex = curPage;
    option.pageCapacity = 10;
    
    option.location = CLLocationCoordinate2DMake(34.71445, 113.516369);
    
    option.keyword = @"小吃";
    
    BOOL flag = [_searcher poiSearchNearBy:option];
    
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
//实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    dataArray = poiResultList.poiInfoList;
    
    [self.tableView reloadData];
    
}
//不使用时将delegate设置为 nil
-(void)viewWillDisappear:(BOOL)animated
{
    _searcher.delegate = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"id"];
    }
    
    BMKPoiInfo *model = dataArray[indexPath.row];
    
    cell.textLabel.text = model.name;
    
    
    return cell;
    
}






@end
