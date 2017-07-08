//
//  XLTimeLineChatCell.h
//  ICoo
//
//  Created by JuniorKey on 9/23/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLBaseChart.h"
#import "XLTimeLineM.h"
@interface XLTimeLineChartCell : XLBaseChart

 /** 单元格的高度*/ 
@property (nonatomic,assign) CGFloat cellHeight;
/**  出入库一条数据对象*/
@property (nonatomic,strong) XLTimeLineM* timeLineM;
@end
