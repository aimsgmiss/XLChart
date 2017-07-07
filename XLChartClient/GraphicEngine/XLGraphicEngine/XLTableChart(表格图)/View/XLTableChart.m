//
//  XLTableChart.m
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/18/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLTableChart.h"
#import "XLTableChartCell.h"
#import "XLTableChartDetail.h"
#import "XLTableChartHeader.h"
#import "XLTableChartFooter.h"

#define     kDeflateTableChartMaxRowCount           20
@interface XLTableChart()
{
    /// 表格试图的宽度
    CGFloat         _tableChartWidth;
    /// 表格试图高度
    CGFloat         _taleChartHeight;
    /// x轴标题的个数
    CGFloat         _xTitleCount;
    /// y轴标题的个数
    CGFloat         _yTitleCount;
    ///标题栏的高度
    CGFloat         _headerHeight;
    ///页脚的高度
    CGFloat         _footerHeight;
}
/**存放tableChartCell表格的*/
@property (nonatomic,strong) NSMutableArray* tableChartCells;
/**XLTableChartDetail详细数据*/
@property (nonatomic,strong) XLTableChartDetail* tableChartDetail;
/**XLTableChartDetail标题头试图*/
@property (nonatomic,strong) XLTableChartHeader* tableChartHeader;
/**XLTableChartDetail标题头试图*/
@property (nonatomic,strong) XLTableChartHeader* tableChartHeaderCopy;
/**XLTableChartDetail页脚试图*/
@property (nonatomic,strong) XLTableChartFooter* tableChartFooter;

@end

@implementation XLTableChart
XLAddMethodImTemplate(tableChartCells)

-(instancetype)initWithFrame:(CGRect)frame zoomType:(ChartZoomType)zoomType
{
    if (IS_IPHONE_4 || IS_IPHONE_5) {
         _headerHeight = 25;
        self.leftMargin = 2;
    }else if(IS_IPHONE_6 || IS_IPHONE_6_PLUS){
        self.leftMargin = 0;
         _headerHeight = 30;
         _footerHeight = _headerHeight;
    }
    self = [super initWithFrame:frame zoomType:zoomType];
    self.delegate = self;
    self.rightMargin = 0;
    self.topMargin = 0;
    return  self;
}


-(void)setDataSource:(NSMutableArray *)dataSource
{
    NSInteger           index;
    NSInteger           count;
    id                  obj;
    NSDictionary*       dic;
    NSMutableArray*     arrayM;
    CGRect              rect;
    XLTableCellMs*      tableCellMs;
    NSMutableArray*     deflateArrayM;
    
    count = [dataSource count];
    if (count <= 0) return;
    [super setDataSource:dataSource];
    tableCellMs = dataSource[0];
    arrayM = tableCellMs.tableCellMs;
    
    // body
    if (arrayM) {
        rect = CGRectMake(self.leftMargin, self.top, self.width, self.height -  _headerHeight - _footerHeight);
        _tableChartDetail = [[XLTableChartDetail alloc]initWithFrame:rect zoomType:_zoomType];
        [self addSubview:_tableChartDetail];
        if (_zoomType == ChartZoomTypeDeflate) { //针对缩略图 只计算小部分数据即可
            if (arrayM.count > kDeflateTableChartMaxRowCount) {
                deflateArrayM = [NSMutableArray arrayWithCapacity:kDeflateTableChartMaxRowCount];
                for (index = 0; index < kDeflateTableChartMaxRowCount; index++) {
                    [deflateArrayM addObject:arrayM[index]];
                }
                _tableChartDetail.dataSource = deflateArrayM;
            } else _tableChartDetail.dataSource = arrayM;
           
        } else _tableChartDetail.dataSource = arrayM;
    }
    
    // header
    arrayM = tableCellMs.headers;
    if (arrayM) {
        if (![arrayM containsObject:@"序号"]) [arrayM insertObject:@"序号" atIndex:0];
        rect = CGRectMake(self.leftMargin, self.topMargin, self.tableChartDetail.contentSize.width, _headerHeight);
        _tableChartHeader = [[XLTableChartHeader alloc]initWithFrame:rect zoomType:_zoomType];
        _tableChartHeader.headerHeight = _headerHeight;
        _tableChartHeader.dataSource = arrayM;
        _tableChartHeader.tableCellWidths = _tableChartDetail.tableCellWidths;
        _tableChartDetail.frame = CGRectMake(self.leftMargin, self.topMargin + _headerHeight, self.width, self.height - _headerHeight - _footerHeight);
        [self addSubview:_tableChartHeader];
        _tableChartDetail.tableChartHeader = _tableChartHeader;
    }
     _tableChartHeader.tableChartHeaderDelegate = _tableChartDetail;
    
    // footer
    rect = CGRectMake(self.leftMargin, _tableChartDetail.bottom, self.tableChartDetail.contentSize.width, _footerHeight);
    _tableChartFooter = [[XLTableChartFooter alloc]initWithFrame:rect zoomType:_zoomType];
    _tableChartDetail.tableChartFooter = _tableChartFooter;
    [self addSubview:_tableChartFooter];
    _tableChartFooter.tableChartFooterDelegate = _tableChartDetail;

}

@end












