//
//  XLPopupChart.m
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/14/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLPopupChart.h"

@interface XLPopupChart()
{
    CGFloat         _topBottomMargin;
    CGFloat         _leftRightMargin;
    /// 默认宽度
    CGFloat         _defaultWidth;
    /// 默认高度
    CGFloat         _defaultHeight;
}
@end

@implementation XLPopupChart
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setBackgroundColor:kDarkGrayColor];
    self.userInteractionEnabled = YES;
    self.alpha = 0.8;
    self.delegate = self;
    self.fontAttr = kBoldFontSize10LightWhiteColor;
    _topBottomMargin = 2;
    _leftRightMargin = 2;
    _defaultWidth = 50;
    _defaultHeight = 50;
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGSize          textSize;
    CGFloat         x;
    CGFloat         y;
    NSInteger       count;
    NSInteger       index;
    NSArray*        allKeys;
    NSString*       text;
    NSString*       key;
    
    [super drawRect:rect];
    y = _topBottomMargin;
    allKeys = [_popupChartM.contentDic allKeys];
    count = allKeys.count;
    for (index = 0; index < count; index++) {
        x = _leftRightMargin;
        key = [allKeys objectAtIndex:index];
        textSize = [_pGraphicEngine mCalcuateTextSizeText:key textAttr:self.fontAttr];
        [_pGraphicEngine mDrawText:key Point:CGPointMake(x, y) textAttr:self.fontAttr];
        x += textSize.width + _leftRightMargin;
        text = @":";
        textSize = [_pGraphicEngine mCalcuateTextSizeText:text textAttr:self.fontAttr];
        [_pGraphicEngine mDrawText:text Point:CGPointMake(x, y) textAttr:self.fontAttr];
        x += textSize.width + _leftRightMargin;
        text = [_popupChartM.contentDic valueForKey:key];
        [_pGraphicEngine mDrawText:text Point:CGPointMake(x, y) textAttr:self.fontAttr];
        y += textSize.height + _topBottomMargin;
    }

}

-(void)setPopupChartM:(XLPopupChartM *)popupChartM
{
    __block CGFloat         maxWidth;
    __block CGFloat         height;
    __block CGSize          textSize;
    __block NSString*       text;
    CGFloat                 x;
    
    _popupChartM = popupChartM;
    maxWidth = 0.0;
    height = _topBottomMargin;
    [_popupChartM.contentDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        text = [NSString stringWithFormat:@"%@:%@",key,obj];
        textSize = [text sizeWithAttributes:self.fontAttr];
        if (maxWidth < textSize.width) maxWidth = textSize.width;
        height += textSize.height;
    }];
    
    if (maxWidth < _defaultWidth)  maxWidth = _defaultWidth;
    if (height < _defaultHeight) height = _defaultHeight;
    x = _popupChartM.touchPoint.x + maxWidth;
    if (x >= kScreenWidth) x -= maxWidth * 2;
    else x = _popupChartM.touchPoint.x;
    self.frame = CGRectMake(x, _popupChartM.touchPoint.y, maxWidth, height);
    self.contentSize = CGSizeMake(maxWidth, height);
}

#pragma mark - UISrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [scrollView setNeedsDisplay];
}
@end










