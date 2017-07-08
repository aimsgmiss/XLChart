//
//  XLTableChart.h
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/18/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLBaseChart.h"
#import "XLTableCellM.h"

@interface XLTableChart : XLBaseChart
{

}
/**  x轴方向的标题*/
@property (nonatomic,strong) NSArray* xTitle;
/**  y轴方向的标题*/
@property (nonatomic,strong) NSArray* yTitle;
/**  存放XLTableCellM数据类型的数组*/
//@property (nonatomic,strong) NSArray* tableCellMs;

@end
