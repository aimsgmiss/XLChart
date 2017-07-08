
//
//  XLTitleRectangleChart.m
//  ICoo
//
//  Created by JuniorKey on 10/25/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLTitleRectangleChart.h"

@interface XLTitleRectangleChart()
{
    /// x轴方向矩形与文字的间距
    CGFloat             _xRectTitleMargin;
    /// x轴方向文字与矩形的间距
    CGFloat             _xTitleRectMargin;
}
@end
@implementation XLTitleRectangleChart

-(instancetype)initWithFrame:(CGRect)frame zoomType:(ChartZoomType)zoomType
{
    return [self initWithFrame:frame zoomType:zoomType titleRectType:TitleRectChartType_Horizontal];
}
-(instancetype)initWithFrame:(CGRect)frame zoomType:(ChartZoomType)zoomType titleRectType:(TitleRectChartType) titleRectChartType
{
    self = [super initWithFrame:frame zoomType:zoomType];
    _zoomType = zoomType;
    self.leftMargin = 2;
    self.topMargin = 2;
    _xRectTitleMargin = 5;
    _xTitleRectMargin = 15;
    _titleRectWidth = 25;
    _titleRectChartType = titleRectChartType;
    self.showsHorizontalScrollIndicator = NO;
    return self;
}
- (void)drawRect:(CGRect)rect
{
    NSInteger           index;
    CGFloat             x;
    CGFloat             y;
    NSString*           text;
    CGSize              textSize;
    UIColor*            uFillColor;
    
    if (_titleRectM.titles.count == _titleRectM.colors.count) {
        [super drawRect:rect];
        x = self.leftMargin;
        y = self.topMargin;
        for (index = 0; index < _titleRectM.titles.count; index++) {
            text = _titleRectM.titles[index];
            textSize = [_pGraphicEngine mCalcuateTextSizeText:text textAttr:self.fontAttr];
            if (index == 0) _titleRectHeight = textSize.height;
            uFillColor = _titleRectM.colors[index];
            [_pGraphicEngine mFillRoundRectangle:CGRectMake(x, y,  self.titleRectWidth,  self.titleRectHeight) RoundRectangleAttr:nil fillColor:uFillColor];
             x += self.titleRectWidth + _xRectTitleMargin;
            [_pGraphicEngine mDrawText:text Point:CGPointMake(x, y) textAttr:self.fontAttr];
            if (_titleRectChartType == TitleRectChartType_Horizontal)
            {
                x += textSize.width + _xTitleRectMargin;
            }  else if (_titleRectChartType == TitleRectChartType_Vertical) {
                y += textSize.height + 5;
                x = self.leftMargin;
            }
        }
        if (_titleRectChartType == TitleRectChartType_Horizontal) self.contentSize = CGSizeMake(x, rect.size.height);
        else if (_titleRectChartType == TitleRectChartType_Vertical) self.contentSize = CGSizeMake(x, y);
        
    }
   
    
}


@end
