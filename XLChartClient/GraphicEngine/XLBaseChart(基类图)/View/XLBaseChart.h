//
//  XLBaseChart.h
//  XLGraphicEngine
//
//  Created by JuniorKey on 16/8/31.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLGraphicEngine.h"


@class XLPopupChart;
@class XLTitleRectangleChart;
@class XLAxisChart;
/**  所有图表的基类*/
@interface XLBaseChart : UIScrollView<UIScrollViewDelegate>
{
    /// 画图引擎
    XLGraphicEngine*            _pGraphicEngine;
    /// 点击手势
    UITapGestureRecognizer*     _tapRecongnizer;
    /// 缩小，放大？正常
    ChartZoomType               _zoomType;
@public
    /// bar Chart
    EBarChartType               _chartType;
}

/** 数据源*/
@property (nonatomic,strong) NSMutableArray* dataSource;
/**  是否被选中*/
@property (nonatomic,assign) BOOL selected;
/** 左边距 */
@property (nonatomic,assign) CGFloat leftMargin;
/** 右边距 */
@property (nonatomic,assign) CGFloat rightMargin;
/** 上边距 */
@property (nonatomic,assign) CGFloat topMargin;
/** 下边距*/
@property (nonatomic,assign) CGFloat bottomMargin;
/** 字体属性*/
@property (nonatomic,retain) NSDictionary* fontAttr;
/** 弹出试图*/
@property (nonatomic,strong) XLPopupChart* popupChart;
/** 标题数组数据源 */
@property (nonatomic,strong) NSArray* titlRectDataSource;
/** 标题试图*/
@property (nonatomic,strong) XLTitleRectangleChart* titlRectChart;
/** 标题矩形试图的高度 */
@property (nonatomic,assign) CGFloat titlRectChartHeight;
/** 10000的大小(在当前字体属性)*/
@property (nonatomic,assign) CGSize text10000;
/**  离合手势出来*/
-(void)tapGestureRecogizer:(UITapGestureRecognizer*)tapGesture;
/**  初始化是否放大， 缩小，正常*/
-(instancetype)initWithFrame:(CGRect)frame zoomType:(ChartZoomType)zoomType;
@end

/**  有坐标轴的图表*/
@interface XLBaseAxisChart : XLBaseChart

/// 轴边距
/**  轴左边边距*/
@property (nonatomic,assign) CGFloat leftAxisMargin;
/**  轴右边边距*/
@property (nonatomic,assign) CGFloat rightAxisMargin;
/**  轴上边边距*/
@property (nonatomic,assign) CGFloat topAxisMargin;
/**  轴下边边距*/
@property (nonatomic,assign) CGFloat bottomAxisMargin;

/// 长度
/**  x轴上边的宽度*/
@property (nonatomic,assign) CGFloat xTopAxisWidth;
/**  x轴下边的宽度*/
@property (nonatomic,assign) CGFloat xBottomAxisWidth;
/**  y轴左边方向的高度*/
@property (nonatomic,assign) CGFloat yLeftAxisHeight;
/**  y轴右边方向的高度*/
@property (nonatomic,assign) CGFloat yRightAxisHeight;
/// 平均刻度
/**  x轴上边平均长度*/
@property (nonatomic,assign) CGFloat xTopAverScaleLen;
/**  x轴下边平均长度*/
@property (nonatomic,assign) CGFloat xBottomAverScaleLen;
/**  y轴左边边平均长度*/
@property (nonatomic,assign) CGFloat yLeftAverScaleLen;
/**  y轴右边平均长度*/
@property (nonatomic,assign) CGFloat yRightAverScaleLen;

/**  y轴方向的刻度的最大值*/
@property (nonatomic,assign) NSInteger yAxisMax;

/// 刻度数据源
/**
    ----------xTopAxisScaleDatas ------
    |                                   |
    |                                   |
    yLeftAxisScaleDatas           yRightAxisScaleDatas
    |                                   |
    |                                   |
    -------- xBottomAxisScaleDatas------
 */
/**  上边x轴方向的刻度数据*/
@property (nonatomic,strong) NSMutableArray*   xTopAxisScaleDatas;
/**  下边x轴方向的刻度数据*/
@property (nonatomic,strong) NSMutableArray*   xBottomAxisScaleDatas;
/**  左边y轴方向的刻度数据*/
@property (nonatomic,strong) NSMutableArray*   yLeftAxisScaleDatas;
/**  右边y轴方向的刻度数据*/
@property (nonatomic,strong) NSMutableArray*   yRightAxisScaleDatas;
/// 轴线图
/** 左轴线*/
@property (nonatomic,strong) XLAxisChart* leftAxisChart;
/** 上边轴线*/
@property (nonatomic,strong) XLAxisChart* topAxisChart;
/** 左轴线*/
@property (nonatomic,strong) XLAxisChart* rightAxisChart;
/** 上边轴线*/
@property (nonatomic,strong) XLAxisChart* bottomAxisChart;



@end
