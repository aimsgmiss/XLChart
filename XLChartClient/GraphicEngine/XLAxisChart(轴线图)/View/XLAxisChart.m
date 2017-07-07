//
//  XLAxisChart.m
//  ICoo
//
//  Created by JuniorKey on 12/20/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLAxisChart.h"



@interface XLAxisChart()
/** 单位：万的size*/
@property (nonatomic,assign) CGSize  textUnit;
@end
@implementation XLAxisChart

-(CGSize)textUnit{
    return [@"单位:万" sizeWithAttributes:self.fontAttr];
}

-(instancetype)initWithFrame:(CGRect)frame zoomType:(ChartZoomType)zoomType{
    
    self = [super initWithFrame:frame zoomType:zoomType];
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    switch (_axisType) {
        case AxisChart_top:
            [self drawTopAxisData];
            break;
        case AxisChart_bottom:
            [self drawBottomAxisData];
            break;
        case AxisChart_left:
            [self drawLeftAxisData];
            break;
        case AxisChart_right:
            
            break;
        default:
            break;
    }
}

-(void)setXTopAxisScaleDatas:(NSMutableArray *)xTopAxisScaleDatas
{
    CGFloat         max;
    
    if (xTopAxisScaleDatas.count <= 0) return;
    [super setXTopAxisScaleDatas:xTopAxisScaleDatas];
    max =[[xTopAxisScaleDatas valueForKeyPath:@"@max.floatValue"] floatValue];
    self.xTopAxisWidth = self.width - self.leftAxisMargin - self.rightAxisMargin;
    self.xTopAverScaleLen = self.xTopAxisWidth / max;
}

-(void)drawTopAxisData{
    
    CGFloat             x;
    CGFloat             y;
    RectangleAttr       rectangleAttr;
    CGSize              textSize;
    NSString*           text;
    NSInteger           index;
    LineProperty        lineProperty;
    CGFloat             divisor;
    NSNumber*           number;
    CGFloat             maxAxisScaleValue;
    CGFloat             scaleValue;
    
    maxAxisScaleValue = 0;
    divisor = 0;
    lineProperty = [_pGraphicEngine defaultLineProperty];
    lineProperty.stroColor = kCGLightBlack;
    x = self.leftAxisMargin;
    y = self.height;
    for (number in self.xTopAxisScaleDatas) if (maxAxisScaleValue < [number floatValue]) maxAxisScaleValue = [number floatValue];
    if (maxAxisScaleValue > kDivisor) divisor = kDivisor;
    [_pGraphicEngine mDrawLineStartPoint:CGPointMake(x, y) EndPoint:CGPointMake(x + self.xTopAxisWidth, y) LineProperty:&lineProperty];
    for (index = 0; index < self.xTopAxisScaleDatas.count; index++) {
        scaleValue = [self.xTopAxisScaleDatas[index] floatValue];
        x = scaleValue * self.xTopAverScaleLen + self.leftAxisMargin;
        y = self.height;
        [_pGraphicEngine mDrawLineStartPoint:CGPointMake(x, y) EndPoint:CGPointMake(x , y - kScaleLen) LineProperty:&lineProperty];
        text = [NSString stringWithFormat:@"%.0f",roundf(scaleValue) / divisor];
        textSize = [_pGraphicEngine mCalcuateTextSizeText:text textAttr:self.fontAttr];
        x = x - textSize.width/2;
        y -= kScaleLen + textSize.height;
        [_pGraphicEngine mDrawDecimalText:text Point:CGPointMake(x, y) textAttr:self.fontAttr];
        y -= self.textUnit.height;
        if (maxAxisScaleValue == scaleValue) if(divisor == kDivisor)[_pGraphicEngine mDrawText:@"单位:万" Point:CGPointMake(x - self.textUnit.width/2, y) textAttr:self.fontAttr];
    }
    
}

-(void)setXBottomAxisScaleDatas:(NSMutableArray *)xBottomAxisScaleDatas{
    
    CGFloat         max;
    
    if (xBottomAxisScaleDatas.count <= 0) return;
    [super setXBottomAxisScaleDatas:xBottomAxisScaleDatas];
    max =[[xBottomAxisScaleDatas valueForKeyPath:@"@max.floatValue"] floatValue];
    self.xBottomAxisWidth = self.width - self.leftAxisMargin - self.rightAxisMargin;
    self.xBottomAverScaleLen = self.xBottomAxisWidth / max;
}

-(void)drawBottomAxisData{
    
    CGFloat             x;
    CGFloat             y;
    RectangleAttr       rectangleAttr;
    CGSize              textSize;
    NSString*           text;
    NSInteger           index;
    LineProperty        lineProperty;
    CGFloat             divisor;
    NSNumber*           number;
    CGFloat             maxAxisScaleValue;
    CGFloat             scaleValue;
    
    maxAxisScaleValue = 0;
    divisor = 1;
    lineProperty = [_pGraphicEngine defaultLineProperty];
    lineProperty.stroColor = kCGLightBlack;
    x = self.leftAxisMargin;
    y = 0;
    for (number in self.xBottomAxisScaleDatas) if (maxAxisScaleValue < [number floatValue]) maxAxisScaleValue = [number floatValue];
    if (maxAxisScaleValue > kDivisor) divisor = kDivisor;
    [_pGraphicEngine mDrawLineStartPoint:CGPointMake(x, y) EndPoint:CGPointMake(x + self.xBottomAxisWidth, y) LineProperty:&lineProperty];
    for (index = 0; index < self.xBottomAxisScaleDatas.count; index++) {
        scaleValue = [self.xBottomAxisScaleDatas[index] floatValue];
        x = scaleValue * self.xBottomAverScaleLen + self.leftAxisMargin;
        y = 0;
        [_pGraphicEngine mDrawLineStartPoint:CGPointMake(x, y) EndPoint:CGPointMake(x , y + kScaleLen) LineProperty:&lineProperty];
        text = [NSString stringWithFormat:@"%.0f",roundf(scaleValue) / divisor];
        textSize = [_pGraphicEngine mCalcuateTextSizeText:text textAttr:self.fontAttr];
        x = x - textSize.width/2;
        y += kScaleLen;
        [_pGraphicEngine mDrawDecimalText:text Point:CGPointMake(x, y) textAttr:self.fontAttr];
        y += self.textUnit.height;
        if (maxAxisScaleValue == scaleValue) if(divisor == kDivisor)[_pGraphicEngine mDrawText:@"单位:万" Point:CGPointMake(x - self.textUnit.width/2, y) textAttr:self.fontAttr];
    }
    
}

-(void)setYLeftAxisScaleDatas:(NSMutableArray *)yLeftAxisScaleDatas{
    
    CGFloat         max;
    CGFloat         min;
    
    if (yLeftAxisScaleDatas.count <= 0) return;
    [super setYLeftAxisScaleDatas:yLeftAxisScaleDatas];
    _maxAxisScaleValue =[[yLeftAxisScaleDatas valueForKeyPath:@"@max.floatValue"] floatValue];
    _minAxisScaleValue =[[yLeftAxisScaleDatas valueForKeyPath:@"@min.floatValue"] floatValue];
    self.yLeftAxisHeight = self.height - self.topAxisMargin - self.bottomAxisMargin;
    self.yLeftAverScaleLen = self.yLeftAxisHeight / (_maxAxisScaleValue - _minAxisScaleValue);
}

-(void)drawLeftAxisData{
    
    LineProperty        lineProperty;
    NSDictionary*       textAttr;
    NSUInteger          index;
    NSUInteger          xAverSacleLen;
    NSUInteger          xAxisScaleCount;
    NSUInteger          yAverScaleLen;
    NSUInteger          yAxisScaleCount;
    NSString*           text;
    CGSize              textSize;
    NSNumber*           number;
    CGFloat             divisor;
    CGFloat             x;
    CGFloat             y;
    CGFloat             margin;
    

    divisor = 1;
    margin = 2;
    lineProperty = [_pGraphicEngine defaultLineProperty];
    lineProperty.stroColor = kCGLightBlack;
    y = self.topAxisMargin + self.yLeftAxisHeight;
    x = self.width - 5;
    [_pGraphicEngine mDrawLineStartPoint:CGPointMake(x ,y) EndPoint:CGPointMake(x, self.topAxisMargin) LineProperty:&lineProperty];
    if (_maxAxisScaleValue > kDivisor) divisor = kDivisor;
    yAxisScaleCount =  self.yLeftAxisScaleDatas.count;
    
    for (index = yAxisScaleCount ; index > 0; index--)
    {
        number = [self.yLeftAxisScaleDatas objectAtIndex:(index - 1)];
        x = self.width - 5;
        if (_minAxisScaleValue < 0) y = (self.topAxisMargin + self.yLeftAxisHeight)/2 - [number floatValue] * self.yLeftAverScaleLen;
        else y = (self.topAxisMargin + self.yLeftAxisHeight) - [number floatValue] * self.yLeftAverScaleLen;
        [_pGraphicEngine mDrawLineStartPoint:CGPointMake(x, y) EndPoint:CGPointMake(x - kScaleLen, y) LineProperty:&lineProperty];
        text = [NSString stringWithFormat:@"%.0f",roundf(number.floatValue) / divisor];
        textSize = [text sizeWithAttributes:textAttr];
        x -= textSize.width + kScaleLen + margin;
        y -= textSize.height/2;
        if( x < 0) x = 0;
        if (y < 0) y = 0;
        [_pGraphicEngine mDrawDecimalText:text Point:CGPointMake(x, y) textAttr:self.fontAttr];
    }
    if(divisor == kDivisor)[_pGraphicEngine mDrawText:@"单位:万" Point:CGPointMake(0, self.topAxisMargin + self.yLeftAxisHeight + self.text10000.height/2) textAttr:self.fontAttr];
    
}
@end
