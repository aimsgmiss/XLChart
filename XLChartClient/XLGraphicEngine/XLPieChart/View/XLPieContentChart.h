//
//  XLPieContentChart.h
//  ICoo
//
//  Created by JuniorKey on 10/31/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLBaseChart.h"
@class XLPieChart;
@interface XLPieContentChart : XLBaseChart
{
    @public
    PieChartType    _pieChartType;
}
@property (nonatomic,weak) XLPieChart* pieChart;
-(instancetype)initWithFrame:(CGRect)frame zoomType:(ChartZoomType)zoomType  pieChartType:(PieChartType)pieChartType;
@end
