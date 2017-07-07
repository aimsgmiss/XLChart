//
//  XLPieChart.m
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/12/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//
#import "XLChart.h"
#import "XLPieChartM.h"


@interface XLPieChart ()
{
}

@end
@implementation XLPieChart

-(instancetype)initWithFrame:(CGRect)frame zoomType:(ChartZoomType)zoomType pieChartType:(PieChartType)pType
{
    self = [super initWithFrame:frame zoomType:zoomType];
    _pieChartType = pType;
    _pieContentChart = [[XLPieContentChart alloc]initWithFrame:frame zoomType:zoomType pieChartType:_pieChartType];
    _pieContentChart.pieChart = self;
    self.contentSize = CGSizeMake(kScreenWidth + 100,self.height);
    [self addSubview:_pieContentChart];

    return self;
}

-(void)setDataSource:(NSMutableArray *)dataSource
{
    [super setDataSource:dataSource];
  
    _pieContentChart->_pieChartType = _pieChartType;
    _pieContentChart.dataSource = dataSource;

}

@end



