//
//  XLBarChartDetail.m
//  ICoo
//
//  Created by JuniorKey on 9/30/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLBarLineChartDetail.h"
#import "XLBarLineChartM.h"
#import "XLBarLineChartCell.h"
#import "XLPopupChartM.h"
#import "XLPopupChart.h"

#define     kBarMarginBar           3

@interface XLBarChartDetail()
{
    /// y轴左边数据的最大值宽度
    CGFloat         _yMaxLeftValueWidth;
    /// y轴右边数据的最大值
    CGFloat         _yMaxRightValue;
    /// y轴左边数据的最大值
    CGFloat         _yMaxLeftValue;
}
/** 存放XLBarChartCell的数组*/
@property (nonatomic,strong) NSMutableArray* barChartCells;
/** 存放柱状按钮，用于清空 */
@property (nonatomic,strong) NSMutableArray* shapLayers;

@end
@implementation XLBarChartDetail
XLAddMethodImTemplate(barChartCells)
XLAddMethodImTemplate(shapLayers);
-(instancetype)initWithFrame:(CGRect)frame zoomType:(ChartZoomType)zoomType
{
    self = [super initWithFrame:frame zoomType:zoomType];
    self.topMargin = 10;
    self.bottomMargin = 45;
    self.userInteractionEnabled = YES;
    self.delegate = self;
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

-(void)setDataSource:(NSMutableArray *)dataSource
{
    XLBarLineChartM*    barChartM;
    CGFloat             x;
    CGFloat             y;
    CGFloat             width;
    CGFloat             height;
    XLBarLineChartCell* barChartCell;
    NSInteger           barChartCellCount;
    NSInteger           dataSourceCount;
    NSInteger           index;
    NSInteger           tempIndex;
    CGFloat             margin;
    CGFloat             cellHeight;
    CGFloat             cellWidth;
    CGFloat             scrollX;
    CGFloat             scrollY;
    CGFloat             cellBarCount;
    CGFloat             defaultBarWidth;
    
    cellBarCount = 0;
    dataSourceCount = dataSource.count;
    if (dataSourceCount <= 0) return;
    margin = 5;
    scrollY = self.topMargin;
    defaultBarWidth = 0;
    [super setDataSource:dataSource];
    y = self.topMargin;
    x = self.leftMargin;
    index = 0;
    for (barChartM in dataSource) {
        cellBarCount = 0;
        if (barChartM.number) cellBarCount++;
        if (barChartM.number2) cellBarCount++;
        if (barChartM.number3) cellBarCount++;
        if (IS_IPHONE_5 || IS_IPHONE_4) defaultBarWidth = 10;
        else if(IS_IPHONE_6 || IS_IPHONE_6_PLUS) defaultBarWidth = 15;
        NSAssert(defaultBarWidth != 0, @"");
        if (_chartType == barChartType_DirectionRight) {
            cellHeight = cellBarCount * (defaultBarWidth + margin);
            self.cellHeight = cellHeight;
            barChartM.scrollY = y;
            barChartM.cellHeight = cellHeight;
            y += cellHeight;
        } else if (_chartType == barChartType_DirectionUp) {
            if (cellBarCount > 0) cellWidth = cellBarCount * (defaultBarWidth + margin);
            else cellWidth = 3 * (defaultBarWidth + margin);
            self.cellWidth = cellWidth;
            barChartM.scrollX = x;
            barChartM.cellWidth = cellWidth;
            x += cellWidth;
        }
        //线性图
        if (index == 0 && (index + 1) < dataSource.count) barChartM.suffixBarCharLineM = dataSource[index + 1];
        else if(index == dataSource.count - 1) barChartM.preBarCharLineM = dataSource[index - 1];
        else {
            barChartM.preBarCharLineM = dataSource[index - 1];
            barChartM.suffixBarCharLineM = dataSource[index + 1];
        }
        index++;
        
    }
    width = self.contentSize.width;
    height = self.contentSize.height;
    if (_chartType == barChartType_DirectionRight) barChartCellCount = (kScreenHeight - self.topMargin) / self.cellHeight;
    else barChartCellCount = width / self.cellWidth;
    if (barChartCellCount > dataSourceCount) barChartCellCount = dataSourceCount;
    y = self.topMargin;
    x = self.leftMargin;
    for (index = 0; index < barChartCellCount; index++) {
        barChartM = dataSource[index];
        if (_chartType == barChartType_DirectionRight) {
            barChartCell = [[XLBarLineChartCell alloc]initWithFrame:CGRectMake(x, y, width, self.cellHeight) zoomType:_zoomType];
            barChartCell.leftMargin = self.superViewLeftAxisMargin;
            barChartCell.xTopAverScaleLen = self.xTopAverScaleLen;
            barChartCell.xTopAxisScaleDatas = _barChartMs.xTopAxisScaleDatas;
            y += self.cellHeight;
        } else {
            barChartCell = [[XLBarLineChartCell alloc]initWithFrame:CGRectMake(x, 0, self.cellWidth, self.height) zoomType:_zoomType];
            //barChartCell.leftMargin = self.superViewLeftAxisMargin;
            barChartCell.yLeftAverScaleLen = self.yLeftAverScaleLen;
            barChartCell.leftMargin = 2;
            barChartCell.yLeftAxisScaleDatas = _barChartMs.yLeftAxisScaleDatas;
            barChartCell.bottomAxisMargin = self.bottomAxisMargin;
            barChartCell.topAxisMargin = self.topAxisMargin;
            x += self.cellWidth;
            if (self.xAxisInYAxisMiddle) barChartCell.xAxisInYAxisMiddle = YES;
            else barChartCell.xAxisInYAxisMiddle = NO;
        
        }
        barChartCell->_chartType = _chartType;
        barChartCell.barCount = cellBarCount;
        barChartCell.barChartM = barChartM;
        [self addSubview:barChartCell];
        [self.barChartCells addObject:barChartCell];
    }
    if (_chartType == barChartType_DirectionRight) self.contentSize = CGSizeMake(self.width,  self.cellHeight * dataSource.count);
    else self.contentSize = CGSizeMake(self.cellWidth * dataSource.count, self.height);
    
}

-(void)tapGestureRecogizer:(UITapGestureRecognizer*)tapGesture
{
    if (_chartType == barChartType_DirectionRight) {
        CGPoint             touchPoint;
        XLBarLineChartM*        barChartM;
        XLPopupChartM*      popupChartM;
        NSDictionary*       fontAttr;
        
        [super tapGestureRecogizer:tapGesture];
        touchPoint = [tapGesture locationInView:self];
        touchPoint = [ICooKeyWindonw convertPoint:touchPoint toWindow:nil];
        for (barChartM in self.dataSource) {
            if (CGRectContainsPoint(barChartM.rect, touchPoint)) {
               
                self.popupChart = [[XLPopupChart alloc]initWithFrame:CGRectMake(touchPoint.x, touchPoint.y, 100, 50)];
                popupChartM = [[XLPopupChartM alloc]init];
                popupChartM.contentDic = @{barChartM.name:barChartM.number,barChartM.name:barChartM.number,barChartM.name:barChartM.number,barChartM.name:barChartM.number,barChartM.name:barChartM.number,barChartM.name:barChartM.number,barChartM.name:barChartM.number,barChartM.name:barChartM.number,barChartM.name:barChartM.number,barChartM.name:barChartM.number,barChartM.name:barChartM.number};
                popupChartM.touchPoint = touchPoint;
                self.popupChart.popupChartM = popupChartM;
                fontAttr = self.fontAttr;
                popupChartM.fontAttr = fontAttr;
                [self insertSubview:self.popupChart aboveSubview:self];
                break;
            }
            
        }
    } else {
        
        CGPoint             touchPoint;
        CAShapeLayer*       shapeLayer;
        NSInteger           index;
        XLBarLineChartM*        barChartM;
        XLPopupChartM*      popupChartM;
        NSString*           number;
        
        if (self.popupChart) [self.popupChart removeFromSuperview];
        touchPoint = [tapGesture locationInView:self];
        for (index = 0 ;index < self.shapLayers.count;index++) {
            shapeLayer = [self.shapLayers objectAtIndex:index];
            if (CGPathContainsPoint(shapeLayer.path, NULL, touchPoint, false)) {
            }
        }
        
        NSLog(@"tapGesture");
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self changeBarChartCellDataScroll:scrollView];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self changeBarChartCellDataScroll:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self changeBarChartCellDataScroll:scrollView];
    
}
-(void)changeBarChartCellDataScroll:(UIScrollView*)scrollView
{
    NSInteger           index;
    XLBarLineChartM*    barChartM;
    NSInteger           startIndex = 0;
    CGPoint             offset;
    XLBarLineChartCell* barChartCell;
    
    if (self.popupChart)[self.popupChart removeFromSuperview];
    offset = [scrollView contentOffset];
    for (index = 0; index < self.dataSource.count; index++) {
        barChartM = self.dataSource[index];
        if (_chartType == barChartType_DirectionRight) {
            if (offset.y >= barChartM.scrollY  && barChartM.scrollY + barChartM.cellHeight > offset.y) {
                startIndex = index;
                break;
            }
        } else {
            if (offset.x <= 0) {
                startIndex = index;
                break;
            }
            if (offset.x >= barChartM.scrollX && barChartM.scrollX + barChartM.cellWidth  > offset.x ) {
                startIndex = index;
                break;
            }
        }
    }
    for (index = 0; index < _barChartCells.count; index++) {
        barChartM = self.dataSource[startIndex];
        barChartCell = _barChartCells[index];
        barChartCell.barChartM = barChartM;
        if (_chartType == barChartType_DirectionRight) barChartCell.frame = CGRectMake(barChartM.rect.origin.x - barChartCell.leftMargin, barChartM.scrollY, barChartCell.width, barChartCell.height);
        else barChartCell.frame = CGRectMake(barChartM.scrollX, barChartCell.top, barChartCell.width, barChartCell.height);
        startIndex++;
        if(startIndex >= self.dataSource.count) break;
        [barChartCell setNeedsDisplay];
    }
}

@end
