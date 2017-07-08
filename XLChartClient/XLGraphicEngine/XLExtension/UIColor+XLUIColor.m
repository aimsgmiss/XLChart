//
//  UIColor+XLUIColor.m
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/12/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "UIColor+XLUIColor.h"

@implementation UIColor (XLUIColor)
+(instancetype)randomColor
{
    UIColor*            color;
    CGFloat             r;
    CGFloat             g;
    CGFloat             b;
    CGFloat             a;
    
    r = rand()%255;
    g = rand()%255;
    b = rand()%255;
    a = rand()%255;
    color = [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:a/255];
    return color;
}
@end
