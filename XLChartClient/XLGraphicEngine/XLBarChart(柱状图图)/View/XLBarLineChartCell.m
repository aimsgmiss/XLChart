//
//  XLBarChartCell.m
//  ICoo
//
//  Created by JuniorKey on 9/30/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLBarLineChartCell.h"
@interface XLBarLineChartCell()
/**  bar高度（横向）*/
@property (nonatomic,assign) CGFloat barHeight;
/**  bar宽度（纵向）*/
@property (nonatomic,assign) CGFloat barWidth;
/** 边距*/
@property (nonatomic,assign) CGFloat margin;

@end


@implementation XLBarLineChartCell

-(void)setBarCount:(NSInteger)barCount{
    
    _barCount = barCount;
    //if (_zoomType == ChartZoomTypeNormal) _barHeight = (_cellHeight - _margin * (barCount + 1))/_barCount;
    //else if(_zoomType == ChartZoomTypeDeflate) _barHeight = (_cellHeight - 15)/_barCount;
    if (_cellHeight > 0) _barHeight = (_cellHeight - _margin * (barCount + 1))/_barCount;
    if (_cellWidth > 0) _barWidth = (_cellWidth - _margin * (barCount + 1))/_barCount;
}

-(instancetype)initWithFrame:(CGRect)frame zoomType:(ChartZoomType)zoomType
{
    self = [super initWithFrame:frame zoomType:zoomType];
    self.rightMargin = 0;
    self.topMargin = 2;
    _cellHeight = frame.size.height;
    _cellWidth = frame.size.width;
    self.bottomMargin = 0;
    self.margin = self.topMargin;
    return self;
}

-(void)setBarChartM:(XLBarLineChartM *)barChartM{
    
    CGFloat         x;
    CGFloat         y;
    CGFloat         margin;
    CGFloat         n1;
    CGFloat         n2;
    CGFloat         height;
    CGRect          middleRect;
    
    margin = self.margin;
    x = margin;
    y = margin;
    if ([barChartM.number floatValue] > 0)   barChartM.rect = [self getCellBarRect:barChartM.number x:x y:y];
    if([barChartM.backgoundNumber floatValue] > 0) barChartM.backgroundRect = [self getCellBarRect:barChartM.backgoundNumber x:x y:y];
    if(_barHeight > 0)y += _barHeight + margin;
    if(_barWidth > 0)x += _barWidth + margin;
    if ([barChartM.number2 floatValue] != 0) barChartM.rect2 = [self getCellBarRect:barChartM.number2 x:x y:y];
    if(_barHeight > 0)y += _barHeight + margin;
    if(_barWidth > 0)x += _barWidth + margin;
    if ([barChartM.number3 floatValue] > 0) barChartM.rect3 = [self getCellBarRect:barChartM.number3 x:x y:y];
    
    //线性图
    if ([barChartM.lineNumber floatValue] != 0) {
        
        if(barChartM.preBarCharLineM) barChartM.prePoint = [self getPointX:0 n1:[barChartM.preBarCharLineM.lineNumber floatValue] n2:[barChartM.lineNumber floatValue]];
        if (barChartM.suffixBarCharLineM) barChartM.suffixPoint = [self getPointX:self.width n1:[barChartM.lineNumber floatValue] n2:[barChartM.suffixBarCharLineM.lineNumber floatValue]];
        barChartM.middlePoint = [self getPointX:self.width/2 number:[barChartM.lineNumber floatValue]];
    }
    _barChartM = barChartM;
}

-(CGPoint)getPointX:(CGFloat) x number:(CGFloat)number
{
    CGFloat         y;
    CGFloat         height;
    
    height = number  * self.yLeftAverScaleLen;
    // 说明存在负数值（分为上半轴，和下半轴）
    if (_xAxisInYAxisMiddle) {
        y = (self.height - self.bottomAxisMargin)/2 - height ;
    } else {// 没有负数值
        y = (self.height - self.bottomAxisMargin) - height ;
    }
    
    return  CGPointMake(x, y);
}

/** 线性图点*/
-(CGPoint)getPointX:(CGFloat)x n1:(CGFloat)n1  n2:(CGFloat)n2{
    
    CGFloat         number;
    CGRect          rect;
    
    if (n1 == n2) return [self getPointX:x number:n1];
    number = (n2 * n2 - n1 * n1) / (2 * (n2 - n1));
    return  [self getPointX:x number:number];
}

/** 柱状图矩形范围*/
-(CGRect)getCellBarRect:(NSString*)number x:(CGFloat)x y:(CGFloat)y{
    
    CGFloat         width;
    CGRect          rect;
    CGFloat         height;
    CGPoint         point;
    
    if (_chartType == barChartType_DirectionRight) {
        width = [number floatValue] * self.xTopAverScaleLen;
        rect = CGRectMake(self.leftMargin, y, width, _barHeight);
    } else
    {
        height = [number floatValue]  * self.yLeftAverScaleLen;
        // 说明存在负数值（分为上半轴，和下半轴）
        if (_xAxisInYAxisMiddle) {
            if (height < 0) y = (self.height - self.bottomAxisMargin)/2;
            else y = (self.height - self.bottomAxisMargin)/2 - height ;
        } else {// 没有负数值
            y = (self.height - self.bottomAxisMargin) - height ;
        }
        rect = CGRectMake(x, y, _barWidth, fabs(height));
    }
    return rect ;
}



-(void)drawRect:(CGRect)rect
{
    CGFloat         x;
    CGFloat         y;
    CGSize          textSize;
    NSString*       text;
    LineProperty    lineProperty;
    NSInteger       count;
    CircleAttr      circleAttr;
    
    count = 0;
    [super drawRect:rect];
    lineProperty =[_pGraphicEngine defaultLineProperty];
    lineProperty.stroColor = kCGLightBlack;
    circleAttr = [_pGraphicEngine defaultCircleAttr];
    circleAttr.strokColor = kCGBlueColor;
    circleAttr.fillColor = kCGBlueColor;
    text = _barChartM.name;
    textSize = [_pGraphicEngine mCalcuateTextSizeText:text textAttr:self.fontAttr];
    if (_chartType == barChartType_DirectionRight) {
        x = self.leftMargin;
        y = _barChartM.rect.size.height/2 - textSize.height/2;
        if (x - textSize.width <= 0) x = 0;
        else x = self.leftMargin - textSize.width;
        [_pGraphicEngine mDrawText:text Point:CGPointMake(x, y) textAttr:self.fontAttr];
        y = rect.size.height;
        x = self.leftMargin;
        [_pGraphicEngine mDrawLineStartPoint:CGPointMake(x, 0) EndPoint:CGPointMake(x, y) LineProperty:&lineProperty];
        [_pGraphicEngine mDrawLineStartPoint:CGPointMake(x, y) EndPoint:CGPointMake(x - 5, y) LineProperty:&lineProperty];
    } else {
    
        x = self.width/2 - textSize.width/2;
        y = self.height - self.bottomAxisMargin +  textSize.height/2;
        [_pGraphicEngine mDrawText:text Point:CGPointMake(x, y) textAttr:self.fontAttr];
        y = rect.size.height;
        x = self.leftMargin;
        [_pGraphicEngine mDrawLineStartPoint:CGPointMake(x, 0) EndPoint:CGPointMake(x, y) LineProperty:&lineProperty];
        [_pGraphicEngine mDrawLineStartPoint:CGPointMake(x, y) EndPoint:CGPointMake(x - 5, y) LineProperty:&lineProperty];
        y = self.height - self.bottomAxisMargin;
        /// 中间x轴线

        if (_xAxisInYAxisMiddle) [_pGraphicEngine mDrawLineStartPoint:CGPointMake(0, y/2) EndPoint:CGPointMake(self.width, y/2) LineProperty:&lineProperty];
    }

    CGFloat dashs[] = {5,5};
    lineProperty.dashs = (CGFloat*)(&dashs);
    lineProperty.count = 2;
    for (NSString* number in self.xTopAxisScaleDatas) {
        if (count++ == 0) continue;
        x = [number floatValue] * self.xTopAverScaleLen;
        y = 0;
        [_pGraphicEngine mDrawLineStartPoint:CGPointMake(self.leftMargin + x, y) EndPoint:CGPointMake(self.leftMargin + x, rect.size.height) LineProperty:&lineProperty];
    }
    // 如果有先填充背景()
    if([_barChartM.backgoundNumber floatValue] > 0) [self drawCellText:_barChartM.backgoundNumber rect:_barChartM.backgroundRect fillColor:kGrayColor];
    
    if (_barChartM.number) [self drawCellText:_barChartM.number rect:_barChartM.rect fillColor:kBrazilRedColor];
    
    if (_barChartM.number2) [self drawCellText:_barChartM.number2 rect:_barChartM.rect2 fillColor:kGreenColor];
    
    if (_barChartM.number3) [self drawCellText:_barChartM.number3 rect:_barChartM.rect3 fillColor:kMagentaColor];
    
    //线性图
    if (_barChartM.lineNumber) {
        if (_barChartM.preBarCharLineM) {
            [_pGraphicEngine mDrawLineStartPoint:_barChartM.prePoint EndPoint:_barChartM.middlePoint strokeColor:kCGBlueColor];
        }
        [_pGraphicEngine mDrawCirclePoint:_barChartM.middlePoint circleAttrs:&circleAttr];
        if (_barChartM.suffixBarCharLineM) {
            [_pGraphicEngine mDrawLineStartPoint:_barChartM.middlePoint EndPoint:_barChartM.suffixPoint strokeColor:kCGBlueColor];
        }
        text = _barChartM.lineNumber;
        textSize = [_pGraphicEngine mCalcuateTextSizeText:text textAttr:self.fontAttr];
        [_pGraphicEngine mDrawDecimalText:text Point:CGPointMake(_barChartM.middlePoint.x - textSize.width/2, _barChartM.middlePoint.y - textSize.height) textAttr:self.fontAttr];
    }
    
}
-(void)drawCellText:(NSString*)text rect:(CGRect)rect fillColor:(UIColor*)fillColor{
    
    RectangleAttr   rectangleAttr;
    CGFloat         x;
    CGFloat         y;
    CGSize          textSize;
    
    rectangleAttr = [_pGraphicEngine defaultRectangleAttr];
    rectangleAttr.fillColor = [_pGraphicEngine UIColorConvertCGColor:fillColor];
    [_pGraphicEngine mFillRectangle:rect RectangleAttr:&rectangleAttr];
    textSize = [_pGraphicEngine mCalcuateTextSizeText:text textAttr:self.fontAttr];
    x = self.leftMargin +  rect.size.width;
    y = rect.size.height/2 - textSize.height/2;
    //`[_pGraphicEngine mDrawDecimalText:text Point:CGPointMake(x, y) textAttr:self.fontAttr];
}
@end
