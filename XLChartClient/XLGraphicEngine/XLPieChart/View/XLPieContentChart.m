//
//  XLPieContentChart.m
//  ICoo
//
//  Created by JuniorKey on 10/31/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLPieContentChart.h"
#import "XLTitleRectangleChart.h"
#import "XLPieChartM.h"
#import "XLPieChart.h"
#import "CRoutines.h"
@interface XLPieContentChart ()
{
    /// 圆弧的半径
    CGFloat         _arcRadius;
    CGFloat         _rectangleWidth;
    CGFloat         _rectangleHeight;
    CGFloat         _titleAndRectangleMargin;
    //选中之后圆弧平移的距离
    CGFloat         _selectedArcMoveLen;
    CGFloat         _titleUpDownMargin;
    CGFloat         _titleX;
    ///第一个指示线的长度
    CGFloat         _firstIndicatorLineLen;
} 
/** 存放扇形的数组*/
@property (nonatomic,strong) NSMutableArray* shapLayers;
@property (nonatomic,assign) CGPoint centerPoint;
@end
@implementation XLPieContentChart


XLAddMethodImTemplate(shapLayers)

-(instancetype)initWithFrame:(CGRect)frame zoomType:(ChartZoomType)zoomType pieChartType:(PieChartType)pieChartType
{
    CGFloat             x;
    CGFloat             y;
    TitleRectChartType  tChartType;
    CGFloat             tHeight;
    
    self = [super initWithFrame:frame zoomType:zoomType];
    if (IS_IPHONE_4) {
        
        _rectangleWidth = 20;
        _rectangleHeight = 8;
        _titleAndRectangleMargin = 4;
        _selectedArcMoveLen = 5;
        _titleUpDownMargin = 10;
        _titleX = 10;
        _firstIndicatorLineLen = 10;
    }
    else if(IS_IPHONE_5){
        _rectangleWidth = 20;
        _rectangleHeight = 10;
        _titleAndRectangleMargin = 5;
        _selectedArcMoveLen = 10;
        _titleUpDownMargin = 20;
        _titleX = 10;
        _firstIndicatorLineLen = 10;
    }else if(IS_IPHONE_6){
        _rectangleWidth = 30;
        _rectangleHeight = 10;
        _titleAndRectangleMargin = 5;
        _selectedArcMoveLen = 10;
        _titleUpDownMargin = 20;
        _titleX = 10;
        _firstIndicatorLineLen = 10;
    }else if(IS_IPHONE_6_PLUS){
        _rectangleWidth = 40;
        _rectangleHeight = 10;
        _titleAndRectangleMargin = 5;
        _selectedArcMoveLen = 5;
        _titleUpDownMargin = 20;
        _titleX = 10;
        _firstIndicatorLineLen = 10;
    }
    if (_zoomType == ChartZoomTypeDeflate)  _arcRadius = frame.size.height / 4;
    else _arcRadius = frame.size.width / 4;
    self.leftMargin = 50;
    self.rightMargin = 50;
    self.topMargin = _selectedArcMoveLen;
    [self setBackgroundColor:kWhiteColor];
    self.delegate = self;
    _pieChartType = pieChartType;
    x = self.leftMargin;
    if (_pieChartType == PieChartType_TitleRectVertical) {
        tChartType = TitleRectChartType_Vertical;
        y = self.topMargin + _arcRadius;
        self.centerPoint = CGPointMake(frame.size.width/2, y);
        tHeight = 175;
        y += _arcRadius;
        self.titlRectChart = [[XLTitleRectangleChart alloc]initWithFrame:CGRectMake(2,  y, frame.size.width, tHeight) zoomType:zoomType titleRectType:tChartType];
        self.titlRectChart.userInteractionEnabled = YES;
        [self addSubview:self.titlRectChart];
    } else if (_pieChartType == PieChartType_TitleRectHorizontal){
        tChartType = TitleRectChartType_Horizontal;
        self.centerPoint = CGPointMake(frame.size.width/2, frame.size.height/2);
    }
    self.userInteractionEnabled = YES;
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self draw];
}
-(void)draw
{
    CAShapeLayer*       shaperLayer;
    NSInteger           index;
    NSInteger           count;
    XLPieChartM*        pieCharM;
    CGMutablePathRef    pathM;
    RectangleAttr       rectangleAttr;
    CGFloat             selectedCenterX;
    CGFloat             selectedCenterY;
    NSString*           drawText;
    NSString*           percent;
    CGFloat             angle;
    LineProperty        lineProperty;
    
    lineProperty = [_pGraphicEngine defaultLineProperty];
    [self.shapLayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.shapLayers removeAllObjects];
    rectangleAttr = [_pGraphicEngine defaultRectangleAttr];
    count = self.dataSource.count;
    for (index = 0; index < count; index++)
    {
        pieCharM = [self.dataSource objectAtIndex:index];
        rectangleAttr.fillColor = [_pGraphicEngine UIColorConvertCGColor:pieCharM.fillColor];
        percent = [CRoutines stringFromFormatterStyle:NSNumberFormatterPercentStyle number:@(pieCharM.percent)];
        drawText = [NSString stringWithFormat:@"%@:(%@)",pieCharM.name,percent];
        shaperLayer = [CAShapeLayer layer];
        lineProperty.stroColor = [_pGraphicEngine UIColorConvertCGColor:pieCharM.fillColor];
        if (pieCharM.selected) {
            angle = 2 * M_PI - pieCharM.middleAngle;
            selectedCenterX = _centerPoint.x + _selectedArcMoveLen * cos(angle);
            selectedCenterY = _centerPoint.y - _selectedArcMoveLen * sin(angle);
            pathM = [self creathArc:CGPointMake(selectedCenterX, selectedCenterY) startAngle:pieCharM.startAngle endAngle:pieCharM.endAngle];
            if (_pieChartType == PieChartType_TitleRectHorizontal) [self drawIndicatorLine:CGPointMake(selectedCenterX, selectedCenterY) angle:angle topText:pieCharM.name bottomText:percent LineProperty:&lineProperty];
        }
        else
        {
            pathM = [self creathArc:self.centerPoint startAngle:pieCharM.startAngle endAngle:pieCharM.endAngle];
            if (_pieChartType == PieChartType_TitleRectHorizontal) [self drawIndicatorLine:self.centerPoint angle:2 * M_PI - pieCharM.middleAngle topText:pieCharM.name bottomText:percent LineProperty:&lineProperty];
        }
        shaperLayer.path = pathM;
        [self.shapLayers addObject:shaperLayer];
        shaperLayer.fillColor = pieCharM.fillColor.CGColor;
        [self.layer insertSublayer:shaperLayer below:self.layer];
        CGPathRelease(pathM);
    }
    
}
-(void)drawIndicatorLine:(CGPoint)centerPoint angle:(CGFloat)angle topText:(NSString*)topText bottomText:(NSString*)bottText LineProperty:(PLineProperty)pLineProperty
{
    CGPoint         startPoint;
    CGPoint         endPoint;
    CGSize          toptextSize;
    CGSize          bottTextSize;
    CGFloat         maxWidth;
    CGFloat         arcRadius;
    
    arcRadius = _arcRadius + 5;
    startPoint = CGPointMake(centerPoint.x + arcRadius * cos(angle), centerPoint.y - arcRadius * sin(angle));
    endPoint = CGPointMake(centerPoint.x + (arcRadius + _firstIndicatorLineLen) * cos(angle), centerPoint.y - (arcRadius + _firstIndicatorLineLen) * sin(angle));
    [_pGraphicEngine mDrawLineStartPoint:startPoint EndPoint:endPoint LineProperty:pLineProperty];
    startPoint = endPoint;
    toptextSize = [_pGraphicEngine mCalcuateTextSizeText:topText textAttr:self.fontAttr];
    bottTextSize = [_pGraphicEngine mCalcuateTextSizeText:bottText textAttr:self.fontAttr];
    maxWidth = toptextSize.width > bottTextSize.width ? toptextSize.width : bottTextSize.width;
    if (angle >= M_PI_2 && angle <= M_PI * 3/2)
    {
        endPoint = CGPointMake(startPoint.x - maxWidth, startPoint.y);
        [_pGraphicEngine mDrawLineStartPoint:startPoint EndPoint:endPoint LineProperty:pLineProperty];
        [_pGraphicEngine mDrawText:topText Point:CGPointMake(endPoint.x, endPoint.y - toptextSize.height) textAttr:self.fontAttr];
        [_pGraphicEngine mDrawText:bottText Point:CGPointMake(endPoint.x, endPoint.y) textAttr:self.fontAttr];
    }
    else
    {
        endPoint = CGPointMake(startPoint.x + maxWidth, startPoint.y);
        [_pGraphicEngine mDrawLineStartPoint:startPoint EndPoint:endPoint LineProperty:pLineProperty];
        [_pGraphicEngine mDrawText:topText Point:CGPointMake(endPoint.x - toptextSize.width, endPoint.y - toptextSize.height) textAttr:self.fontAttr];
        [_pGraphicEngine mDrawText:bottText Point:CGPointMake(endPoint.x - bottTextSize.width, endPoint.y) textAttr:self.fontAttr];
    }
}

-(CGMutablePathRef)creathArc:(CGPoint)centerPoint startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle
{
    CGMutablePathRef    pathM;
    
    pathM = CGPathCreateMutable();
    CGPathMoveToPoint(pathM, NULL, centerPoint.x,centerPoint.y);
    CGPathAddArc(pathM, NULL, centerPoint.x, centerPoint.y, _arcRadius, startAngle, endAngle, false);
    return pathM;
}

-(void)setDataSource:(NSMutableArray *)dataSource
{
    CGFloat             startAngle;
    CGFloat             endAngle;
    XLPieChartM*        pieM;
    NSInteger           index;
    XLTitleRectangleM*  titleRectM;
    NSMutableArray*     colors;
    NSMutableArray*     titles;
    NSString*           title;
    
    index = 0;
    [super setDataSource:dataSource];
    titleRectM = [[XLTitleRectangleM alloc]init];
    colors = [NSMutableArray array];
    titles = [NSMutableArray array];
    startAngle = M_PI_2;
    for (pieM in dataSource) {
        pieM.fillColor = [CRoutines getUIColorFromUColorsAtIndex:index++];
        pieM.startAngle = startAngle;
        endAngle = 2 * M_PI * pieM.percent + startAngle;
        pieM.endAngle = endAngle;
        pieM.middleAngle = (pieM.startAngle + pieM.endAngle)/2;
        startAngle = endAngle;
        [colors addObject:pieM.fillColor];
        title = pieM.name;
        if(self.titlRectChart)if (self.titlRectChart->_titleRectChartType == TitleRectChartType_Vertical) {
            title = [NSString stringWithFormat:@"%@(%@)",title,[CRoutines stringFromFormatterStyle:NSNumberFormatterPercentStyle number:@(pieM.percent)]];
        }
        [titles addObject:title];
    }
    titleRectM.colors = colors;
    titleRectM.titles = titles;
    self.titlRectChart.titleRectM = titleRectM;
    
}

-(void)tapGestureRecogizer:(UITapGestureRecognizer*)tapGesture
{
  
}
#pragma mark - UISrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [scrollView setNeedsDisplay];
}

@end




