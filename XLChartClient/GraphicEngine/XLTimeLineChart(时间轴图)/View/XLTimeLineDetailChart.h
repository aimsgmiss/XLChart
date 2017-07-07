//
//  XLTimeLineChart.h
//  ICoo
//
//  Created by JuniorKey on 9/23/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLBaseChart.h"

@interface XLTimeLineDetailChart : XLBaseChart
/**  单元格的宽度*/
@property (nonatomic,assign) CGFloat cellWidth;
/**  单元格的高度*/
@property (nonatomic,assign) CGFloat cellHeight;
/**  时间轴的的个数*/
@property (nonatomic,assign) NSInteger timeLineCount;
@end
