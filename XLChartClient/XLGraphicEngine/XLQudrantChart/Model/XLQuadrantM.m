//
//  XLQuadrantModel.m
//  XLGraphicEngine
//
//  Created by JuniorKey on 16/9/1.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//

#import "XLQuadrantM.h"

@interface XLQuadrantM ()

@end

@implementation XLQuadrantM
-(id)copyWithZone:(NSZone *)zone{
    
    XLQuadrantM*        quadrantM;
    
    quadrantM = [super copyWithZone:zone];
    quadrantM.name = [self.name copy];
    quadrantM.xAxisData = self.xAxisData;
    quadrantM.yAxisData = self.yAxisData;
    quadrantM.trend = self.trend;
    quadrantM.rectM = self.rectM;
    
    return quadrantM;
}
@end

@implementation XLQuadrantMS
XLAddMethodImTemplate(quadrantMs)

-(id)copyWithZone:(NSZone *)zone{
    
    XLQuadrantMS*       quadrantMs;
    
    quadrantMs = [super copyWithZone:zone];
    quadrantMs.quadrantMs = (NSMutableArray*)[[NSMutableArray alloc]initWithArray:self.quadrantMs copyItems:YES];
    
    return quadrantMs;
}

@end

