//
//  XLSegmentView.m
//  XLGraphicEngine
//
//  Created by JuniorKey on 16/8/31.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//

#import "XLSegmentChart.h"
#import "XLGraphicEngine.h"


#define    kVerticalLineW       2
#define    kHorizontalLinH      kVerticalLineW
#define    kVLineAndBtnMargin   2           //按钮和竖线的间距
#define    kHorLineAndBtnMargin 2           //按钮与水平线的间距
#define    kBtnW                20
#define    kBtnDefaultColor     [UIColor brownColor]
#define    kBtnSelectedColor    [UIColor colorWithRed:0 green:1 blue:0.8 alpha:1]

@interface XLSegmentChart()
{
    XLGraphicEngine*        _pGraphicEngine;
    SegmentType             _segmentType;
    /// 滚动方向
    SegmentScrollDirection  _segmScrollDirec;
}
/** 保存每一项元素的数组 */
@property (nonatomic,strong) NSMutableArray* segmentItems;

@end

@implementation XLSegmentChart
XLAddMethodImTemplate(segmentItems);

-(instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame type:SegmentType_ImageTitle];
}

-(instancetype)initWithFrame:(CGRect)frame type:(SegmentType)sType
{
    return [self initWithFrame:frame type: sType segmScrollDirection:SegmentScrollDirection_Horizontal];
}
-(instancetype)initWithFrame:(CGRect)frame type:(SegmentType)sType segmScrollDirection:(SegmentScrollDirection)segmScrollDirection
{
    self = [super initWithFrame:frame];
    self.userInteractionEnabled = NO;
    _segmentType = sType;
    _segmScrollDirec = segmScrollDirection;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.topMargin = 10;
    self.bottomMargin = self.topMargin;
    return self;
}

-(void)initSegmentBadgeFrame:(CGRect)frame
{
    NSInteger           index;
    NSInteger           segmentCount;
    XLSegmentCell*      segmentCell;
    CGFloat             x;
    CGFloat             y;
    XLSegmentCellM*     segmentCellM;
    CGRect              rect;
    CGFloat             segmentCellW;
    CGFloat             segmentCellH;
    CGFloat             margin;
    CGSize              textSize;
    
    [self.segmentItems removeAllObjects];
    margin = 5;
    segmentCount = self.dataSource.count;
    segmentCellW = (frame.size.width - (segmentCount + 1) * margin)/segmentCount;
    segmentCellH = frame.size.height - 2;
    for (index = 0; index < segmentCount; index++) {
        segmentCellM = self.dataSource[index];
        if(index == 0)segmentCellM.selected = YES;
        textSize = [segmentCellM.name sizeWithAttributes:self.fontAttr];
        x = index * (segmentCellW + margin);
        rect = CGRectMake(x, 2, segmentCellW, segmentCellH);
        segmentCellM.outsideRect = CGRectMake(x, 2, segmentCellW, segmentCellH);
        segmentCellM.insideRect = CGRectMake(5, 15, segmentCellW - 5, segmentCellH - 17);
        segmentCell = [[XLSegmentCell alloc]initWithFrame:rect type:SegmentType_Badge];
        segmentCell.tag = index;
        segmentCell.segmentCellM = segmentCellM;
        [self addSubview:segmentCell];
        [self.segmentItems addObject:segmentCellM];
    }
}

-(void)initSegmentImageTitle:(CGRect)frame
{
    NSInteger           index;
    NSInteger           startIndex;
    NSInteger           segmentCount;
    XLSegmentCell*      segmentCell;
    CGFloat             x = 0.0;
    CGFloat             y;
    CGRect              rect;
    XLSegmentCellM*     segmentCellM;
    CGFloat             segmentChartW;
    CGFloat             segmentChartH;
    CGFloat             margin;
    CGFloat             cellWidth;
    CGFloat             cellHeight;
    NSInteger           maxNumber;
    NSInteger           count;
    
    margin = 5;
    segmentCount = self.dataSource.count;
    cellWidth = 60;
    cellHeight = 70;
    y = self.topMargin;
    maxNumber = 4;
    startIndex = 0;
    self.leftMargin = 20;
    index = 0;
    [self.segmentItems removeAllObjects];
    if (_segmScrollDirec == SegmentScrollDirection_Vertical) {
        segmentChartW = self.frame.size.width -  self.leftMargin * 2;
        while (true) {
            count = segmentCount / maxNumber;
            if (count > 0) count = maxNumber;
            else count = segmentCount % maxNumber;
            margin = (segmentChartW - maxNumber * cellWidth) / (maxNumber - 1);
            //if (startIndex == 0) margin = (segmentChartW - count * cellWidth) / (count - 1);
            //else margin = (segmentChartW - maxNumber * cellWidth) / (maxNumber - 1);
            for (index = 0; index < count; index++) {
                x = index * (cellWidth + margin) + self.leftMargin;
                rect = CGRectMake(x, y, cellWidth, cellHeight);
                segmentCell = [[XLSegmentCell alloc]initWithFrame:rect type:SegmentType_ImageTitle];
                segmentCell.segmentCellM = self.dataSource[startIndex];
                segmentCell.tag = startIndex++;
                [self addSubview:segmentCell];
            }
            segmentCount -= maxNumber;
            y += cellHeight + self.bottomMargin;
            if (segmentCount <= 0) break;
            
        }
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, y);
    }else if (_segmScrollDirec == SegmentScrollDirection_Horizontal){
        
        segmentChartW = self.frame.size.width -  self.leftMargin * 2;
        margin = (segmentChartW - maxNumber * cellWidth) / (maxNumber - 1);
        for (segmentCellM in self.dataSource) {
            x = index++ *( cellWidth + margin) + self.leftMargin;
            rect = CGRectMake(x, y, cellWidth, cellHeight);
            segmentCell = [[XLSegmentCell alloc]initWithFrame:rect type:SegmentType_ImageTitle];
            segmentCell.segmentCellM = self.dataSource[startIndex];
            segmentCell.tag = startIndex++;
            [self addSubview:segmentCell];
            [self.segmentItems addObject:segmentCell];
        }
        self.contentSize = CGSizeMake(x + cellWidth, cellHeight);
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width,  self.topMargin + cellHeight + self.bottomMargin);
    }
    
}

-(void)setBadgeNumbers:(NSArray *)badgeNumbers
{
    NSInteger           index;
    UIView*             subView;
    XLSegmentCell*      segmentCell;

    for (subView in self.subviews) {
        if ([subView isKindOfClass:[XLSegmentCell class]]) {
            segmentCell = (XLSegmentCell*)subView;
            segmentCell.segmentCellM.badgeNumber = [NSString stringWithFormat:@"%@",badgeNumbers[segmentCell.tag]];
            [segmentCell setNeedsDisplay];
        }
    }
    
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef     ctx;
    
    if(!_pGraphicEngine)
    {
        ctx = UIGraphicsGetCurrentContext();
        _pGraphicEngine = [[XLGraphicEngine alloc]init];
        _pGraphicEngine.ctx = ctx;
        _selectedIndex = 0;
    }
    switch (_segmentType) {
        case SegmentType_Line:
            [self drawSegmentLine:rect];
            break;
        case SegmentType_Badge:
            [self drawSegmentBadge:rect];
            break;
        case SegmentType_ImageTitle:
            [self drawSegmentImageTitle:rect];
            break;
        default:
            break;
    }

}

-(void)drawSegmentBadge:(CGRect)rect
{
   
}

-(void)drawSegmentLine:(CGRect)rect
{
    int                 index;
    CGFloat             x;
    CGFloat             btnW;
    CGFloat             btnH;
    UIButton*           btn;
    NSInteger           segmentCount;
    LineProperty        lineProperty;
    RectangleAttr       rectangleAttr;
    
    rectangleAttr = [_pGraphicEngine defaultRectangleAttr];
    rectangleAttr.strokColor = [_pGraphicEngine UIColorConvertCGColor:kBtnDefaultColor];
    segmentCount = _segmentTitles.count;
    if(segmentCount <= 0) return;
    btnW = (rect.size.width - (segmentCount - 1) *(kVerticalLineW + kVLineAndBtnMargin * 2))/segmentCount;
    btnH = rect.size.height - kHorizontalLinH - kHorLineAndBtnMargin * 2;
    lineProperty = [_pGraphicEngine defaultLineProperty];
    lineProperty.stroColor = (CGCOLOR){100,100,100,255};
    for (index = 0; index < segmentCount; index++)
    {
        x = index * (btnW + kVLineAndBtnMargin * 2 + kVerticalLineW);
        if(self.segmentItems.count < segmentCount)
        {
            btn = [[UIButton alloc]initWithFrame:CGRectMake(x , 0, btnW, btnH)];
            [btn setTitle:_segmentTitles[index] forState:UIControlStateNormal];
            btn.titleLabel.font = [self.fontAttr objectForKey:NSFontAttributeName];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            if(index == 0) [btn setBackgroundColor:kBtnSelectedColor];
            else [btn setBackgroundColor:kBtnDefaultColor];
            [self addSubview:btn];
            [self.segmentItems addObject:btn];
        }
        if(index != 0)[_pGraphicEngine mDrawLineStartPoint:CGPointMake(x - kVerticalLineW/2 - kVLineAndBtnMargin, 0) EndPoint:CGPointMake(x - kVerticalLineW/2 - kVLineAndBtnMargin, btnH) LineProperty:&lineProperty];
    }
   
    lineProperty.stroColor = (CGCOLOR){0,255,0,255};
    x = _selectedIndex * (btnW + kVerticalLineW * 2 + kVLineAndBtnMargin);
    lineProperty.stroColor = [_pGraphicEngine UIColorConvertCGColor:kBtnSelectedColor];
    [_pGraphicEngine mDrawLineStartPoint:CGPointMake(x, btnH + kHorLineAndBtnMargin*3/2) EndPoint:CGPointMake(x + btnW, btnH + kHorLineAndBtnMargin*3/2) LineProperty:&lineProperty];
    [_pGraphicEngine mDrawRectangle:CGRectMake(0, btnH ,rect.size.width, rect.size.height - btnH) RectangleAttr:&rectangleAttr
     ];
}

-(void)drawSegmentImageTitle:(CGRect)rect
{
    LineProperty        lineProperty;
    
    lineProperty = [_pGraphicEngine defaultLineProperty];
    lineProperty.lineWidth = 2;
    lineProperty.stroColor = [_pGraphicEngine UIColorConvertCGColor:kLightGrayColor];
    [_pGraphicEngine mDrawLineStartPoint:CGPointMake(rect.origin.x, 2) EndPoint:CGPointMake(rect.origin.x + rect.size.width, 2) LineProperty:&lineProperty];
    [_pGraphicEngine mDrawLineStartPoint:CGPointMake(rect.origin.x, rect.size.height - 2) EndPoint:CGPointMake(rect.origin.x + rect.size.width, rect.size.height - 2) LineProperty:&lineProperty];
}
-(void)setDataSource:(NSMutableArray *)dataSource
{
    if (dataSource.count <= 0) return;
    [self.dataSource removeAllObjects];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [super setDataSource:dataSource];
    switch (_segmentType) {
        case SegmentType_Line:
            
            break;
        case SegmentType_Badge:
            [self initSegmentBadgeFrame:self.frame];
            break;
        case SegmentType_ImageTitle:
            [self initSegmentImageTitle:self.frame];
            break;
        default:
            break;
    }
}


-(void)btnClicked:(UIButton*)sender
{
    int                 index;
    UIButton*           btn;
    
    for (index = 0; index < self.segmentItems.count; index++)
    {
        btn = [self.segmentItems objectAtIndex:index];
        if (btn == sender)
        {
            _selectedIndex = index;
            if ([_segmentDelegate respondsToSelector:@selector(segmentClicked:)]) {
                [_segmentDelegate segmentClicked:self];
            }
        }
        else [btn setBackgroundColor:kBtnDefaultColor];
    }
    [sender setBackgroundColor:kBtnSelectedColor];
    [self setNeedsDisplay];
}

-(void)tapGestureRecogizer:(UITapGestureRecognizer *)tapGesture
{
    CGPoint             touchPoint;
    XLSegmentCell*      segmentCell;
    UIView*             subView;
    
    touchPoint = [tapGesture locationInView:self];
    for (subView in self.subviews) {
        if ([subView isKindOfClass:[XLSegmentCell class]]) {
            segmentCell = (XLSegmentCell*)subView;
            if (CGRectContainsPoint(segmentCell.frame, touchPoint)) {
                _selectedSegmentCell = segmentCell;
                _selectedSegmentCell.selected = YES;
                _selectedIndex = _selectedSegmentCell.tag;
                if ([_segmentDelegate respondsToSelector:@selector(segmentClicked:)]) {
                    _selectedTitle = _selectedSegmentCell.segmentCellM.title;
                    [_segmentDelegate segmentClicked:self];
                }
                [_selectedSegmentCell setNeedsDisplay];
                break;
            }
        }
    }
    for (subView in self.subviews) {
        if ([subView isKindOfClass:[XLSegmentCell class]]) {
            segmentCell = (XLSegmentCell*)subView;
            if (_selectedSegmentCell != segmentCell){
                segmentCell.selected = NO;
                [segmentCell setNeedsDisplay];
            }
          
        }
    }
}

-(void)setSelectedIndex:(NSInteger)selectedIndex{
    
    XLSegmentCell*      segmentCell;
    
    _selectedIndex = selectedIndex;
    if (self.segmentItems.count > 0) {
        segmentCell = self.segmentItems[selectedIndex];
        segmentCell.selected = YES;
        _selectedSegmentCell = segmentCell;
        [segmentCell setNeedsDisplay];
    }
  
}
@end








