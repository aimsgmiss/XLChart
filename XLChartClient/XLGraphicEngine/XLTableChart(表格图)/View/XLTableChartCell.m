//
//  XLTableChartCell.m
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/19/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLTableChartCell.h"

@implementation XLTableChartCell

-(instancetype)initWithFrame:(CGRect)frame zoomType:(ChartZoomType)zoomType
{
    
    NSArray *array = @[kWhiteColor,kBlueColor,kLightGrayColor,kCyanColor,kMagentaColor,kYellowColor,kBrownColor];
    self = [super initWithFrame:frame zoomType:zoomType];
    self.bkColor = array[rand()%1];
    self.selectedBkColor = kBrazilRedColor;
    self.userInteractionEnabled = NO;
    self.leftMargin = 0;
    self.topMargin = 0;
    self.rightMargin = 0;
    _cellHeight = 20;
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self drawBorder];
    [self drawDatas];
}

-(void)drawBorder
{
    LineProperty    lineProperty;
    CGPoint         startPoint;
    CGPoint         endPoint;
    NSUInteger      index;
    CGFloat         x;
    CGFloat         y;
    RectangleAttr   rectangleAttr;
    CGFloat         cellWidth;
    
    rectangleAttr = [_pGraphicEngine defaultRectangleAttr];
    lineProperty = [_pGraphicEngine defaultLineProperty];
    lineProperty.lineWidth = 1;
    lineProperty.stroColor = kCGLightBlack;
    startPoint = CGPointMake(self.leftMargin, 0);
    endPoint = CGPointMake(self.leftMargin + _width, 0);
    self.bkColor = _tableCellM.bkColor;
    [_pGraphicEngine mDrawLineStartPoint:startPoint EndPoint:endPoint LineProperty:&lineProperty];
    if (self.selected) rectangleAttr.fillColor = [_pGraphicEngine UIColorConvertCGColor:self.selectedBkColor];
    else rectangleAttr.fillColor = [_pGraphicEngine UIColorConvertCGColor:self.bkColor];
    [_pGraphicEngine mFillRectangle:CGRectMake(0, 1, _width,_height - 1) RectangleAttr:&rectangleAttr];
    x = self.leftMargin;
    for (index = 0; index < _xTitleCount;index++ ) {
        cellWidth = ((NSNumber*)self.tableCellWidths[index]).floatValue;
        x += cellWidth  ;
        startPoint = CGPointMake(x, 1);
        endPoint = CGPointMake(x, _cellHeight);
        [_pGraphicEngine mDrawLineStartPoint:startPoint EndPoint:endPoint LineProperty:&lineProperty];
    }

}

-(void)drawDatas
{

    NSString*           text;
    CGSize              textSize;
    CGFloat             x;
    CGFloat             y;
    NSUInteger          index;
    NSDictionary*       textAttr;
    ArrowAttr           arrowAttr;
    CGFloat             cellWidth;
    CGFloat             maxCellRowCount;
    CGFloat             cellRowHeight;
    id                  obj;
    
    arrowAttr = [_pGraphicEngine defaultArrowAttr];
    arrowAttr.radius = 2;
    arrowAttr.lineWidth = 2;
    x = self.leftMargin;
    for (index = 0; index < _tableCellM.items.count; index++) {
        y = self.topMargin;
        obj = [_tableCellM.items objectAtIndex:index];
        cellWidth = ((NSNumber*)self.tableCellWidths[index]).floatValue;
        if ([obj isKindOfClass:[NSArray class]]) {
            maxCellRowCount = [obj count];
            cellRowHeight = _cellHeight/maxCellRowCount;
            for (text in obj) {
                textSize = [_pGraphicEngine mCalcuateTextSizeText:text textAttr:self.fontAttr];
                if (x + cellWidth/2 - textSize.width/2 <= 0) [_pGraphicEngine mDrawText:text Point:CGPointMake(0, y + cellRowHeight/2 - textSize.height/2) textAttr:self.fontAttr];
                else [_pGraphicEngine mDrawText:text Point:CGPointMake(x + cellWidth/2 - textSize.width/2, y + cellRowHeight/2 - textSize.height/2) textAttr:self.fontAttr];
                y += cellRowHeight;
                [_pGraphicEngine mDrawLineStartPoint:CGPointMake(x, y) EndPoint:CGPointMake(x + cellWidth, y) strokeColor:kCGLightBlack];
            }
        } else if([obj isKindOfClass:[NSString class]]) {
            
            text = obj;
            if ([text containsString:kTableChartPreIndexStr]) text = [text substringFromIndex:3];
            
            /*if([text isEqualToString:@"成长趋势向上"])
            {
                arrowAttr.arrowDirection = arrowDirection_up;
                [_pGraphicEngine mDrawArrowStartPoint:CGPointMake(x + cellWidth/2, y + _cellHeight*3/4) EndPoint:CGPointMake(x + cellWidth/2, y + _cellHeight/4) arrowAttr:&arrowAttr];
                x += cellWidth;
                continue;
            }
            else if([text isEqualToString:@"成长趋势向下"])
            {
                arrowAttr.arrowDirection = arrowDirection_down;
                [_pGraphicEngine mDrawArrowStartPoint:CGPointMake(x + cellWidth/2, y + _cellHeight*1/4) EndPoint:CGPointMake(x + cellWidth/2, y + _cellHeight*3/4) arrowAttr:&arrowAttr];
                x += cellWidth;
                continue;
            }*/
            textSize = [_pGraphicEngine mCalcuateTextSizeText:text textAttr:self.fontAttr];
            if (x + cellWidth/2 - textSize.width/2 <= 0) [_pGraphicEngine mDrawText:text Point:CGPointMake(0, y + _cellHeight/2 - textSize.height/2) textAttr:self.fontAttr];
            else [_pGraphicEngine mDrawText:text Point:CGPointMake(x + cellWidth/2 - textSize.width/2, y + _cellHeight/2 - textSize.height/2) textAttr:self.fontAttr];
        }
      
        x += cellWidth;
    }
}

-(void)setTableCellWidths:(NSMutableArray *)tableCellWidths
{
    CGFloat         cellWidth;
    
    if (_tableCellWidths != tableCellWidths) {
        _tableCellWidths = tableCellWidths;
        _width = 0;
        for (int index = 0; index  < tableCellWidths.count; index++) {
            cellWidth = ((NSNumber*)tableCellWidths[index]).floatValue;
            _width += cellWidth;
        }
    }
}

-(void)setCellHeight:(CGFloat)cellHeight
{
  
    _cellHeight = cellHeight;
    _height = self.topMargin + cellHeight;
    
}


@end








