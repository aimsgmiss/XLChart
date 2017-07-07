//
//  XLTimeLineChart.m
//  ICoo
//
//  Created by JuniorKey on 9/23/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//
#import "XLTimeLineDetailChart.h"
#import "XLTimeLineM.h"
#import "XLTimeLineChartCell.h"

@interface XLTimeLineDetailChart()
{
    /// 上下间距
    CGFloat         _upDownMargin;
    /// 时间线的长度
    CGFloat         _yAxisHeight;
    /// 标题栏的高度
    CGFloat         _headerViewHeight;
    ///
    NSInteger       _timeLineCellCount;
}
/**分段之后的数组（数组中包含数组）*/
@property (nonatomic,strong) NSMutableArray* segmentTimeLineMs;
/**每个时间线的开始时间*/
@property (nonatomic,strong) NSMutableArray* startDatesM;
/**包含XLTimeLineChartCell对象数组*/
@property (nonatomic,strong) NSMutableArray* timeLineChartCells;

@end
@implementation XLTimeLineDetailChart
XLAddMethodImTemplate(segmentTimeLineMs)
XLAddMethodImTemplate(startDatesM)
XLAddMethodImTemplate(timeLineChartCells)
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.rightMargin = self.leftMargin;
    self.topMargin = 0;
    self.bottomMargin = 100;
    [self setShowsHorizontalScrollIndicator:YES];
    [self setShowsVerticalScrollIndicator:YES];
    self.userInteractionEnabled = YES;
    _upDownMargin = 5;
    _headerViewHeight = 0;
    self.delegate = self;
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
}

-(void)setDataSource:(NSMutableArray *)dataSource
{
    XLTimeLineMs*           timeLineMs;
    XLTimeLineM*            timeLineM;
    NSDate*                 startDate;
    NSDate*                 endDate;
    int                     index;
    NSMutableArray*         arrayM;
    int                     i;
    int                     everyTimeLineDays;
    CGFloat                 y;
    CGFloat                 x;
    NSTimeInterval          timeInterval;
    int                     count;
    BOOL                    leftResult;
    BOOL                    rightResult;
    XLTimeLineChartCell*    timeLineCell;
    
    [super setDataSource:dataSource];
    if (dataSource.count <= 0) return;
    timeLineMs = dataSource[0];
    //每个时间轴的天数
    everyTimeLineDays = (int)timeLineMs.days / _timeLineCount;
    _yAxisHeight = (everyTimeLineDays + 1) * _cellHeight;
    for (index = 0; index < _timeLineCount; index++) {
        if (index == 0) {
            //假定第一个元素为最小日期
            timeLineM = (XLTimeLineM*)timeLineMs.timeLineMs[0];
            startDate = timeLineM.date;
            [self.startDatesM addObject:startDate];
            continue;
        }
        // 20 天后的时间
        startDate = [startDate dateByAddingTimeInterval:24 * 60 * 60 * everyTimeLineDays];
        [self.startDatesM addObject:startDate];
    }
    arrayM = [NSMutableArray array];
    i = 0;
    // 如果只有一个时间轴居中显示
    if (_timeLineCount == 1) x = kScreenWidth/2 - _cellWidth/2;
    else x = self.leftMargin;
    for (index = 0; index < timeLineMs.timeLineMs.count; index++) {
        startDate = self.startDatesM[i];
        timeLineM = timeLineMs.timeLineMs[index];
        endDate = [startDate dateByAddingTimeInterval:24 * 60 * 60 * everyTimeLineDays];
        leftResult = [timeLineM.date compare:startDate] == NSOrderedSame || [timeLineM.date compare:startDate] == NSOrderedDescending;
        rightResult = [timeLineM.date compare:endDate] == NSOrderedAscending;
        if (leftResult && rightResult) {
            timeInterval = [timeLineM.date timeIntervalSinceDate:startDate];
            count = timeInterval / (24 * 60 * 60);
            y = count * _cellHeight + _headerViewHeight;
            timeLineM.rect = CGRectMake(x, y, _cellWidth, _cellHeight);
         
             [arrayM addObject:timeLineM];
        }else{
            
            [self.segmentTimeLineMs addObject:arrayM];
            arrayM = [NSMutableArray array];
            [arrayM addObject:timeLineM];
            y = _headerViewHeight;
            x += _cellWidth;
            timeLineM.rect = CGRectMake(x,y, _cellWidth, _cellHeight);
            i++;
            if (i == _timeLineCount) break;
        }
    }
    [self.segmentTimeLineMs addObject:arrayM];
    /// 看的见得每根cell的个数
    _timeLineCellCount = (kScreenHeight - _headerViewHeight) / _cellHeight;
    if(_timeLineCellCount >= everyTimeLineDays) _timeLineCellCount = everyTimeLineDays;
    int yIndex = 0;
    for (index = 0; index < _timeLineCellCount; index++)
    {
        timeLineM = [self.segmentTimeLineMs[yIndex] objectAtIndex:index];
        timeLineCell = [[XLTimeLineChartCell alloc]initWithFrame:timeLineM.rect];
        timeLineCell.timeLineM = timeLineM;
        timeLineCell.cellHeight = _cellHeight;
        [self addSubview:timeLineCell];
        [self.timeLineChartCells addObject:timeLineCell];
        if (index == (_timeLineCellCount - 1) && yIndex < (_timeLineCount - 1))
        {
            index = -1;
            yIndex++;
        }
    }
     self.contentSize = CGSizeMake(_cellWidth * _timeLineCount, everyTimeLineDays * _cellHeight + _headerViewHeight + self.bottomMargin);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self changeTimeLineDataScroll:scrollView];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self changeTimeLineDataScroll:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self changeTimeLineDataScroll:scrollView];
    
}
-(void)changeTimeLineDataScroll:(UIScrollView*)scrollView
{
    
    NSInteger               index;
    XLTimeLineM*            timeLineM;
    NSUInteger              startIndex = 0;
    NSUInteger              beginIndex = 0;
    CGPoint                 offset;
    XLTimeLineChartCell*    timeLineCell;
    NSUInteger              yIndex;
    NSUInteger              everyTimeLineMaxCount;
    
    offset = [scrollView contentOffset];
    for (index = 0; index < [self.segmentTimeLineMs[0] count]; index++) {
        timeLineM = [self.segmentTimeLineMs[0] objectAtIndex:index];
        if (timeLineM.rect.origin.y >= offset.y) {
            startIndex = index;
            break;
        }
    }
    yIndex = 0;
    beginIndex = startIndex;
    for (index = 0; index < _timeLineChartCells.count; index++) {
        timeLineCell = _timeLineChartCells[index];
        /// 每跟时间线最大索引
        everyTimeLineMaxCount = [self.segmentTimeLineMs[yIndex] count];
        timeLineM = [self.segmentTimeLineMs[yIndex] objectAtIndex:beginIndex];
        timeLineCell.timeLineM = timeLineM;
        timeLineCell.frame = timeLineM.rect;
        [timeLineCell setNeedsDisplay];
        beginIndex++;
        /// 开始索引等于每根时间线数组数据的最大值，或者界面上每根时间线容纳XLTimeLineChartCell的最大值,同时 索引不能大于时间线轴的个数
        if ((beginIndex == everyTimeLineMaxCount || (beginIndex - startIndex) == _timeLineCellCount) && yIndex < (_timeLineCount - 1)) {
            beginIndex = startIndex;
            yIndex++;
        }
        if ((beginIndex == everyTimeLineMaxCount || (beginIndex - startIndex) == _timeLineCellCount) && yIndex == (_timeLineCount - 1)) break;
    }
}

@end



































