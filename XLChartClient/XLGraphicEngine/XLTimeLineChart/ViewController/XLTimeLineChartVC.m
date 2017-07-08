
//
//  XLTimeLineChartVC.m
//  ICoo
//
//  Created by JuniorKey on 9/23/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLTimeLineChartVC.h"
#import "XLTimeLineM.h"
#import "XLTimeLineChart.h"
@interface XLTimeLineChartVC()
@property (nonatomic,strong) XLTimeLineChart* timeChart;
@end
@implementation XLTimeLineChartVC
-(void)awakeFromNib
{
    int             index;
    NSMutableArray* arrayM;
    XLTimeLineMs*   timeLineMs;
    XLTimeLineM*    timeLineM;

    timeLineMs = [[XLTimeLineMs alloc]init];
    timeLineMs.days = 120;
    timeLineMs.unit = @"PCS";
    timeLineMs.currentQty = 1000;
    for (index = 0; index < timeLineMs.days; index++) {
        timeLineM = [[XLTimeLineM alloc]init];
        timeLineM.type = [NSString stringWithFormat:@"%d",rand()%2];
        timeLineM.date = [[NSDate date] dateByAddingTimeInterval: (-1 * 24 * 60 * 60 * (timeLineMs.days - index))];
        timeLineM.inventoryQty = [NSString stringWithFormat:@"%d",rand()%10000];
        timeLineM.qty = [NSString stringWithFormat:@"%d",rand()%1000];
        [timeLineMs.timeLineMs addObject:timeLineM];
    }
    arrayM = [NSMutableArray array];
    [arrayM addObject:timeLineMs];
    
    _timeChart = [[XLTimeLineChart alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _timeChart.dataSource = arrayM;
    [self.view addSubview:_timeChart];
}
@end
