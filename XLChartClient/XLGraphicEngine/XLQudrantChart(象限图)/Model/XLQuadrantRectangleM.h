//
//  XLQuadrantRectangleM.h
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/7/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "XLBaseM.h"
/**  想象矩形模型*/
@interface XLQuadrantRectangleM : XLBaseAxisM
/**  矩形模型的中心点*/
@property (nonatomic,assign) CGPoint centerPoint;
/**  矩形模型的rect*/
@property (nonatomic,assign) CGRect rect;
/**  位于这个矩形范围内点个数*/
@property (nonatomic,assign) NSInteger count;
/**  是否被选中*/
@property (nonatomic,assign) BOOL selected;
@end
