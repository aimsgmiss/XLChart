//
//  XLQuadrantArrowLabel.m
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/8/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLQuadrantArrowLabel.h"
#define  kSlowLen       10
#define  kFastLen       18
#define  kNormalLen     15
@implementation XLQuadrantArrowLabel

-(void)drawRect:(CGRect)rect
{
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointZero;
    CGFloat x;
    CGFloat y;
    x = rect.size.width/2;
    y = rect.size.height;
    /**  商品的趋势 1向上缓慢,2向上正常,3向上快速,4向下缓慢,5向下正常,6向下快速*/
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    __pGraphicEngine = [[XLGraphicEngine alloc]init];
    __pGraphicEngine.ctx = ctx;
    ArrowAttr arrowAttr = [__pGraphicEngine defaultArrowAttr];
    arrowAttr.lineWidth = 1;
    arrowAttr.radius = 2;
    arrowAttr.strokColor = (CGCOLOR){0,255,0,255};
    switch (self.trend) {
        case 1:
            arrowAttr.arrowDirection = arrowDirection_up;
            startPoint = CGPointMake(x, y);
            endPoint = CGPointMake(x, y - kSlowLen);
            break;
        case 2:
            arrowAttr.arrowDirection = arrowDirection_up;
            startPoint = CGPointMake(x, y);
            endPoint = CGPointMake(x, y - kNormalLen);
            break;
        case 3:
            arrowAttr.arrowDirection = arrowDirection_up;
            startPoint = CGPointMake(x, y);
            endPoint = CGPointMake(x, y - kFastLen);
            break;
        case 4:
            arrowAttr.arrowDirection = arrowDirection_down;
            startPoint = CGPointMake(x, y/2);
            endPoint = CGPointMake(x, kSlowLen + y/2);
            break;
        case 5:
             arrowAttr.arrowDirection = arrowDirection_down;
            startPoint = CGPointMake(x, y/2);
            endPoint = CGPointMake(x, kNormalLen + y/2);
            break;
        case 6:
             arrowAttr.arrowDirection = arrowDirection_down;
            startPoint = CGPointMake(x, y/2 - 2);
            endPoint = CGPointMake(x, kFastLen + y/2 - 2);
            break;
        default:
            break;
    }
    [__pGraphicEngine mDrawArrowStartPoint:startPoint EndPoint:endPoint arrowAttr:&arrowAttr];
    
}
@end
