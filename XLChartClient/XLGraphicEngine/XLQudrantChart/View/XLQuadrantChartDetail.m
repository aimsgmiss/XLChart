//
//  XLQuadrantChartDetail.m
//  ICoo
//
//  Created by JuniorKey on 12/20/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLQuadrantChartDetail.h"
#import "XLChart.h"

#define     kValueNormal            12
#define     kValueSlow              8
#define     kValueFast              20

typedef enum _TrendOrientation
{
    eTrendOrien_up,                        //箭头方向向上
    eTrendOrien_dwon,
}TrendOrientation;

typedef enum _TrendStatus
{
    eTrendStat_normal,                    //正常增长
    eTrendStat_slow,                      //增长很慢
    eTrendStat_fast,                      //增长很快
}TrendStatus;

typedef struct _arrowStatus
{
    TrendOrientation    trend;
    TrendStatus         status;
    int                 arrowLen;
}ArrowStatus;

#define kTrendOrienUpStatusNormal           ((ArrowStatus){eTrendOrien_up,eTrendStat_normal,kValueNormal})
#define kTrendOrienUpStatusSlow             ((ArrowStatus){eTrendOrien_up,eTrendStat_slow,kValueSlow})
#define kTrendOrienUpStatusFast             ((ArrowStatus){eTrendOrien_up,eTrendStat_fast,kValueFast})
#define kTrendOrienDwonStatusNormal         ((ArrowStatus){eTrendOrien_dwon,eTrendStat_normal,kValueNormal})
#define kTrendOrienDwonStatusSlow           ((ArrowStatus){eTrendOrien_dwon,eTrendStat_slow,kValueSlow})
#define kTrendOrienDwonStatusFast           ((ArrowStatus){eTrendOrien_dwon,eTrendStat_fast,kValueFast})

@interface XLQuadrantChartDetail()
{
    /// XLQuadrantRectangleM 矩形宽度
    CGFloat                     _rectangleWidth;
    /// LQuadrantRectangleM 矩形高度
    CGFloat                     _rectangleHeight;
    /// x轴方XLQuadrantRectangleM 矩形间距
    CGFloat                     _xRectangleMargin;
    /// y轴方向XLQuadrantRectangleM 矩形间距
    CGFloat                     _yRectangleMargin;
}
/** 存放黑色小点的数组 */
@property (nonatomic,strong) NSMutableArray* blackPoints;
/** 原始矩形数组属性 存放XLQuadrantRectangleM */
@property (nonatomic,strong) NSMutableArray* quadrantRectangleMs;

@end
@implementation XLQuadrantChartDetail
XLAddMethodImTemplate(blackPoints)
-(instancetype)initWithFrame:(CGRect)frame zoomType:(ChartZoomType)zoomType{
    
    self = [super initWithFrame:frame zoomType:zoomType];
    self.userInteractionEnabled = YES;
    return self;
}

-(NSMutableArray *)quadrantRectangleMs
{
    int                     index;
    int                     indey;
    XLQuadrantRectangleM*   rectM;
    
    if (!_quadrantRectangleMs) {
        _xRectangleMargin = 1;
        _yRectangleMargin = 8;
        _rectangleWidth = 8;
        _rectangleHeight = 8;
        _quadrantRectangleMs = [NSMutableArray array];
        for (index = self.leftMargin + self.text10000.width; index < self.xBottomAxisWidth + self.leftMargin + self.text10000.width; )
        {
            for (indey = self.topMargin; indey < self.yLeftAxisHeight + self.topMargin;)
            {
                rectM = [[XLQuadrantRectangleM alloc]init];
                rectM.rect = CGRectMake(index, indey, _rectangleWidth, _rectangleHeight);
                rectM.centerPoint = CGPointMake(index + _rectangleWidth/2, indey + _rectangleHeight/2);
                [_quadrantRectangleMs addObject:rectM];
                indey += _yRectangleMargin + _rectangleHeight;
            }
            index += _xRectangleMargin + _rectangleWidth;
        }
        
    }
    
    return _quadrantRectangleMs;
}

-(XLQuadrantRectangleM*)reCalculationPointx:(CGFloat)x y:(CGFloat)y rectCount:(NSInteger)count
{
    XLQuadrantRectangleM*   rectM;
    BOOL                    isInside;
    
    if (self.quadrantRectangleMs.count <= 0) return nil;
    isInside = false;
    //重新计算每个点的位置
    while (!isInside)
    {
        for(int index = 0;index < count;index++)
        {
            rectM = self.quadrantRectangleMs[index];
            if (CGRectContainsPoint(rectM.rect, CGPointMake(x, y)))
            {
                isInside = true;
                x = rectM.centerPoint.x;
                y = rectM.centerPoint.y;
                break;
            }
        }
        if(!isInside){
            y--;
            x--;
            if (x <= self.leftMargin || y <= self.topMargin) {
                rectM = self.quadrantRectangleMs[0];
                rectM.count++;
                return rectM;
            }
        }
    }
    rectM.count++;
    return rectM;
}

-(void)setDataSource:(NSMutableArray *)dataSource{
    NSInteger               rectMcount;
    CGFloat                 yAxisMax = 1;
    
    [super setDataSource:dataSource];
    rectMcount = self.quadrantRectangleMs.count;
    if (rectMcount <= 0) return;
    //求出销售量最大的数值
    for (XLQuadrantM* quadrantModel in dataSource)if (quadrantModel.yAxisData > yAxisMax) yAxisMax = quadrantModel.yAxisData;
     CGFloat yRate = self.yLeftAxisHeight/yAxisMax;
    for (XLQuadrantM* quadrantModel in dataSource)
    {
        CGFloat y = quadrantModel.yAxisData * yRate + self.topMargin;
        CGFloat x = quadrantModel.xAxisData * self.xBottomAxisWidth + self.leftMargin;
        quadrantModel.rectM = [self reCalculationPointx:x y:y rectCount:rectMcount];
    }
}

- (void)drawRect:(CGRect)rect {
   
    [super drawRect:rect];
    [self drawDash];
    [self drawSolidCicle];
}

-(void)drawDash
{
    LineProperty        property;
    NSDictionary*       textAttr;
    NSUInteger          index;
    NSUInteger          xAverSacleLen;
    NSUInteger          xAxisScaleCount;
    NSUInteger          yAverSacleLen;
    NSUInteger          yAxisScaleCount;
    NSString*           text;
    CGSize              textSize;
    CGFloat             x;
    CGFloat             y;
    ArrowAttr           arrowAttr;
    
    CGFloat dashs[] = {5,5};
    property = [_pGraphicEngine defaultLineProperty];
    property.stroColor = kCGLightBlack;
    arrowAttr = [_pGraphicEngine defaultArrowAttr];
    arrowAttr.strokColor = kCGLightBlack;
    // x轴中间虚线带箭头
    property.dashs = dashs;
    property.count = 2;
    property.stroColor = kCGLightBlack;
    x = self.width/2;
    y = self.height;
    [_pGraphicEngine mDrawLineStartPoint:CGPointMake(x, y) EndPoint:CGPointMake(x,10) LineProperty:&property];
    [_pGraphicEngine mDrawArrowStartPoint:CGPointMake(x, 10) EndPoint:CGPointMake(x, 5) arrowAttr:&arrowAttr];
    // y轴上中间虚线带箭头
    arrowAttr.arrowDirection = arrowDirection_right;
    y = self.height/2;
    x = 0;
    [_pGraphicEngine mDrawLineStartPoint:CGPointMake(x, y) EndPoint:CGPointMake(self.width - 10, y) LineProperty:&property];
    [_pGraphicEngine mDrawArrowStartPoint:CGPointMake(self.width - 10, y) EndPoint:CGPointMake(self.width - 5, y) arrowAttr:&arrowAttr];
}

-(void)drawSolidCicle
{
    //    //画隐藏的矩形边框 test
    //    for (XLQuadrantRectangleM* rectM in self.quadrantRectangleMs) {
    //            [_pGraphicEngine mDrawRectangle:rectM.rect RectangleAttr:nil];
    //        CGContextAddArc(_pGraphicEngine.ctx, rectM.centerPoint.x, rectM.centerPoint.y, 3, -2*M_PI, 2*M_PI, 0);
    //    }
    
    ArrowStatus         arrowStat;
    
    for (XLQuadrantM* qModel in self.dataSource)
    {
        /**  商品的趋势 1向上缓慢,2向上正常,3向上快速,4向下缓慢,5向下正常,6向下快速*/
        switch (qModel.trend) {
            case 0:
                arrowStat = kTrendOrienUpStatusNormal;
                break;
            case 1:
                arrowStat = kTrendOrienUpStatusSlow;
                break;
            case 2:
                arrowStat = kTrendOrienUpStatusNormal;
                break;
            case 3:
                arrowStat = kTrendOrienUpStatusFast;
                break;
            case 4:
                arrowStat = kTrendOrienDwonStatusSlow;
                break;
            case 5:
                arrowStat = kTrendOrienDwonStatusNormal;
                break;
            case 6:
                arrowStat = kTrendOrienDwonStatusFast;
                break;
            default:
                arrowStat = kTrendOrienUpStatusNormal;
                break;
        }
        
        [self drawSolid:qModel.rectM trend:arrowStat];
    }
}

-(void)drawSolid:(XLQuadrantRectangleM*)rectM trend:(ArrowStatus)arrowStat
{
    NSValue*        pointValue;
    CGPoint         point;
    ArrowAttr       arrowAttr;
    CircleAttr      circleAttr;
    
    point = rectM.centerPoint;
    circleAttr = [_pGraphicEngine defaultCircleAttr];
    arrowAttr = [_pGraphicEngine defaultArrowAttr];
    arrowAttr.strokColor = kCGBlack;
    arrowAttr.lineWidth = 1;
    arrowAttr.radius = 2;
    arrowAttr.dashs = nil;
    if (rectM.count == 1) circleAttr.fillColor = kCGBlack;
    else if (rectM.count == 2) circleAttr.fillColor = kCGBlueColor;
    else  circleAttr.fillColor = kCGMindColor;
    pointValue = [NSValue valueWithCGPoint:rectM.centerPoint];
    if (![self.blackPoints containsObject:pointValue])[self.blackPoints addObject:pointValue];
    if (rectM.selected)
    {
        circleAttr.fillColor = kCGRedColor;
        arrowAttr.strokColor = kCGRedColor;
    }
    [_pGraphicEngine mDrawCirclePoint:rectM.centerPoint circleAttrs:&circleAttr];
    if (rectM.count > 1) return;
    switch (arrowStat.trend) {
        case eTrendOrien_up:
            arrowAttr.arrowDirection = arrowDirection_up;
            [_pGraphicEngine mDrawArrowStartPoint:point EndPoint:CGPointMake(point.x, point.y - arrowStat.arrowLen) arrowAttr:&arrowAttr];
            break;
        case eTrendOrien_dwon:
            arrowAttr.arrowDirection = arrowDirection_down;
            [_pGraphicEngine mDrawArrowStartPoint:point EndPoint:CGPointMake(point.x, point.y + arrowStat.arrowLen) arrowAttr:&arrowAttr];
            break;
        default:
            break;
    }
}

#pragma mark - UISrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.blackPoints removeAllObjects];
    [scrollView setNeedsDisplay];
}

-(void)tapGestureRecogizer:(UITapGestureRecognizer*) tapGesture
{
    CGPoint         touchPoint;
    NSMutableArray* insidePoints;
    
    [super tapGestureRecogizer:tapGesture];
    touchPoint = [tapGesture locationInView:self];
    insidePoints = [_pGraphicEngine mGetInsidePointsCenter:touchPoint Radius:5 hitPoints:self.blackPoints];
    for (XLQuadrantRectangleM* rectM in self.quadrantRectangleMs)
    {
        if (CGRectContainsPoint(rectM.rect, touchPoint)){
            rectM.selected = !rectM.selected;
            break;
        }
    }
    [self setNeedsDisplay];
    //if ([self.xlQuadrantDelegate respondsToSelector:@selector(clickedNearbyContianPoints:)] && insidePoints.count > 0)[self.xlQuadrantDelegate clickedNearbyContianPoints:insidePoints];
}
-(void)HandleGesture:(UIGestureRecognizer*)sender
{
    
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer

shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return ![gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}


@end
