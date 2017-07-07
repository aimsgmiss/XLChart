//
//  XLPieChart.h
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/12/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLBaseChart.h"
#import "XLPieContentChart.h"

@interface XLPieChart : XLBaseChart
{
    @public
    PieChartType        _pieChartType;
}
/** 饼图明细*/
@property (nonatomic,strong) XLPieContentChart* pieContentChart;

-(instancetype)initWithFrame:(CGRect)frame zoomType:(ChartZoomType)zoomType pieChartType:(PieChartType)pType;
@end
