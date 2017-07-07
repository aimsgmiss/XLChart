//
//  XLTableChartDetail.h
//  ICoo
//
//  Created by JuniorKey on 10/9/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLBaseChart.h"
#import "XLTableChartHeader.h"
#import "XLTableChartFooter.h"

@interface XLTableChartDetail : XLBaseChart<XLTableChartHeaderDelegate,XLTableChartFooterDelegate>
/**  存放一行每个单元格的宽度*/
@property (nonatomic,strong)  NSMutableArray* tableCellWidths;
/**  存放一行每个单元格的高度*/
@property (nonatomic,strong)  NSMutableArray* tableCellHeights;
/**  指向header*/
@property (nonatomic,strong) XLTableChartHeader* tableChartHeader;
/**  指向页脚*/
@property (nonatomic,strong) XLTableChartFooter* tableChartFooter;
@end
