//
//  XLTableCellM.m
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/18/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLTableCellM.h"
#import <objc/runtime.h>
@implementation XLTableCellM

-(NSString *)getItemNameIndex:(NSInteger)index
{
    __block unsigned int    count;
    NSString*               propValue;
    const char*             propName;
    objc_property_t*        objcProperList;
    
    objcProperList = class_copyPropertyList([self class], &count);
    propName = property_getName(objcProperList[index]);
    propValue = [self valueForKey:[NSString stringWithFormat:@"%s",propName]];
    free(objcProperList);
    objcProperList = NULL;
    return propValue;
}

@end

@implementation XLTableCellMs



@end
