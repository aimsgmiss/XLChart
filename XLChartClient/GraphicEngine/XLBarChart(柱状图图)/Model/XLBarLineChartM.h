//
//  XLBarChartM.h
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/13/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLBaseChart.h"
#import "XLBaseM.h"
@interface XLBarLineChartM :XLBaseAxisM

/**  名称*/
@property (nonatomic,copy) NSString* name;
/**  第一个数字*/
@property (nonatomic,copy) NSString* number;
/**  第一个矩形范围*/
@property (nonatomic,assign) CGRect rect;

/**  第二个个数字*/
@property (nonatomic,copy) NSString* number2;
/**  第二个矩形范围*/
@property (nonatomic,assign) CGRect rect2;

/**  第三个数字*/
@property (nonatomic,copy) NSString* number3;
/**  第三个矩形范围*/
@property (nonatomic,assign) CGRect rect3;
/**  滚动x值，该下bar一个显示（用于滚动的时候，横向向滚动）*/
@property (nonatomic,assign) CGFloat scrollX;
/** 一个cell的宽度*/
@property (nonatomic,assign) CGFloat cellWidth;
/**  滚动y值，该下bar一个显示（用于滚动的时候，纵向滚动）*/
@property (nonatomic,assign) CGFloat scrollY;
/** 一个cell的高度*/
@property (nonatomic,assign) CGFloat cellHeight;
/**  针对附加数字*/
@property (nonatomic,copy) NSString* backgoundNumber;
/**  针对附加矩形范围*/
@property (nonatomic,assign) CGRect backgroundRect;


///针对线性图
/** 线性图的点*/
@property (nonatomic,copy) NSString* lineNumber;
/** 前一个XLBarChartM模型*/
@property (nonatomic,weak) XLBarLineChartM* preBarCharLineM;
/** 后一个XLBarChartM模型 */
@property (nonatomic,weak) XLBarLineChartM* suffixBarCharLineM;
/** celll中点 以lineNumber为基层*/
@property (nonatomic,assign) CGPoint  middlePoint;
/** celll前一个点数字*/
@property (nonatomic,assign) CGPoint  prePoint;
/** celll后一个点数字*/
@property (nonatomic,assign) CGPoint  suffixPoint;
//用于
@end

@interface XLBarLineChartMs : XLBaseAxisM
/**  存放XLBarChartM数据模型的数组*/
@property (nonatomic,strong) NSMutableArray* barChartMs;
/** 类型(柱状图方向 0：向上，1：向右)*/
@property (nonatomic,copy) NSString* type;
/**  标题名字*/
@property (nonatomic,copy) NSString* title;

@end
