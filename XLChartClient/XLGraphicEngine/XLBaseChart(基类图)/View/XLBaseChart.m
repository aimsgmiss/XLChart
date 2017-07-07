//
//  XLBaseChart.m
//  XLGraphicEngine
//
//  Created by JuniorKey on 16/8/31.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.

#import "XLTitleRectangleM.h"
#import "XLBaseChart.h"
#import "XLTitleRectangleChart.h"

@interface XLBaseChart()<UIGestureRecognizerDelegate>
@end


@implementation XLBaseChart


-(instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame zoomType:ChartZoomTypeNormal];
}

-(instancetype)initWithFrame:(CGRect)frame zoomType:(ChartZoomType)zoomType
{
    
    self = [super initWithFrame:frame];
    [self setBackgroundColor:kWhiteColor];
    _tapRecongnizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecogizer:)];
    [self addGestureRecognizer:_tapRecongnizer];
    self.userInteractionEnabled = NO;
    self.selected = false;
    _zoomType = zoomType;
    if (zoomType == ChartZoomTypeNormal) {
        if(IS_IPHONE_4){
            self.titlRectChartHeight = 25;
            self.fontAttr = kSystemFontSize9BlackColor;
        }else if(IS_IPHONE_5){
            self.titlRectChartHeight = 25;
            self.fontAttr = kSystemFontSize9BlackColor;
        }else if(IS_IPHONE_6){
           self.titlRectChartHeight = 30;
            self.fontAttr = kSystemFontSize11BlackColor;
        }else if(IS_IPHONE_6_PLUS){
          self.titlRectChartHeight = 30;
            self.fontAttr = kSystemFontSize12BlackColor;
        }
    }else if(zoomType == ChartZoomTypeDeflate){         //缩放
    
        if(IS_IPHONE_4){
            self.titlRectChartHeight = 20;
            self.fontAttr = kSystemFontSize9BlackColor;
        }else if(IS_IPHONE_5){
            self.titlRectChartHeight = 20;
            self.fontAttr = kSystemFontSize9BlackColor;
        }else if(IS_IPHONE_6){
            self.titlRectChartHeight = 25;
            self.fontAttr = kSystemFontSize9BlackColor;
        }else if(IS_IPHONE_6_PLUS){
            self.titlRectChartHeight = 20;
            self.fontAttr = kSystemFontSize9BlackColor;
        }
    }
    self.delegate = self;
    return self;
}

-(void)setTitlRectDataSource:(NSArray *)titlRectDataSource{
    NSInteger           index;
    XLTitleRectangleM*  titleRectM;
    
    _titlRectDataSource = titlRectDataSource;
    titleRectM = [[XLTitleRectangleM alloc]init];
    for (index = 0; index < self.titlRectDataSource.count; index++) {
        [titleRectM.titles addObject:self.titlRectDataSource[index]];
        //[titleRectM.colors addObject:[CRoutines getUIColorFromUColorsAtIndex:index]];
    }
    self.titlRectChart.titleRectM = titleRectM;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef            ctx;
    
    if (!_pGraphicEngine) {
        ctx = UIGraphicsGetCurrentContext();
        _pGraphicEngine = [[XLGraphicEngine alloc]init];
        _pGraphicEngine.ctx = ctx;
    }
    //画背景纹理
}

-(void)tapGestureRecogizer:(UITapGestureRecognizer*)tapGesture
{
    if (self.popupChart){
        //[self.popupChart removeFromSuperview];
        self.popupChart = nil;
    }
    NSLog(@"BaseChart tapGesture");
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return ![gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [scrollView setNeedsDisplay];
}

-(CGSize)text10000{
    return [@"10000" sizeWithAttributes:self.fontAttr];
}
@end

@implementation XLBaseAxisChart

XLAddMethodImTemplate(xTopAxisScaleDatas)
XLAddMethodImTemplate(yLeftAxisScaleDatas)
XLAddMethodImTemplate(xBottomAxisScaleDatas)
XLAddMethodImTemplate(yRightAxisScaleDatas)


@end
