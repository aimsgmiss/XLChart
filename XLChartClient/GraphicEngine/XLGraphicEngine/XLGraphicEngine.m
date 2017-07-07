//
//  XLGraphicEngine.m
//  XLGraphicEngine
//
//  Created by JuniorKey on 16/8/29.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//

#import "XLGraphicEngine.h"

@interface XLGraphicEngine()

@end

@implementation XLGraphicEngine

-(BOOL)isPointValid:(CGPoint)point
{
    return (point.x < 0 || point.y < 0) ? false : true;
}

-(void)mDrawLineStartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint strokeColor:(CGCOLOR)strokeColor
{
    LineProperty    lineProperty;
    
    lineProperty = [self defaultLineProperty];
    lineProperty.stroColor = strokeColor;
    [self mDrawLineStartPoint:startPoint EndPoint:endPoint LineProperty:&lineProperty];

}
-(void)mDrawLineStartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint LineProperty:(PLineProperty)pPropery
{
    if(!_ctx || ![self isPointValid:startPoint] || ![self isPointValid:endPoint]) return;
     CGContextSaveGState(_ctx);
    [self mAddLineStartPoint:startPoint EndPoint:endPoint LineProperty:pPropery];
    CGContextDrawPath(_ctx, kCGPathStroke);
    CGContextRestoreGState(_ctx);
}

-(void)mAddLineStartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint LineProperty:(PLineProperty)pPropery
{
    LineProperty    lineProperty;
    
    if(!_ctx || ![self isPointValid:startPoint] || ![self isPointValid:endPoint]) return;
    if(!pPropery)
    {
        lineProperty = [self defaultLineProperty];
        pPropery = &lineProperty;
    }
    CGContextSetLineCap(_ctx, pPropery->lineCap);
    CGContextSetLineWidth(_ctx, pPropery->lineWidth);
    CGContextSetLineJoin(_ctx, pPropery->lineJoin);
    CGContextSetRGBStrokeColor(_ctx, kConvertColor(pPropery->stroColor.r), kConvertColor(pPropery->stroColor.g),kConvertColor(pPropery->stroColor.b), kConvertColor(pPropery->stroColor.a));
    if(pPropery->dashs)CGContextSetLineDash(_ctx, 0, pPropery->dashs, pPropery->count);
    CGContextMoveToPoint(_ctx, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(_ctx, endPoint.x, endPoint.y);

}

-(void)mDrawDecimalText:(NSString* )text Point:(CGPoint)point textAttr:(NSDictionary*)textAttr{
    
    NSNumber*           number;
    CGFloat             floatValue;
    
    if ([text length] > 0) {
        floatValue = [text floatValue];
        number = [NSNumber numberWithFloat:floatValue];
        text = [CRoutines stringFromFormatterStyle:NSNumberFormatterDecimalStyle number:number];
        point = CGPointMake(point.x, point.y);
        [self mDrawText:text Point:point textAttr:textAttr];
    }
}

-(void)mDrawText:(NSString *)text Point:(CGPoint)point textAttr:(NSDictionary*)textAttr
{
    NSDictionary*       attrs;
    
    if(![self isPointValid:point]) return;
    if(!textAttr)attrs = kSystemFontSize9BlackColor;
    else attrs = textAttr;
    [text drawAtPoint:point withAttributes:attrs];
}

-(CGSize)mCalcuateTextSizeText:(NSString*)text textAttr:(NSDictionary*)textAttr
{
    NSDictionary*       attrs;
    
    if ([text length] <= 0) return CGSizeZero;
    if (!textAttr) attrs = kSystemFontSize9WhiteColor;
    else attrs = textAttr;
    return [text sizeWithAttributes:attrs];
}

+(CGSize)mCalcuateTextSizeText:(NSString*)text textAttr:(NSDictionary*)textAttr
{
    NSDictionary*       attrs;
    
    if ([text length] <= 0) return CGSizeZero;
    if (!textAttr) attrs = kSystemFontSize9WhiteColor;
    else attrs = textAttr;
    return [text sizeWithAttributes:attrs];
}

-(void)mDrawCirclePoint:(CGPoint)point circleAttrs:(PCircleAttr)pCircAttr
{
    CircleAttr          circAttr;
    
    if(!_ctx || ![self isPointValid:point]) return;
    //CGContextSaveGState(_ctx);
    if (!pCircAttr)
    {
        circAttr = [self defaultCircleAttr];
        pCircAttr = &circAttr;
    }
    CGContextAddArc(_ctx, point.x, point.y, pCircAttr->radius, -M_PI*2, M_PI*2, 0);
    CGContextSetRGBFillColor(_ctx, kConvertColor(pCircAttr->fillColor.r),  kConvertColor(pCircAttr->fillColor.g),  kConvertColor(pCircAttr->fillColor.b),kConvertColor(pCircAttr->fillColor.a));
    CGContextSetRGBStrokeColor(_ctx, kConvertColor(pCircAttr->strokColor.r),  kConvertColor(pCircAttr->strokColor.g),  kConvertColor(pCircAttr->strokColor.b),kConvertColor(pCircAttr->strokColor.a));
    if (pCircAttr->circleType == 0) CGContextDrawPath(_ctx, kCGPathFillStroke);
    else CGContextDrawPath(_ctx, kCGPathStroke);
    //CGContextRestoreGState(_ctx);
}

-(void)mDrawArrowStartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint arrowAttr:(PArrowAttr)pArrowAttr
{
    int                 radius;
    ArrowAttr           defaultAttr;
    
    if(!_ctx || ![self isPointValid:startPoint] || ![self isPointValid:endPoint]) return;
    CGContextSaveGState(_ctx);
    if(!pArrowAttr)
    {
        defaultAttr = [self defaultArrowAttr];
        pArrowAttr = &defaultAttr;
    }
    CGContextSetLineCap(_ctx, pArrowAttr->arrowCap);
    CGContextSetLineWidth(_ctx, pArrowAttr->lineWidth);
    CGContextSetLineJoin(_ctx, pArrowAttr->arrowJoin);
    CGContextSetRGBStrokeColor(_ctx, kConvertColor(pArrowAttr->strokColor.r), kConvertColor(pArrowAttr->strokColor.g), kConvertColor(pArrowAttr->strokColor.b),kConvertColor(pArrowAttr->strokColor.a));
    CGContextSetRGBFillColor(_ctx, kConvertColor(pArrowAttr->strokColor.r), kConvertColor(pArrowAttr->strokColor.g), kConvertColor(pArrowAttr->strokColor.b),kConvertColor(pArrowAttr->strokColor.a));
    CGContextMoveToPoint(_ctx, startPoint.x, startPoint.y);
   
    radius = pArrowAttr->radius;
    switch (pArrowAttr->arrowDirection)
    {
        case arrowDirection_up:
            CGContextAddLineToPoint(_ctx, endPoint.x, endPoint.y + radius);
            CGContextAddLineToPoint(_ctx, endPoint.x - radius, endPoint.y + radius);
            CGContextAddLineToPoint(_ctx, endPoint.x , endPoint.y);
            CGContextAddLineToPoint(_ctx, endPoint.x + radius, endPoint.y + radius);
            CGContextAddLineToPoint(_ctx, endPoint.x , endPoint.y + radius);
            break;
        case arrowDirection_down:
            CGContextAddLineToPoint(_ctx, endPoint.x, endPoint.y - radius);
            CGContextAddLineToPoint(_ctx, endPoint.x + radius, endPoint.y - radius);
            CGContextAddLineToPoint(_ctx, endPoint.x , endPoint.y);
            CGContextAddLineToPoint(_ctx, endPoint.x - radius, endPoint.y - radius);
            CGContextAddLineToPoint(_ctx, endPoint.x , endPoint.y - radius);
            break;
        case arrowDirection_left:
            CGContextAddLineToPoint(_ctx, endPoint.x + radius, endPoint.y);
            CGContextAddLineToPoint(_ctx, endPoint.x + radius, endPoint.y + radius);
            CGContextAddLineToPoint(_ctx, endPoint.x , endPoint.y);
            CGContextAddLineToPoint(_ctx, endPoint.x + radius, endPoint.y - radius);
            CGContextAddLineToPoint(_ctx, endPoint.x + radius, endPoint.y);
            break;
        case arrowDirection_right:
            CGContextAddLineToPoint(_ctx, endPoint.x - radius, endPoint.y);
            CGContextAddLineToPoint(_ctx, endPoint.x - radius, endPoint.y - radius);
            CGContextAddLineToPoint(_ctx, endPoint.x + radius, endPoint.y);
            CGContextAddLineToPoint(_ctx, endPoint.x - radius, endPoint.y + radius);
            CGContextAddLineToPoint(_ctx, endPoint.x - radius, endPoint.y);
            break;
        default:
            break;
    }
    CGContextDrawPath(_ctx, kCGPathFillStroke);
    CGContextRestoreGState(_ctx);
}

-(void)mDrawRectangle:(CGRect)rect RectangleAttr:(PRectangleAttr)pRectaAttr
{
    RectangleAttr   rectaAttr;
    
    if(!_ctx) return;
    if (!pRectaAttr)
    {
        //默认属性
        rectaAttr.bkColor = (CGCOLOR){0,0,0,255};
        rectaAttr.lineWidth = 1;
        rectaAttr.strokColor = (CGCOLOR){255,0,0,255};
        pRectaAttr = &rectaAttr;
    }
    CGContextSaveGState(_ctx);
    CGContextSetRGBStrokeColor(_ctx,kConvertColor(pRectaAttr->strokColor.r) , kConvertColor(pRectaAttr->strokColor.g), kConvertColor(pRectaAttr->strokColor.b), kConvertColor(pRectaAttr->strokColor.a));
    CGContextSetLineWidth(_ctx, pRectaAttr->lineWidth);
    CGContextAddRect(_ctx, rect);
    CGContextDrawPath(_ctx, kCGPathStroke);
    CGContextRestoreGState(_ctx);
  
}

-(void)mFillRectangle:(CGRect)rect RectangleAttr:(PRectangleAttr)pRectaAttr
{
    RectangleAttr   rectaAttr;
    
    if(!_ctx) return;
    if (!pRectaAttr)
    {
        //默认属性
        rectaAttr = [self defaultRectangleAttr];
        pRectaAttr = &rectaAttr;
    }
    CGContextSaveGState(_ctx);
    CGContextSetRGBFillColor(_ctx,kConvertColor(pRectaAttr->fillColor.r) , kConvertColor(pRectaAttr->fillColor.g), kConvertColor(pRectaAttr->fillColor.b), kConvertColor(pRectaAttr->fillColor.a));
    CGContextSetLineWidth(_ctx, pRectaAttr->lineWidth);
    CGContextAddRect(_ctx, rect);
    CGContextDrawPath(_ctx, kCGPathFill);
    CGContextRestoreGState(_ctx);
    
}

-(void)mFillTriangle:(CGPoint)fPoint secondPoint:(CGPoint)sPoint thirdPoint:(CGPoint)tPoint fillColor:(UIColor*)uFillColor
{
    CGCOLOR         fillColor;
    
    if (![self isPointValid:fPoint] || ![self isPointValid:sPoint] || ![self isPointValid:tPoint]) return;
    if (!uFillColor) return;
    CGContextSaveGState(_ctx);
    fillColor = [self UIColorConvertCGColor:uFillColor];
    CGContextSetRGBFillColor(_ctx,kConvertColor(fillColor.r) , kConvertColor(fillColor.g), kConvertColor(fillColor.b), kConvertColor(fillColor.a));
    CGContextMoveToPoint(_ctx, fPoint.x, fPoint.y);
    CGContextAddLineToPoint(_ctx, sPoint.x, sPoint.y);
    CGContextAddLineToPoint(_ctx, tPoint.x, tPoint.y);
    CGPDFContextClose(_ctx);
    CGContextDrawPath(_ctx, kCGPathFillStroke);
    CGContextRestoreGState(_ctx);
}

-(CGPathRef)mGetFillRectanglePath:(CGRect)rect RectangleAttr:(PRectangleAttr)pRectaAttr
{
    CGMutablePathRef           pathM;
    
    pathM = CGPathCreateMutable();
    CGPathAddRect(pathM, NULL, rect);
    return pathM;
}

-(void)mDrawRoundRectangle:(CGRect)rect RoundRectangleAttr:(PRoundRectangleAttr)pRoundRectaAttr
{
    
}

-(void)mFillRoundRectangle:(CGRect)rect RoundRectangleAttr:(PRoundRectangleAttr)pRoundRectaAttr fillColor:(UIColor*)uFillColor
{

    RoundRectangleAttr  roudRectAttr;
    CGPathRef           path;
    CGCOLOR             fillColor;
    
    if(!_ctx) return;
    CGContextSaveGState(_ctx);
    if (!pRoundRectaAttr)
    {
        //默认属性
        roudRectAttr = [self defaultRoundRectangleAttr];
        pRoundRectaAttr = &roudRectAttr;
    }
    if (uFillColor)
    {
        fillColor = [self UIColorConvertCGColor:uFillColor];
        CGContextSetRGBFillColor(_ctx,kConvertColor(fillColor.r) , kConvertColor(fillColor.g), kConvertColor(fillColor.b), kConvertColor(fillColor.a));
    }else CGContextSetRGBFillColor(_ctx,kConvertColor(pRoundRectaAttr->rectangleAttr.fillColor.r) , kConvertColor(pRoundRectaAttr->rectangleAttr.fillColor.g), kConvertColor(pRoundRectaAttr->rectangleAttr.fillColor.b), kConvertColor(pRoundRectaAttr->rectangleAttr.fillColor.a));
    CGContextSetLineWidth(_ctx, pRoundRectaAttr->rectangleAttr.lineWidth);
    path = CGPathCreateWithRoundedRect(rect, pRoundRectaAttr->radius, pRoundRectaAttr->radius, NULL);
    CGContextAddPath(_ctx, path);
    CGContextDrawPath(_ctx, kCGPathFill);
    CGContextRestoreGState(_ctx);
    CGPathRelease(path);
}


-(void)mDrawBuddle:(CGPoint)point text:(NSString*)text
{
    CGFloat         buddleWidth;
    CGFloat         buddleHeight;
    CGSize          textSize;
    
    if (!_ctx || ![self isPointValid:point]) return;
    CGContextSaveGState(_ctx);
    buddleWidth = 24;
    buddleHeight = 24;
    CGContextMoveToPoint(_ctx, point.x, point.y - 2);
    CGContextSetRGBFillColor(_ctx, 0, 0,1,1);
    CGContextAddCurveToPoint(_ctx, point.x - buddleWidth/2, point.y - buddleHeight/2, point.x - buddleWidth/2, point.y - buddleHeight*9/10, point.x, point.y  - buddleHeight);
      CGContextAddCurveToPoint(_ctx, point.x + buddleWidth/2, point.y - buddleHeight*9/10, point.x + buddleWidth/2, point.y - buddleHeight/2, point.x, point.y);
    CGContextDrawPath(_ctx, kCGPathFill);
    textSize = [self mCalcuateTextSizeText:text textAttr:kSystemFontSize9WhiteColor];
    [self mDrawText:text Point:CGPointMake(point.x - textSize.width/2
                                           , point.y - buddleHeight*3/4) textAttr:kSystemFontSize9WhiteColor];
    CGContextRestoreGState(_ctx);
}

-(NSMutableArray*)mGetInsidePointsCenter:(CGPoint)centerP Radius:(CGFloat)radius hitPoints:(NSArray*)points
{
    CGMutablePathRef           pathM;
    NSValue*                   pointValue;
    int                        index;
    CGPoint                    point;
    NSMutableArray*            insidePoints;
    
    if (points.count <= 0 || ![self isPointValid:centerP]) return nil;
    pathM = CGPathCreateMutable();
    if (!pathM) return nil;
    CGPathAddArc(pathM, NULL, centerP.x, centerP.y, radius, -M_PI*2, M_PI*2, 0);
    insidePoints = [NSMutableArray array];
    for (index = 0; index < points.count; index++)
    {
        pointValue = points[index];
        point = [pointValue CGPointValue];
        if (CGPathContainsPoint(pathM, NULL, point, false))[insidePoints addObject:pointValue];
    }
    CFRelease(pathM);
    return insidePoints;
}
#pragma mark 默认属性
-(LineProperty)defaultLineProperty
{
    LineProperty    property;
    
    property.lineCap = kCGLineCapRound;
    property.lineJoin = kCGLineJoinRound;
    property.lineWidth = 1;
    property.dashs = nil;
    property.count = 0;
    property.stroColor = (CGCOLOR){0,255,0,255};
    return  property;
}

-(ArrowAttr)defaultArrowAttr
{
    ArrowAttr        arrowAttr;
    
    arrowAttr.lineWidth = 1;
    arrowAttr.arrowCap = kCGLineCapRound;
    arrowAttr.arrowJoin = kCGLineJoinRound;
    arrowAttr.strokColor = (CGCOLOR){255,0,0,255};
    arrowAttr.radius = 3;
    arrowAttr.arrowDirection = arrowDirection_up ;
    return arrowAttr;
}

-(CircleAttr)defaultCircleAttr
{
    CircleAttr  attr;
    
    attr.radius = 3;
    attr.circleType = 0;
    attr.fillColor = (CGCOLOR){0,255,0,255};
    return attr;
}

-(RectangleAttr)defaultRectangleAttr
{
    RectangleAttr   rectaAttr;
    
    rectaAttr.fillColor = (CGCOLOR){255,0,0,255};
    rectaAttr.lineWidth = 1;
    return rectaAttr;
}

-(RoundRectangleAttr)defaultRoundRectangleAttr
{
    RoundRectangleAttr   roundRectAttr;
    
    roundRectAttr.rectangleAttr = [self defaultRectangleAttr];
    roundRectAttr.radius = 3;

    return roundRectAttr;
}

-(CGCOLOR)UIColorConvertCGColor:(UIColor*)color
{
    CGFloat         red;
    CGFloat         green;
    CGFloat         blue;
    CGFloat         alpha;
    
    if (!color) return (CGCOLOR){255,0,0,255};
    if ([color getRed:&red green:&green blue:&blue alpha:&alpha]) return(CGCOLOR){red * 255, green * 255 , blue * 255 , alpha * 255};
    return (CGCOLOR){255,0,0,255};
}
@end





