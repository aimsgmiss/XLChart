//
//  XLBaseM.m
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/9/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLBaseM.h"

@implementation XLBaseM

-(id)copyWithZone:(NSZone *)zone
{
    XLBaseM*        baseM;
   
    baseM = [[[self class] allocWithZone:zone] init];
    return baseM;
}
@end

@implementation  XLBaseAxisM
XLAddMethodImTemplate(yLeftAxisScaleDatas)
XLAddMethodImTemplate(xBottomAxisScaleDatas)
XLAddMethodImTemplate(xTopAxisScaleDatas)
XLAddMethodImTemplate(yRightAxisScaleDatas)

-(id)copyWithZone:(NSZone *)zone
{
    XLBaseAxisM*    baseAxisM;
    
    baseAxisM = [super copyWithZone:zone];
    baseAxisM.xAxisOriginData = _xAxisOriginData;
    baseAxisM.yAxisOriginData = _yAxisOriginData;
    baseAxisM.xTopAxisScaleDatas = _xTopAxisScaleDatas;
    baseAxisM.xBottomAxisScaleDatas = _xBottomAxisScaleDatas;
    baseAxisM.yLeftAxisScaleDatas = _yLeftAxisScaleDatas;
    baseAxisM.yRightAxisScaleDatas = _yRightAxisScaleDatas;
    
    return baseAxisM;
    
}
/*
-(id)copyWithZone:(NSZone *)zone
{
    XLBaseAxisM*    baseAxisM;
    
    baseAxisM = [super copyWithZone:zone];
    baseAxisM.xAxisOriginData = [self.xAxisOriginData copy];
    baseAxisM.yAxisOriginData = [self.yAxisOriginData copy];
    baseAxisM.xTopAxisScaleDatas = (NSMutableArray*)[[NSMutableArray alloc]initWithArray:self.xTopAxisScaleDatas copyItems:YES];
    baseAxisM.xBottomAxisScaleDatas = (NSMutableArray*)[[NSMutableArray alloc]initWithArray:self.xBottomAxisScaleDatas copyItems:YES];
    baseAxisM.yLeftAxisScaleDatas = (NSMutableArray*)[[NSMutableArray alloc]initWithArray:self.yLeftAxisScaleDatas copyItems:YES];
    baseAxisM.yRightAxisScaleDatas = (NSMutableArray*)[[NSMutableArray alloc]initWithArray:self.yRightAxisScaleDatas copyItems:YES];
    return baseAxisM;
    
}*/
@end
