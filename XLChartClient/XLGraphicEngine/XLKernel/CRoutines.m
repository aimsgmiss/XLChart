//
//  CRoutines.m
//  ICoo
//
//  Created by JuniorKey on 16/7/26.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//

#import "CRoutines.h"
#import "define.h"
@implementation CRoutines

+(NSString *)stringFromFormatterStyle:(NSNumberFormatterStyle)style number:(NSNumber*)number
{
    NSNumberFormatter*            formatter;
    
    formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = style;
    return   [formatter stringFromNumber:number];
}

+(NSString*)stringFromDate:(NSDate*)date
{
    NSDateFormatter*            formatter;
    
    formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    return [formatter stringFromDate:date];
}

+(UIColor*)getUIColorFromUColorsAtIndex:(NSUInteger)index
{
    NSArray*            uColors;
    
    uColors = @[kBrownColor,kGreenColor,kMagentaColor,kRedColor,kBlueColor,kGrayColor,kPurpleColor,kYellowColor,kOrangeColor,kCyanColor,kDarkGrayColor,kBrownColor,kBeryBlueColor,kBrazilRedColor,kDeepBrazilRedColor,kBlancBlueColor,kBuffYellowColor,kLightBuffYellowColor,kLightGreenColor,kNaviBKColor];
    if (index >=  (uColors.count - 1)) return kBlackColor;
    return uColors[index];
}

+(NSDictionary*)jsonFromData:(id)responseId
{
    NSError*        error;
    NSDictionary*   dic;
    
    dic =  [NSJSONSerialization JSONObjectWithData:responseId options:NSJSONReadingMutableContainers error:&error];
    if (error) assert(false);
    return dic;
}

@end







