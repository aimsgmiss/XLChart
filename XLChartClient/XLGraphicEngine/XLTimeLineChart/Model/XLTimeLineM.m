//
//  XLTimeLineM.m
//  ICoo
//
//  Created by JuniorKey on 9/23/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLTimeLineM.h"

@implementation XLTimeLineM

/*- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if ([property.name isEqualToString:@"publisher"]) {
        if (oldValue == nil) return @"";
    } else if (property.type.typeClass == [NSDate class]) {
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        return [fmt dateFromString:oldValue];
    }
    
    return oldValue;
}*/

@end


@implementation XLTimeLineMs
XLAddMethodImTemplate(timeLineMs)

@end
