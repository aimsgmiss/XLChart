//
//  XLAxisChart.h
//  ICoo
//
//  Created by JuniorKey on 12/20/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLBaseChart.h"
#import "XLAxisM.h"

@interface XLAxisChart : XLBaseAxisChart
/** 轴线类型*/
@property (nonatomic,assign) AxisChart_Type axisType;
/** axis模型*/
@property (nonatomic,strong) XLAxisM* axisM;
/** 轴线刻度数据的最小值*/
@property (nonatomic,assign) CGFloat minAxisScaleValue;
/** 轴线刻度数据的最大值*/
@property (nonatomic,assign) CGFloat maxAxisScaleValue;
@end
