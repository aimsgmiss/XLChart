//
//  XLTitleRectangleChart.h
//  ICoo
//
//  Created by JuniorKey on 10/25/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLBaseChart.h"
#import "XLTitleRectangleM.h"
#include "define.h"

@interface XLTitleRectangleChart : XLBaseChart
{
    @public
    /// 滚动方向
    TitleRectChartType          _titleRectChartType;
}
/**  模型*/
@property (nonatomic,strong) XLTitleRectangleM* titleRectM;
/** 标题矩形的宽度 */
@property (nonatomic,assign) CGFloat titleRectWidth;
/** 标题矩形的高度 */
@property (nonatomic,assign) CGFloat titleRectHeight;

-(instancetype)initWithFrame:(CGRect)frame zoomType:(ChartZoomType)zoomType titleRectType:(TitleRectChartType) titleRectChartType;
@end
