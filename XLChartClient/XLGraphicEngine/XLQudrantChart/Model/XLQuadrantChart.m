//
//  XLQuadrantChart.m
//  XLGraphicEngine
//
//  Created by JuniorKey on 16/8/29.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//

#import "XLChart.h"
#import "XLQuadrantChartDetail.h"

#define     kQuadrantBtnW           4
#define     kQuadrantBtnH           kQuadrantBtnW
#define     kYScaleCount            5 //y轴方向的刻度个数



@interface XLQuadrantChart()<UIGestureRecognizerDelegate>
{
    /// 放大缩小手势
    UIPinchGestureRecognizer*   _pinchRecognizer;
    /// 滑动手势
    UIPanGestureRecognizer*     _panRecongnizer;
    /// 最后一次缩放比例
    CGFloat                     _lastScale;
}

/** quadrantChart(散点图明细) */
@property (nonatomic,strong) XLQuadrantChartDetail* quadChartDetail;

@end
@implementation XLQuadrantChart


-(instancetype)initWithFrame:(CGRect)frame zoomType:(ChartZoomType)zoomType
{
    CGRect      rect;
    CGFloat     bottomAxisMargin;
    CGFloat     topAxisMargin;
    CGFloat     bottomAxisChartH;
    CGFloat     x;
    CGFloat     y;
    CGFloat     leftAxisW;
    CGFloat     leftAxisH;
    CGFloat     quadChartDetaW;
    CGFloat     quadChartDetaH;
    CGFloat     bottomAxisW;
    CGFloat     bottomAxisH;
    
    self = [super initWithFrame:frame zoomType:zoomType];
    //_pinchRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(HandleGesture:)];
    //_pinchRecognizer.delegate = self;
    //[self addGestureRecognizer:_pinchRecognizer];
    self.leftMargin = 2;
    self.rightMargin = 20;
    self.topMargin = 22;
    self.bottomMargin = 10;
    bottomAxisMargin = 5;
    topAxisMargin = 5;
    bottomAxisChartH = 30;
    leftAxisW = 50;
    self.delegate = self;
    self.contentSize = CGSizeMake(kScreenWidth + 100, 400);
  
    x = self.leftMargin;
    self.titlRectChart = [[XLTitleRectangleChart alloc]initWithFrame:CGRectMake(x, 0, self.width, self.titlRectChartHeight) zoomType:zoomType];
    self.titlRectChart.userInteractionEnabled = YES;
    
    y = self.titlRectChart.bottom;
    leftAxisH = self.height - self.titlRectChart.height - bottomAxisChartH;
    rect = CGRectMake(x, y, leftAxisW, leftAxisH);
    self.leftAxisChart = [[XLAxisChart alloc]initWithFrame:rect zoomType:zoomType];
    self.leftAxisChart.axisType = AxisChart_left;
    self.leftAxisChart.bottomAxisMargin = bottomAxisMargin;
    self.leftAxisChart.topAxisMargin = topAxisMargin;
    
    x = self.leftAxisChart.right;
    quadChartDetaW = self.width - self.leftAxisChart.width;
    quadChartDetaH = self.leftAxisChart.height;
    rect = CGRectMake(x, y, quadChartDetaW, quadChartDetaH);
    _quadChartDetail = [[XLQuadrantChartDetail alloc]initWithFrame:rect zoomType:zoomType];
    
    x = self.leftAxisChart.right;
    y = self.leftAxisChart.bottom;
    bottomAxisW = quadChartDetaW;
    bottomAxisH = self.height - self.leftAxisChart.height;
    rect = CGRectMake(x, y, bottomAxisW, bottomAxisH);
    self.bottomAxisChart = [[XLAxisChart alloc]initWithFrame:rect zoomType:zoomType];
    self.bottomAxisChart.axisType = AxisChart_bottom;
    self.bottomAxisChart.leftAxisMargin = 5;
    self.bottomAxisChart.rightAxisMargin = 25;
    
    _quadChartDetail.xBottomAxisWidth = self.bottomAxisChart.width;
    _quadChartDetail.yLeftAxisHeight = self.leftAxisChart.height;
    self.xBottomAxisWidth = self.bottomAxisChart.width;
    self.yLeftAxisHeight = self.leftAxisChart.width;
    [self addSubview:self.titlRectChart];
    if (self.leftAxisChart) [self addSubview:self.leftAxisChart];
    if (self.bottomAxisChart) [self addSubview:self.bottomAxisChart];
    [self addSubview:_quadChartDetail];
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

-(void)setDataSource:(NSMutableArray *)dataSource
{

    [super setDataSource:dataSource];
    self.quadrantMs = dataSource[0];
    self.xBottomAxisScaleDatas = _quadrantMs.xBottomAxisScaleDatas;
    if (self.leftAxisChart) self.leftAxisChart.yLeftAxisScaleDatas =  _quadrantMs.yLeftAxisScaleDatas;
    if (self.bottomAxisChart) self.bottomAxisChart.xBottomAxisScaleDatas = _quadrantMs.xBottomAxisScaleDatas;
    if (_quadChartDetail) _quadChartDetail.dataSource = _quadrantMs.quadrantMs;
    
}

@end
