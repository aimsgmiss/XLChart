//
//  XLQuadrantButton.h
//  XLGraphicEngine
//
//  Created by JuniorKey on 16/8/29.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLQuadrantButton : UIButton
-(instancetype)initWithFrameAndAdd:(CGRect)frame SuperView:(UIView*)superView action:(SEL)action;
@end
