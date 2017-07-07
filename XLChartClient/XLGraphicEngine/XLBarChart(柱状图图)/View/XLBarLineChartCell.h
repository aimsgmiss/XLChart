//
//  XLBarChartCell.h
//  ICoo
//
//  Created by JuniorKey on 9/30/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//
#import "XLBarLineChartM.h"
#import "XLBaseChart.h"

@interface XLBarLineChartCell : XLBaseAxisChart

/**  数据源*/
@property (nonatomic,strong) XLBarLineChartM* barChartM;
/**  cell的高度(纵向)*/
@property (nonatomic,assign) CGFloat cellHeight;
/**  cell的宽度(横向)*/
@property (nonatomic,assign) CGFloat cellWidth;
/** 一个cell有多少个bar*/
@property (nonatomic,assign) NSInteger barCount;
/** x轴线在y轴中点 将y轴分为上半轴，下半轴*/
@property (nonatomic,assign) BOOL xAxisInYAxisMiddle;
@end
