//
//  XLQuadrantModel.h
//  XLGraphicEngine
//
//  Created by JuniorKey on 16/9/1.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLQuadrantRectangleM.h"
@interface XLQuadrantM : XLBaseM

/**  代表的名字*/
@property (nonatomic,copy) NSString* name;
/**  y轴方向的数据*/
@property (nonatomic,assign) CGFloat yAxisData;
/**  x轴方向的数据*/
@property (nonatomic,assign) CGFloat xAxisData;
/**  商品的趋势 1向上缓慢,2向上正常,3向上快速,4向下缓慢,5向下正常,6向下快速*/
@property (nonatomic,assign) NSInteger trend;
/**  指向象限矩形*/
@property (nonatomic,retain) XLQuadrantRectangleM* rectM;

@end

@interface XLQuadrantMS : XLBaseAxisM
/** 存放XLQuadrantM对象的数组*/
@property (nonatomic,strong) NSMutableArray* quadrantMs;
@end
