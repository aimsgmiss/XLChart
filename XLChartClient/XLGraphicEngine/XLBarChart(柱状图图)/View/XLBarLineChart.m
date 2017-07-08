//
//  XLBarChart.m
//  XLGraphicEngine
//
//  Created by JuniorKey on 16/8/31.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//

#import "XLBarLineChartDetail.h"
#import "XLChart.h"
#import "UIView+ICoo.h"

#define     kBtnHeight                      20
#define     kSegmentControlH                20
#define     kHeaderSegmentViewH             40
#define     kBarBKColor                     [UIColor colorWithRed:0 green:1 blue:0.8 alpha:1]
#define     kTitleRectangleMargin           2
#define     kIphone6plusLeftMargin          40
#define     kIphone6plusTopMargin           10
#define     kIphone6plusBottonMargin        20
#define     kMargin                         5
#define     kDeflateBarLineChartMaxRowCount 20
@interface XLBarChart ()
{
    LineProperty    _lineProperty;
    TextAttr        _textAttr;
    /// x轴上边数据的最大值
    CGFloat         _xMaxUpValue;
    /// 明细图与标题试图的上边距
    CGFloat         _barChartDetailTopMargin;
}

/** 柱状图明细(当方向为水平向右时)*/
@property (nonatomic,strong) XLBarChartDetail* barChartDetail;

@end

@implementation XLBarChart


-(instancetype)initWithFrame:(CGRect)frame type:(EBarChartType)chartType zoomType:(ChartZoomType)zoomType
{
    CGRect      rect;
    CGFloat     barCharHeaderH;
    CGFloat     barCharHeaderW;
    CGFloat     y;
    CGFloat     bottomAxisMargin;
    CGFloat     topAxisMargin;
    
    self = [super initWithFrame:frame zoomType:zoomType];
    self.leftMargin = 0;
    self.topMargin = 0;
    self.bottomMargin = 5;
    barCharHeaderH = 0;
    self.delegate = self;
    _chartType = chartType;
    _xMaxUpValue = 0;
     self.userInteractionEnabled = YES;
    [self setBackgroundColor:kWhiteColor];
    self.titlRectChart = [[XLTitleRectangleChart alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, self.titlRectChartHeight) zoomType:zoomType];
    [self addSubview:self.titlRectChart];
    y = self.topMargin + self.titlRectChart.height;
    if (_chartType == barChartType_DirectionRight) {
        barCharHeaderH = self.titlRectChartHeight + 10;
        rect = CGRectMake(self.leftMargin, y, frame.size.width,barCharHeaderH);
        self.topAxisChart = [[XLAxisChart alloc]initWithFrame:rect zoomType:zoomType];
        self.topAxisChart.axisType = AxisChart_top;
        y += self.topAxisChart.height;
        rect = CGRectMake(self.leftMargin, y, frame.size.width, frame.size.height - barCharHeaderH);
        _barChartDetail = [[XLBarChartDetail alloc]initWithFrame:rect zoomType:zoomType];
        self.leftMargin = 5;
        self.rightMargin = 5;
        self.leftAxisMargin = 50;
        self.rightAxisMargin = self.leftAxisMargin;
        self.topAxisChart.leftAxisMargin = self.leftAxisMargin;
        self.topAxisChart.rightAxisMargin = self.rightAxisMargin;
        _barChartDetail.superViewLeftAxisMargin = self.leftAxisMargin;
    } else if(_chartType == barChartType_DirectionUp){
        barCharHeaderW = 50;
        bottomAxisMargin = 25;
        topAxisMargin = 5;
        self.leftMargin = 5;
        self.rightMargin = 15;
        rect = CGRectMake(self.leftMargin,y, barCharHeaderW ,self.height - bottomAxisMargin - topAxisMargin);
        self.leftAxisChart = [[XLAxisChart alloc]initWithFrame:rect zoomType:zoomType];
        self.leftAxisChart.axisType = AxisChart_left;
        rect = CGRectMake(self.leftAxisChart.width, y, self.width - self.leftAxisChart.width, self.height - bottomAxisMargin - topAxisMargin);
        _barChartDetail = [[XLBarChartDetail alloc]initWithFrame:rect zoomType:zoomType];
        self.leftAxisChart.topAxisMargin = topAxisMargin;
        _barChartDetail.topAxisMargin = topAxisMargin;
        self.leftAxisChart.bottomAxisMargin = bottomAxisMargin;
        _barChartDetail.bottomAxisMargin = bottomAxisMargin;
    }
    _barChartDetail.contentSize = CGSizeMake(600, 800);
    _barChartDetail->_chartType = _chartType;
    if (self.leftAxisChart) [self addSubview:self.leftAxisChart];
    if (self.topAxisChart)  [self addSubview:self.topAxisChart];
    [self addSubview:_barChartDetail];
    return self;
}

-(void)setDataSource:(NSMutableArray *)dataSource
{
    NSMutableArray*             deflateArrayM;
    NSUInteger                  index;
    
    self.barCharMs = dataSource[0];
    if (self.leftAxisChart) {
        self.leftAxisChart.yLeftAxisScaleDatas = _barCharMs.yLeftAxisScaleDatas;
        if (self.leftAxisChart.minAxisScaleValue < 0) self.barChartDetail.xAxisInYAxisMiddle = YES;
        if (self.leftAxisChart.yLeftAverScaleLen > 0) self.barChartDetail.yLeftAverScaleLen = self.leftAxisChart.yLeftAverScaleLen;
    }
    if (self.topAxisChart) {
         self.topAxisChart.xTopAxisScaleDatas = _barCharMs.xTopAxisScaleDatas;
         if (self.topAxisChart.xTopAverScaleLen > 0) self.barChartDetail.xTopAverScaleLen = self.topAxisChart.xTopAverScaleLen;
    }
    self.barChartDetail.barChartMs = _barCharMs;
    if (_zoomType == ChartZoomTypeDeflate) {
        if (_barCharMs.barChartMs.count > kDeflateBarLineChartMaxRowCount) {
            deflateArrayM = [NSMutableArray arrayWithCapacity:kDeflateBarLineChartMaxRowCount];
            for (index = 0; index < kDeflateBarLineChartMaxRowCount; index++) {
                [deflateArrayM addObject:_barCharMs.barChartMs[index]];
            }
            self.barChartDetail.dataSource = deflateArrayM;
        } else self.barChartDetail.dataSource = _barCharMs.barChartMs;
    } else self.barChartDetail.dataSource = _barCharMs.barChartMs;
}

#pragma mark GestureRecognizer
-(void)tapGestureRecogizer:(UITapGestureRecognizer*)tapGesture
{
    
}

#pragma mark - UISrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [scrollView setNeedsDisplay];
}
@end
