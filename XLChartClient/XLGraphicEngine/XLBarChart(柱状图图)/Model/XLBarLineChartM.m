//
//  XLBarChartM.m
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/13/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLBarLineChartM.h"

@implementation XLBarLineChartM
-(id)copyWithZone:(NSZone *)zone
{
    XLBarLineChartM*        barCharM;
    
    barCharM = [super copyWithZone:zone];
    barCharM.rect = _rect;
    barCharM.backgroundRect = _backgroundRect;
    barCharM.rect2 = _rect2;
    barCharM.rect3 = _rect3;
    barCharM.name = _name;
    barCharM.number = _number;
    barCharM.number2 = _number2;
    barCharM.number3 = _number3;
    barCharM.backgoundNumber = _backgoundNumber;
    barCharM.lineNumber = _lineNumber;
    barCharM.prePoint = _prePoint;
    barCharM.preBarCharLineM = _preBarCharLineM;
    barCharM.suffixPoint = _suffixPoint;
    barCharM.suffixBarCharLineM = _suffixBarCharLineM;
    
    return barCharM;
}
/*-(id)copyWithZone:(NSZone *)zone
{
    XLBarLineChartM*        barCharM;
    
    barCharM = [super copyWithZone:zone];
    barCharM.rect = self.rect;
    barCharM.backgroundRect = self.backgroundRect;
    barCharM.rect2 = self.rect2;
    barCharM.rect3 = self.rect3;
    barCharM.name = [self.name copy];
    barCharM.number = [self.number copy];
    barCharM.number2 = [self.number2 copy];
    barCharM.number3 = [self.number3 copy];
    barCharM.backgoundNumber = [self.backgoundNumber copy];
    
    barCharM.lineNumber = [self.lineNumber copy];
    barCharM.prePoint = self.prePoint;
    barCharM.preBarCharLineM = [self.preBarCharLineM copy];
    barCharM.suffixPoint = self.suffixPoint;
    barCharM.suffixBarCharLineM = [self.suffixBarCharLineM copy];
    return barCharM;
}*/
@end

@implementation XLBarLineChartMs
XLAddMethodImTemplate(barChartMs)

-(id)copyWithZone:(NSZone *)zone
{
    XLBarLineChartMs*       barCharMs;
    
    barCharMs = [super copyWithZone:zone];
    barCharMs.barChartMs = (NSMutableArray*)[[NSArray alloc]initWithArray:self.barChartMs copyItems:YES];;
    barCharMs.type = _type;
    barCharMs.title = _title;
    return barCharMs;
}


@end
