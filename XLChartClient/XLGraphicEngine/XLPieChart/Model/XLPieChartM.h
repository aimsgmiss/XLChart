//
//  XLPieChartM.h
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/12/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//


#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import "XLBaseM.h"

@interface XLPieChartM : XLBaseM
/**  占有百分比的名称*/
@property (nonatomic,copy) NSString* name;
/**  占有百分比率*/
@property (nonatomic,assign) CGFloat percent;
/**  开始角度*/
@property (nonatomic,assign) CGFloat startAngle;
/**  开始角度与结束角度之间的弧度*/
@property (nonatomic,assign) CGFloat middleAngle;
/**  middleAngle弧度上的中心点位置坐标*/
@property (nonatomic,assign) CGPoint middlePoint;
/**  结束角度*/
@property (nonatomic,assign) CGFloat endAngle;
/**  填充颜色*/
@property (nonatomic,strong) UIColor* fillColor;
/**  表示这个对象画的圆弧是否被选中*/
@property (nonatomic,assign) BOOL selected;



@end
