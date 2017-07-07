//
//  XLTableChartDetail.m
//  ICoo
//
//  Created by JuniorKey on 10/9/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLTableChartCell.h"
#import "XLTableCellM.h"
#import "XLTableChartDetail.h"

@interface XLTableChartDetail()
{
    /// x轴标题的个数
    CGFloat         _xTitleCount;
    /// y轴标题的个数
    CGFloat         _rowCount;
    /// 表格的宽度
    CGFloat         _width;
    /// 表格cell的y位置
    CGFloat         _cellY;
    /// 表格的默认高度
    CGFloat         _cellHeight;
}
/**存放tableChartCell表格的*/
@property (nonatomic,strong) NSMutableArray* tableChartCells;

//@property (nonatomic,strong) MBProgressHUD* hud;
@end


@implementation XLTableChartDetail
XLAddMethodImTemplate(tableChartCells)

-(instancetype)initWithFrame:(CGRect)frame zoomType:(ChartZoomType)zoomType
{
    self = [super initWithFrame:frame zoomType:zoomType];
    self.delegate = self;
    self.rightMargin = 0;
    self.topMargin = 0;
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        self.leftMargin = 0;
    }else if(IS_IPHONE_6 || IS_IPHONE_6_PLUS)
    {
        self.leftMargin = 0;
    }
    _cellHeight = 20;
    _tableCellWidths = [NSMutableArray array];
    _tableCellHeights = [NSMutableArray array];
    _width = 0;
    self.userInteractionEnabled = YES;
    return  self;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
}
-(void)setDataSource:(NSMutableArray *)dataSource
{
    __block NSUInteger  index;
    __block XLTableCellM* tableCellM;
    NSInteger           tableCellCount;
    CGFloat             maxCellHeight;
    XLTableChartCell*   tableChartCell;
    
    _cellY = self.topMargin;
    [super setDataSource:dataSource];
    if ([dataSource count] <= 0) return;
    _rowCount = [dataSource count];
    tableCellCount = self.height / _cellHeight;
    if (_rowCount <= tableCellCount) {
        for (index = 0; index < _rowCount; index++) {
            tableCellM = self.dataSource[index];
            [self dealTableCellM:tableCellM index:index];
        }
    } else {
        /// 先处理前面的数据
        for (index = 0; index < tableCellCount; index++) {
            tableCellM = dataSource[index];
            [self dealTableCellM:tableCellM index:index];
        }
        /// 后面的数据放在后台线程处理
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSUInteger  idx;
            TICK
            for (idx = tableCellCount; idx < _rowCount; idx++) {
                tableCellM = self.dataSource[idx];
                [self dealTableCellM:tableCellM index:idx];
            }
          // _hud.hidden = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.contentSize = CGSizeMake(self.leftMargin + _width + self.rightMargin,_cellY + 20);
                [self changeTableCellDataScroll:self];
                [self setNeedsDisplay];
            });
            TOCK
        });
    }
    self.contentSize = CGSizeMake(self.leftMargin + _width + self.rightMargin,_cellY);
    if (tableCellCount < _rowCount) tableCellCount = tableCellCount;
    else tableCellCount = _rowCount;
    [self.tableChartCells removeAllObjects];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //初始化第一次看到界面的数据
    for (index = 0; index < tableCellCount; index++) {
        @autoreleasepool {
            maxCellHeight = [[_tableCellHeights objectAtIndex:index] floatValue];
            tableChartCell = [[XLTableChartCell alloc]initWithFrame:CGRectMake(0, index * maxCellHeight, _width,maxCellHeight) zoomType:_zoomType];
            tableChartCell.tableCellM = [self.dataSource objectAtIndex:index];
            tableChartCell.xTitleCount = _xTitleCount;
            tableChartCell.tableCellWidths = _tableCellWidths;
            tableChartCell.cellHeight = maxCellHeight;
            [self addSubview:tableChartCell];
            [self.tableChartCells addObject:tableChartCell];
        }
    }
    
}

-(void)dealTableCellM:(XLTableCellM* )tableCellM index:(NSUInteger)idx{
    
    XLTableChartCell*   tableChartCell;
    NSUInteger          index;
    NSString*           text;
    CGSize              textSize;
    CGFloat             x;
    CGFloat             maxCellHeight;
    CGFloat             cellWidth;
    NSInteger           tableCellCount;
    NSNumber*           number;
    CGFloat             width;
    CGFloat             maxWidth;
    NSUInteger          cellRowCount;
    NSUInteger          maxCellRowCount;
    id                  obj;
    NSString*           indexStr;
    
    @synchronized (self) {
        x = self.leftMargin;
        maxCellHeight = _cellHeight;
        maxWidth = 0;
        indexStr = [NSString stringWithFormat:@"%@%ld",kTableChartPreIndexStr,idx];
        if (![tableCellM.items[0] hasPrefix:kTableChartPreIndexStr]) [tableCellM.items insertObject: indexStr atIndex:0];
        maxCellRowCount = 1;
        _xTitleCount = tableCellM.items.count;
        cellWidth = (self.width - self.leftMargin - self.rightMargin) / _xTitleCount;
        if (idx == 0) {
            [_tableCellWidths removeAllObjects];
            for (index = 0; index < _xTitleCount; index++) {
                number = [NSNumber numberWithFloat:cellWidth];
                [_tableCellWidths addObject:number];
            }
        }
        for (index = 0; index < _xTitleCount; index++) {
            obj = [tableCellM.items objectAtIndex:index];
            if ([obj isKindOfClass:[NSArray class]]) {
                cellRowCount = 0;
                for (text in obj) {
                    cellRowCount++;
                    textSize = [text sizeWithAttributes:self.fontAttr];
                    if (textSize.width > maxWidth) maxWidth = textSize.width;
                }
                if (cellRowCount > maxCellRowCount) maxCellRowCount = cellRowCount;
                
            } else if([obj isKindOfClass:[NSString class]]){
                text = [tableCellM.items objectAtIndex:index];
                maxWidth = [text sizeWithAttributes:self.fontAttr].width;
            }
            cellWidth = ((NSNumber*)_tableCellWidths[index]).floatValue;
            //计算项中的最大宽度为每个小cell的宽度
            if (cellWidth < maxWidth)
            {
                number = [NSNumber numberWithFloat:maxWidth];
                [_tableCellWidths replaceObjectAtIndex:index withObject:number];
            }
        }
        
        maxCellHeight = _cellHeight * maxCellRowCount;
        number = [NSNumber numberWithUnsignedInteger:maxCellHeight];
        [_tableCellHeights addObject:number];
        //计算所有单元格对象的rectangle
        _width = 0;
        for (index = 0; index < _xTitleCount; index++) _width += ((NSNumber*)_tableCellWidths[index]).floatValue;
        if (_width > maxWidth) maxWidth = _width;
        if (idx % 2 == 0)tableCellM.bkColor = kBeryBlueColor;
        else tableCellM.bkColor = kWhiteColor;
        tableCellM.rect = CGRectMake(x, _cellY, _width, maxCellHeight);
        _cellY += maxCellHeight;
    }
    
}

-(void)backgroundThreadDealTableCellM:(XLTableCellM* )tableCellM{
    
    
}

-(void)tapGestureRecogizer:(UITapGestureRecognizer*)tapGesture
{
 
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self changeTableCellDataScroll:scrollView];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self changeTableCellDataScroll:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self changeTableCellDataScroll:scrollView];
    
}
-(void)changeTableCellDataScroll:(UIScrollView*)scrollView
{
    NSInteger           index;
    XLTableCellM*       tableCellM;
    NSInteger           startIndex = 0;
    CGPoint             offset;
    XLTableChartCell*   tableChartCell;
    
    offset = [scrollView contentOffset];
    if (_tableChartHeader) {
        _tableChartHeader.contentOffset = CGPointMake(scrollView.contentOffset.x, _tableChartHeader.contentOffset.y);
        [_tableChartHeader setNeedsDisplay];
    }
   
    for (index = 0; index < self.dataSource.count; index++) {
        tableCellM = self.dataSource[index];
        if (tableCellM.rect.origin.y + tableCellM.rect.size.height >= offset.y) {
            startIndex = index;
            break;
        }
    }
    for (index = 0; index < _tableChartCells.count; index++) {
        tableChartCell = _tableChartCells[index];
        tableChartCell.tableCellM = self.dataSource[startIndex];
        tableChartCell.frame = CGRectMake(tableChartCell.frame.origin.x, startIndex * tableChartCell.height, tableChartCell.width, tableChartCell.height);
        startIndex++;
        [tableChartCell setNeedsDisplay];
        if(startIndex >= self.dataSource.count) break;
    }
}

#pragma mark XLTableChartHeaderDelegate
-(void)didSelectedTableChartHeaderIndex:(NSUInteger)clickIndex asending:(BOOL)asending{
    __block XLTableCellM*   tableCellM1;
    __block XLTableCellM*   tableCellM2;
    __block NSString*       indexStr1;
    __block NSString*       indexStr2;
    
    /*for(int index = 0; index < self.dataSource.count;index++){
        NSLog(@"didSelectedTableChartHeaderIndex before:%@",((XLTableCellM*)(self.dataSource[index])).items[0]);
    }*/
    if (self.dataSource.count > 0) {
        [self.dataSource sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            tableCellM1 = (XLTableCellM*)obj1;
            tableCellM2 = (XLTableCellM*)obj2;
           
            if (clickIndex == 0) {
                indexStr1 = [(NSString*)(tableCellM1.items[0]) substringFromIndex:[kTableChartPreIndexStr length]];
                indexStr2 = [(NSString*)(tableCellM2.items[0]) substringFromIndex:[kTableChartPreIndexStr length]];
                if (asending) return [[NSNumber numberWithFloat:[indexStr1 floatValue]] compare:[NSNumber numberWithFloat:[indexStr2 floatValue]]];
                else return [[NSNumber numberWithFloat:[indexStr2 floatValue]] compare:[NSNumber numberWithFloat:[indexStr1 floatValue]]];
            } else {
                if ([tableCellM1.items[clickIndex] isKindOfClass:[NSArray class]]) return NSOrderedSame;
                if (asending) return [tableCellM1.items[clickIndex] compare:tableCellM2.items[clickIndex]];
                else return [tableCellM2.items[clickIndex] compare:tableCellM1.items[clickIndex]];
            }
        }];
    }
    self.dataSource = self.dataSource;
    
}

#pragma mark didSelectedTableChartFooterBtnType

-(void)didSelectedTableChartFooterBtnType:(TableChartFooterBtnType)btnType{
    
   
}

-(void)dealloc{
    
 
 
}
@end
