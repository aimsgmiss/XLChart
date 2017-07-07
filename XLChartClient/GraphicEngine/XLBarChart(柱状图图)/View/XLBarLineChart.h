//
//  XLBarChart.h
//  XLGraphicEngine
//
//  Created by JuniorKey on 16/8/31.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLBaseChart.h"
#import "XLBarLineChartM.h"

@interface XLBarChart : XLBaseAxisChart
/** x轴方向的数据 */
@property (nonatomic,strong) NSArray* xValues;
/**  数据源*/
@property (nonatomic,copy) XLBarLineChartMs* barCharMs;
-(instancetype)initWithFrame:(CGRect)frame type:(EBarChartType)chartType zoomType:(ChartZoomType)zoomType;
@end
