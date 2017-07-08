//
//  XLTimeLineChart.m
//  ICoo
//
//  Created by JuniorKey on 9/26/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLTimeLineChart.h"
#import "XLTimeLineDetailChart.h"
#import "XLTimeLineM.h"
@interface XLTimeLineChart()
{
    /// headerView的高度
    CGFloat         _headerViewHeight;
    /// 上下的间距
    CGFloat         _upDownMargin;
    /// 单元格的高度
    CGFloat         _cellHeight;
    ///单元格的宽度
    CGFloat         _cellWidth;
    ///时间轴线的个数
    NSUInteger     _timeLineCount;
    
}
/** 明细数据*/
@property (nonatomic,strong) XLTimeLineDetailChart* detailChart;
/** 明细数据*/
@property (nonatomic,strong) XLTimeLineMs* timeLineMs;
@end
@implementation XLTimeLineChart
-(instancetype)initWithFrame:(CGRect)frame zoomType:(ChartZoomType)zoomType
{
    NSString*       timeLineCount;
    
    self = [super initWithFrame:frame zoomType:zoomType];
    _cellHeight = 20;
    _headerViewHeight = 80;
    self.leftMargin = 5;
    self.topMargin = 5;
    _timeLineCount = 1;
    _cellWidth = kScreenWidth;
    /*if (IS_IPHONE_4 || IS_IPHONE_5) {
        _timeLineCount = 1;
        _cellWidth = kScreenWidth;
    }else if(IS_IPHONE_6 || IS_IPHONE_6_PLUS){
        _timeLineCount = 2;
        _cellWidth = kScreenWidth/2;
    }
    timeLineCount = [ICooUserDefaults objectForKey:kTimeLineCountKey];
    if (timeLineCount) _timeLineCount = [timeLineCount integerValue];*/
    _detailChart = [[XLTimeLineDetailChart alloc]initWithFrame:CGRectMake(frame.origin.x, _headerViewHeight, frame.size.width, frame.size.height)];
    _detailChart.cellWidth = _cellWidth;
    _detailChart.cellHeight = _cellHeight;
    _detailChart.leftMargin = self.leftMargin;
    /// 时间轴线的个数
    _detailChart.timeLineCount = _timeLineCount;
    [self addSubview:_detailChart];
    self.userInteractionEnabled = YES;
    _upDownMargin = 5;
    return self;
}
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self drawFrame:rect];
}
-(void)drawFrame:(CGRect)rect
{
    NSString*           text;
    CGSize              textSize;
    int                 index;
    CGFloat             x;
    CGFloat             y;
    
    if (self.dataSource.count <= 0) return;
    text = [NSString stringWithFormat:@"截止到昨日库存数量为:%ld %@",(long)_timeLineMs.currentQty,_timeLineMs.unit];
    textSize = [_pGraphicEngine mCalcuateTextSizeText:text textAttr:self.fontAttr];
    x = self.leftMargin;
    y = self.topMargin;
    [_pGraphicEngine mDrawText:text Point:CGPointMake(x,y) textAttr:self.fontAttr];
    y += textSize.height + _upDownMargin;
    text = [NSString stringWithFormat:@"最近%ld天数出入库情况:[+:代表入库，-:代表出库]",(long)_timeLineMs.days];
    textSize = [_pGraphicEngine mCalcuateTextSizeText:text textAttr:self.fontAttr];
    y += textSize.height + _upDownMargin;
    [_pGraphicEngine mDrawText:text Point:CGPointMake(x,y) textAttr:self.fontAttr];
    // 如果只有一个时间轴居中显示
    if (_timeLineCount == 1) x = kScreenWidth/2;
    else x = self.leftMargin + _cellWidth/2;
    y = _headerViewHeight - _cellHeight;
    for (index = 0; index < _timeLineCount; index++) {
        x += _cellWidth * index;
        [self drawDatasX: x y:y textHeight:_cellHeight];
    }
    
}

-(void)drawDatasX:(CGFloat)centerLineX y:(CGFloat)centerLineY textHeight:(CGFloat)textHeight {
    
    CGPoint         startPoint;
    CGPoint         endPoint;
    LineProperty    lineProperty;
    NSString*       text;
    CGSize          textSize;
    ArrowAttr       arrowAttr;
    CGFloat         margin;
    
    margin = 0;
    arrowAttr = [_pGraphicEngine defaultArrowAttr];
    arrowAttr.arrowDirection = arrowDirection_down;
    arrowAttr.strokColor = kCGBlueColor;
    arrowAttr.radius = 2;
    lineProperty = [_pGraphicEngine defaultLineProperty];
    lineProperty.lineWidth = 2;
    lineProperty.stroColor = kCGBlueColor;
    text = @"日期";
    textSize = [_pGraphicEngine mCalcuateTextSizeText:text textAttr:self.fontAttr];
    [_pGraphicEngine mDrawText:text Point:CGPointMake(centerLineX - textSize.width - margin, centerLineY) textAttr:self.fontAttr];
    text = @"库存数量";
    [_pGraphicEngine mDrawText:text Point:CGPointMake(centerLineX + 2 + margin, centerLineY) textAttr:self.fontAttr];
}

-(void)setDataSource:(NSMutableArray *)dataSource
{
    [super setDataSource:dataSource];
    _detailChart.dataSource = dataSource;
    _timeLineMs = dataSource[0];
}


@end
