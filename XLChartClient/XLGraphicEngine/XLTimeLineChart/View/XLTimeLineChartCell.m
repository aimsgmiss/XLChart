//
//  XLTimeLineChatCell.m
//  ICoo
//
//  Created by JuniorKey on 9/23/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLTimeLineChartCell.h"
#import "CRoutines.h"
@interface XLTimeLineChartCell()

@end
@implementation XLTimeLineChartCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    _cellHeight = 20;
    self.fontAttr = kSystemFontSize10BlackColor;
    //self.alpha = 0.5;
    return self;
}
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self drawFrame:rect];
}
-(void)drawFrame:(CGRect)rect
{
    CGFloat         x;
    CGFloat         y;
    NSString*       text;
    CGSize          dateTextSize;
    CGSize          inventoryTextSize;
    CGSize          textSize;
    ArrowAttr       arrowAttr;
    CGFloat         arrowLen;
    CGFloat         margin;
    CGFloat         centerLineX;
    CGFloat         centerLineY;
    LineProperty    lineProperty;
    
    centerLineX = rect.size.width/2;
    centerLineY = 0;
    arrowAttr = [_pGraphicEngine defaultArrowAttr];
    arrowAttr.arrowDirection = arrowDirection_right;
    arrowAttr.radius = 2;
    margin = 8;
    arrowLen = 15;
    lineProperty = [_pGraphicEngine defaultLineProperty];
    lineProperty.lineWidth = 2;
    lineProperty.stroColor = kCGBlueColor;
    [_pGraphicEngine mDrawLineStartPoint:CGPointMake(centerLineX, 0) EndPoint:CGPointMake(centerLineX, _cellHeight) LineProperty:&lineProperty];
    if ([_timeLineM.type isEqualToString:@"2"]) return;
    text = [CRoutines stringFromDate:_timeLineM.date];
    dateTextSize = [_pGraphicEngine mCalcuateTextSizeText:text textAttr:self.fontAttr];
    y = _cellHeight/2 - dateTextSize.height/2;
    [_pGraphicEngine mDrawText:text Point:CGPointMake(centerLineX - margin - dateTextSize.width, y) textAttr:self.fontAttr]; //日期
    text = _timeLineM.inventoryQty;
    inventoryTextSize = [_pGraphicEngine mCalcuateTextSizeText:text textAttr:self.fontAttr];
    [_pGraphicEngine mDrawText:text Point:CGPointMake(centerLineX + margin, y) textAttr:self.fontAttr]; //库存数量
    x = centerLineX;
    if ([_timeLineM.type isEqualToString:@"1"]) {
        x -= margin * 2 + arrowLen + dateTextSize.width + arrowAttr.radius;
        arrowAttr.strokColor = kCGGreenColor;
        [_pGraphicEngine mDrawArrowStartPoint:CGPointMake(x, y + dateTextSize.height/2) EndPoint:CGPointMake(x + arrowLen, y + dateTextSize.height/2) arrowAttr:&arrowAttr];
        x -= margin ;
        text = [NSString stringWithFormat:@"+%@",_timeLineM.qty];//入库数量
        textSize = [_pGraphicEngine mCalcuateTextSizeText:text textAttr:self.fontAttr];
        x = x - textSize.width;
        if (x <= 0) x = 0;
        [_pGraphicEngine mDrawText:text Point:CGPointMake(x, y) textAttr:self.fontAttr];
        
    }else{
        x += margin * 2 + inventoryTextSize.width;
        arrowAttr.strokColor = kCGRedColor;
        [_pGraphicEngine mDrawArrowStartPoint:CGPointMake(x, y + dateTextSize.height/2) EndPoint:CGPointMake(x + arrowLen, y + dateTextSize.height/2) arrowAttr:&arrowAttr];
        x += margin  + arrowLen;
        text = [NSString stringWithFormat:@"-%@",_timeLineM.qty];//出库数量
        [_pGraphicEngine mDrawText:text Point:CGPointMake(x , y) textAttr:self.fontAttr];
    }
        
}
@end
