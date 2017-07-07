//
//  XLTableChartCell.h
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/19/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLBaseChart.h"
#import "XLTableCellM.h"

@interface XLTableChartCell : XLBaseChart
/**  存放每个cell的宽度数组(一行数据)*/
@property (nonatomic,retain) NSMutableArray* tableCellWidths;
/**  单元格*/
@property (nonatomic,strong) XLTableCellM* tableCellM;
/**  单元格的位置*/
@property (nonatomic,assign) CGRect rect;
/** 单元项的高度*/
@property (nonatomic,assign) CGFloat cellHeight;
/**  单元格的宽度*/
@property (nonatomic,assign) CGFloat width;
/**  单元格的高度*/
@property (nonatomic,assign) CGFloat height;
/**  背景颜色*/
@property (nonatomic,strong) UIColor* bkColor;
/**  选中背景颜色*/
@property (nonatomic,strong) UIColor* selectedBkColor;
/**  x轴标题的个数*/
@property (nonatomic,assign) CGFloat xTitleCount;


@end
