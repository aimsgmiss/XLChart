//
//  XLRadarChart.m
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/8/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLChart.h"
#import "XLRadarM.h"
#import "CRoutines.h"

#define kStartRadian                  M_PI/6

@interface XLRadarChart()
{
    CGFloat         _maxRaius;
    CGPoint         _centerPoint;
}
@property (nonatomic,strong) NSArray* items;
/**   半径数组*/
@property (nonatomic,strong) NSArray* radiusS;
@end
@implementation XLRadarChart

-(instancetype)initWithFrame:(CGRect)frame zoomType:(ChartZoomType)zoomType
{
    self = [super initWithFrame:frame zoomType:zoomType];
 
    [self setBackgroundColor:[UIColor whiteColor]];
    self.titlRectChart = [[XLTitleRectangleChart alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, self.titlRectChartHeight) zoomType:zoomType];
    [self addSubview:self.titlRectChart];
    return self;
}

-(void)drawRect:(CGRect)rect
{
    if(_zoomType == ChartZoomTypeDeflate) _maxRaius = rect.size.height/4;
    else _maxRaius = rect.size.width/4;
    _radiusS = @[@(_maxRaius),@(_maxRaius*3/4),@(_maxRaius/2),@(_maxRaius*1/4)];
    _centerPoint = CGPointMake(rect.size.width/2, rect.size.height/2);
    [super drawRect:rect];
    [self draw:rect];
    [self drawData];
    
}

-(void)draw:(CGRect)rect
{
    [self drawFrame:rect];
    
  
}
-(void)drawFrame:(CGRect)rect
{
    NSInteger           itemCount;
    NSInteger           index;
    NSInteger           indey;
    NSInteger           circleCount;
    CGFloat             x;
    CGFloat             y;
    CGFloat             radius;
    CGPoint             centerPoint;
    CGPoint             point;
    CGPoint             startPoint;
    CGPoint             endPoint;
    CGSize              textSize;
    NSString*           drawText;
    LineProperty        linePropety;
    
    linePropety = [_pGraphicEngine defaultLineProperty];
    linePropety.stroColor = kCGGrayColor;
    linePropety.lineWidth = 1;
    centerPoint = _centerPoint;
    circleCount = [self.radiusS count];
    itemCount = [self.items count];
    if (circleCount > 0) {
        CGContextSaveGState(_pGraphicEngine.ctx);
        for (index = 0; index < circleCount; index++) {
            for (indey = 1; indey <= itemCount; indey++) {
                radius = [_radiusS[index] floatValue];
                CGFloat     radian = kStartRadian + 2 * M_PI * indey/itemCount;
                x = centerPoint.x  + radius* cos(radian);
                y = centerPoint.y - radius* sin(radian);
                startPoint = CGPointMake(x, y);
                if (indey ==  itemCount)
                {
                    x = centerPoint.x  + radius* cos(kStartRadian + 2 * M_PI * 1/itemCount);
                    y = centerPoint.y - radius* sin(kStartRadian + 2 * M_PI * 1/itemCount);
                }
                else
                {
                    x = centerPoint.x  + radius* cos(kStartRadian + 2 * M_PI * (indey + 1)/itemCount);
                    y = centerPoint.y - radius* sin(kStartRadian + 2 * M_PI * (indey + 1)/itemCount);
                }
                endPoint = CGPointMake(x, y);
                [_pGraphicEngine mAddLineStartPoint:centerPoint EndPoint:startPoint LineProperty:&linePropety];
                [_pGraphicEngine mAddLineStartPoint:startPoint EndPoint:endPoint LineProperty:&linePropety];
                [_pGraphicEngine mAddLineStartPoint:endPoint EndPoint:centerPoint LineProperty:&linePropety];
                
                if (index == 0) {
                    //显示文字
                    drawText = self.items[indey - 1];
                    textSize = [_pGraphicEngine mCalcuateTextSizeText:drawText textAttr:self.fontAttr];
                    point = startPoint;

                    if( 0 < radian && radian < M_PI_2) point = CGPointMake(startPoint.x , startPoint.y - textSize.height);
                    else if(radian == M_PI_2) point = CGPointMake(startPoint.x - textSize.width/2, startPoint.y - textSize.height);
                    else if ( M_PI_2 < radian && radian <= M_PI) point = CGPointMake(startPoint.x - textSize.width, startPoint.y - textSize.height);
                    else if (M_PI < radian && radian < M_PI * 3 / 2) point = CGPointMake(startPoint.x - textSize.width, startPoint.y );
                    else if(M_PI * 3 /2 == radian) point = CGPointMake(startPoint.x - textSize.width/2, startPoint.y);
                    else if  (M_PI * 3/2 < radian && radian <= M_PI * 2) point = CGPointMake(startPoint.x, startPoint.y - textSize.height/2);
                    [_pGraphicEngine mDrawText:drawText Point:point textAttr:self.fontAttr];
                }
            }
        }
        CGContextDrawPath(_pGraphicEngine.ctx,kCGPathStroke);
        CGContextRestoreGState(_pGraphicEngine.ctx);
    }

}

-(void)setDataSource:(NSMutableArray *)dataSource
{
    int                 index;
    XLRadarM*           radarM;
    XLTitleRectangleM*  titleRectM;
    NSMutableArray*     colors;
    NSMutableArray*     categorys;
    
    colors = [NSMutableArray array];
    categorys = [NSMutableArray array];
    index = 0;
    [super setDataSource:dataSource];
    titleRectM = [[XLTitleRectangleM alloc]init];
   
    for (radarM in self.dataSource)
    {
        _items = radarM.items;
        radarM.fillColor =  [CRoutines getUIColorFromUColorsAtIndex:index++];
        [categorys addObject:radarM.category];
        [colors addObject:radarM.fillColor];
    }
    titleRectM.titles = categorys;
    titleRectM.colors = colors;
    self.titlRectChart.titleRectM = titleRectM;
}

-(void)drawData
{
    XLRadarM*           radarM;
  
    for (radarM in self.dataSource) [self drawLineAndEmptyCircle:radarM.percent Color:radarM.fillColor Category:radarM.category];
}

-(void)drawLineAndEmptyCircle:(NSMutableArray*)radiusArray Color:(UIColor*)uColor Category:(NSString*)str
{
    NSInteger           index;
    CGFloat             x;
    CGFloat             y;
    NSInteger           itemCount;
    CircleAttr          circleAttr;
    LineProperty        lineProperty;
    CGPoint             currentPoint;
    CGFloat             radius;
    CGCOLOR             color;
  
    color = [_pGraphicEngine UIColorConvertCGColor:uColor];
    itemCount = [radiusArray count];
    circleAttr = [_pGraphicEngine defaultCircleAttr];
    circleAttr.circleType = 1;
    circleAttr.strokColor = color;
    circleAttr.radius = 1;
    lineProperty = [_pGraphicEngine defaultLineProperty];
    lineProperty.stroColor = color;
    //先画连接线
    for (index = 1; index <= itemCount; index++)
    {
        radius = [radiusArray[index - 1] floatValue] * _maxRaius;
        x = _centerPoint.x  + radius* cos(kStartRadian + 2 * M_PI * index/itemCount);
        y = _centerPoint.y - radius* sin(kStartRadian + 2 * M_PI * index/itemCount);
        if (index == 1)
        {
            currentPoint = CGPointMake(x, y);
            CGContextMoveToPoint(_pGraphicEngine.ctx, currentPoint.x, currentPoint.y);
            continue;
        }
        CGContextAddLineToPoint(_pGraphicEngine.ctx, x, y);
    }
    CGContextSetRGBStrokeColor(_pGraphicEngine.ctx, kConvertColor(color.r), kConvertColor(color.g), kConvertColor(color.b), 0.5);
    CGContextSetRGBFillColor(_pGraphicEngine.ctx, kConvertColor(color.r), kConvertColor(color.g), kConvertColor(color.b), 0.5);
    CGContextClosePath(_pGraphicEngine.ctx);
    CGContextDrawPath(_pGraphicEngine.ctx, kCGPathFillStroke);
    //后话画空心圆
    for (index = 1; index <= itemCount; index++)
    {
        radius = [radiusArray[index - 1] floatValue] * _maxRaius;
        x = _centerPoint.x  + radius* cos(kStartRadian + 2 * M_PI * index/itemCount);
        y = _centerPoint.y - radius* sin(kStartRadian + 2 * M_PI * index/itemCount);
        [_pGraphicEngine mDrawCirclePoint:CGPointMake(x, y) circleAttrs:&circleAttr];
    }
}
@end




