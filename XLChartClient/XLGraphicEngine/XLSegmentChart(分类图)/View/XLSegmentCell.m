//
//  XLSegmentCell.m
//  ICoo
//
//  Created by JuniorKey on 10/11/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLSegmentCell.h"

@implementation XLSegmentCell

-(void)setSelected:(BOOL)selected{
    
    [super setSelected:selected];
    self.segmentCellM.selected = selected;
}

-(instancetype)initWithFrame:(CGRect)frame type:(SegmentType)sType
{
    self = [super initWithFrame:frame];
    self.backgroundColor = kClearColor;
    _sementType = sType;
    return self;
}

-(void)drawRect:(CGRect)rect
{
   [super drawRect:rect];
    switch (_sementType) {
        case SegmentType_Badge:
            [self drawBadge:rect];
            break;
        case SegmentType_ImageTitle:
            [self drawImageTitle:rect];
            break;
        default:
            break;
    }
}

-(void)drawBadge:(CGRect)rect
{
    CGSize          textSize;
    NSString*       text;
    RectangleAttr   rectangleAttr;
    CGFloat         x;
    CGFloat         y;
    CircleAttr      circleAttr;
    CGFloat         height;
    CGCOLOR         strokeColor;
    LineProperty    lineProperty;
   
    rectangleAttr = [_pGraphicEngine defaultRectangleAttr];
    lineProperty = [_pGraphicEngine defaultLineProperty];
    if (_segmentCellM.selected) {
        rectangleAttr.strokColor = kCGRedColor;
        height = _segmentCellM.insideRect.size.height;
        x = _segmentCellM.insideRect.origin.x + _segmentCellM.insideRect.size.width - height/2;
        y = _segmentCellM.insideRect.origin.y + height;
        [_pGraphicEngine mAddLineStartPoint:CGPointMake(x, y) EndPoint:CGPointMake(x + height/2, y) LineProperty:nil];
        [_pGraphicEngine mFillTriangle:CGPointMake(x, y) secondPoint:CGPointMake(x + height/2, y) thirdPoint:CGPointMake(x + height/2, y - height/2) fillColor:kRedColor];
        x += height/8;
        y -= height/8;
        
        lineProperty.lineWidth = 1;
        strokeColor = [_pGraphicEngine UIColorConvertCGColor:kWhiteColor];
        lineProperty.stroColor = strokeColor;
        [_pGraphicEngine mDrawLineStartPoint:CGPointMake(x, y) EndPoint:CGPointMake(x + height/8, y + height/10) LineProperty:&lineProperty];
        [_pGraphicEngine mDrawLineStartPoint:CGPointMake(x + height/8, y + height/10) EndPoint:CGPointMake(x + height * 3/8, y - height * 1/6)  LineProperty:&lineProperty];
        
    }else{
        rectangleAttr.strokColor = kCGLightBlack;
    }
    text = _segmentCellM.name;
    textSize = [_pGraphicEngine mCalcuateTextSizeText:text textAttr:self.fontAttr];
    x = _segmentCellM.insideRect.size.width/2 - textSize.width/2;
    if (x <= 5) x = _segmentCellM.insideRect.origin.x;
    y = _segmentCellM.insideRect.size.height/2 - textSize.height/2 + _segmentCellM.outsideRect.size.height - _segmentCellM.insideRect.size.height;
    self.fontAttr = kBoldFontSize12BlackColor;
    [_pGraphicEngine mDrawText:text Point:CGPointMake(x, y) textAttr:self.fontAttr];
    [_pGraphicEngine mDrawRectangle:_segmentCellM.insideRect RectangleAttr:&rectangleAttr];
    if (_segmentCellM.badgeNumber.length > 0) {
        text = _segmentCellM.badgeNumber;
        self.fontAttr = kSystemFontSize12WhiteColor;
        textSize = [_pGraphicEngine mCalcuateTextSizeText:text textAttr:self.fontAttr];
        circleAttr = [_pGraphicEngine defaultCircleAttr];
        circleAttr.fillColor = kCGRedColor;
        circleAttr.radius = textSize.height * 3/4;
        x = _segmentCellM.insideRect.size.width - textSize.width/2;
        y = _segmentCellM.insideRect.origin.y - textSize.height/4;
        if (y <= 0) y = 0;
        [_pGraphicEngine mDrawCirclePoint:CGPointMake(x, y) circleAttrs:&circleAttr];
        [_pGraphicEngine mDrawText:text Point:CGPointMake(x - textSize.width/2, y - textSize.height/2) textAttr:self.fontAttr];
    }
}
-(void)drawImageTitle:(CGRect)rect
{
    CGSize          textSize;
    NSString*       text;
    CGFloat         x;
    CGFloat         y;
    CGFloat         height;
    UIImage*        image;
    UIImageView*    imageView;
    CGRect          rec;
    CircleAttr      circleAttr;
    
    x = 0;
    y = 0;
    if (_segmentCellM.imageName) {
        CGContextSaveGState(_pGraphicEngine.ctx);
        image = [UIImage imageNamed:_segmentCellM.imageName];
        rec = CGRectMake(x, y, rect.size.width, rect.size.height * 4/5);
        [[UIBezierPath bezierPathWithRoundedRect:rec cornerRadius:32] addClip];
        [image drawInRect:rec];
        CGContextRestoreGState(_pGraphicEngine.ctx);
        
    }
    self.selected = _segmentCellM.selected;
    if(_segmentCellM.selected) self.fontAttr = kBoldFontSize13RedColor;
    else self.fontAttr = kSystemFontSize12BlackColor;
    text = _segmentCellM.title;
    textSize = [_pGraphicEngine mCalcuateTextSizeText:text textAttr:self.fontAttr];
    x = rect.size.width/2 - textSize.width/2;
    if (x <= 5) x = 0;
    y = rect.size.height * 4/5;
    [_pGraphicEngine mDrawText:text Point:CGPointMake(x, y) textAttr:self.fontAttr];
    
    if (_segmentCellM.badgeNumber.length > 0) {
        text = _segmentCellM.badgeNumber;
        self.fontAttr = kSystemFontSize12WhiteColor;
        textSize = [_pGraphicEngine mCalcuateTextSizeText:text textAttr:self.fontAttr];
        circleAttr = [_pGraphicEngine defaultCircleAttr];
        circleAttr.fillColor = kCGRedColor;
        circleAttr.radius = textSize.height * 3/4;
        x = rect.origin.x + rect.size.width * 3/4;
        y = rect.origin.y + rect.size.height/4;
        [_pGraphicEngine mDrawCirclePoint:CGPointMake(x, y) circleAttrs:&circleAttr];
        [_pGraphicEngine mDrawText:text Point:CGPointMake(x - textSize.width/2, y - textSize.height/2) textAttr:self.fontAttr];
    }


}

@end




































