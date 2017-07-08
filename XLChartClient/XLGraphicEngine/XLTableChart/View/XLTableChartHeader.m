//
//  XLTableChartHeader.m
//  ICoo
//
//  Created by JuniorKey on 10/9/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLTableChartHeader.h"

#define kAsending               @"kAsending"
#define kDesending              @"kDesending"

@interface XLTableChartHeader()

/** 当前点击headerSorts的序列（升序，降序）*/
@property (nonatomic,strong) NSMutableArray* headerSorts;
@end

@implementation XLTableChartHeader
XLAddMethodImTemplate(headerSorts)
-(instancetype)initWithFrame:(CGRect)frame zoomType:(ChartZoomType)zoomType
{
    self = [super initWithFrame:frame zoomType:zoomType];

   
    self.userInteractionEnabled = YES;
    return self;
}
-(void)drawRect:(CGRect)rect
{
    NSInteger           index;
    NSInteger           count;
    CGFloat             x;
    CGFloat             y;
    NSString*           text;
    CGSize              textSize;
    CGFloat             cellWidth;
    RectangleAttr       rectangleAttr;
    CGFloat             len;
    CGFloat             averLen;
    
    [super drawRect:rect];
    count = self.dataSource.count;
    if (count > 0) {
        y = self.topMargin;
        x = 0;
        rectangleAttr = [_pGraphicEngine defaultRectangleAttr];
        rectangleAttr.fillColor = kCGLightBlue;
        [_pGraphicEngine mFillRectangle:CGRectMake(0, y, rect.size.width, _headerHeight) RectangleAttr:&rectangleAttr];
        for (index = 0; index < count; index++) {
            [self.headerSorts addObject:kAsending];
            text = self.dataSource[index];
            cellWidth = ((NSNumber*)_tableCellWidths[index]).floatValue;
            textSize = [_pGraphicEngine mCalcuateTextSizeText:text textAttr:self.fontAttr];
            [_pGraphicEngine mDrawLineStartPoint:CGPointMake(x, 0) EndPoint:CGPointMake(x, rect.size.height) strokeColor:kCGLightBlack];
            if (textSize.width > cellWidth) {
                averLen = textSize.width/text.length;
                len = cellWidth / averLen;
                text = [text substringWithRange:NSMakeRange(0, len - 1)];
                text = [text stringByAppendingString:@"..."];
                [_pGraphicEngine mDrawText:text Point:CGPointMake(x, y + _headerHeight/2 - textSize.height/2) textAttr:self.fontAttr];
            } else [_pGraphicEngine mDrawText:text Point:CGPointMake(x + cellWidth/2 - textSize.width/2, y + _headerHeight/2 - textSize.height/2) textAttr:self.fontAttr];
            x += cellWidth;
        }
       
    }
}

-(void)tapGestureRecogizer:(UITapGestureRecognizer*)tapGesture
{
    CGPoint             touchPoint;
    NSUInteger          count;
    NSInteger           index;
    CGFloat             cellWidths  = 0.0f;
    BOOL                asending;
    
    [super tapGestureRecogizer:tapGesture];
    touchPoint = [tapGesture locationInView:self];
    count = self.dataSource.count;
    for (index = 0; index < count; index++) {
        cellWidths += ((NSNumber*)_tableCellWidths[index]).floatValue;
        if (cellWidths >= touchPoint.x) {
            if ([self.tableChartHeaderDelegate respondsToSelector:@selector(didSelectedTableChartHeaderIndex:asending:)]) {
                if ([_headerSorts[index] isEqualToString:kDesending]){
                    asending = true;
                    _headerSorts[index] = kAsending;
                } else {
                    asending = false;
                    _headerSorts[index] = kDesending;
                }
                [self.tableChartHeaderDelegate didSelectedTableChartHeaderIndex:index asending:asending];
            }
            break;
        }
    }
}

@end




