//
//  XLQuadrantButton.m
//  XLGraphicEngine
//
//  Created by JuniorKey on 16/8/29.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//

#import "XLQuadrantButton.h"
#import "XLGraphicEngine.h"

@interface XLQuadrantButton ()
{
    XLGraphicEngine*    _pGraphicEngine ;
}
@end
@implementation XLQuadrantButton
-(instancetype)initWithFrameAndAdd:(CGRect)frame SuperView:(UIView*)superView action:(SEL)action
{
    self = [super initWithFrame:frame];
    self.center = CGPointMake(frame.origin.x, frame.origin.y);
    self.layer.masksToBounds = NO;
    //[self addTarget:superView action:action forControlEvents:UIControlEventTouchUpInside];
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.cornerRadius = frame.size.width/2;
    self.layer.borderWidth = frame.size.width/2;
    [superView addSubview:self];
    return self;
}

-(void)drawRect:(CGRect)rect
{
  
}
@end
