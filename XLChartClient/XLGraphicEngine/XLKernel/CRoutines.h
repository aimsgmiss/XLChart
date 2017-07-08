//
//  CRoutines.h
//  ICoo
//
//  Created by JuniorKey on 16/7/26.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CRoutines : NSObject

NS_ASSUME_NONNULL_BEGIN
+(NSString*)stringFromFormatterStyle:(NSNumberFormatterStyle)style number:(NSNumber*)number;

+(NSString*)stringFromDate:(NSDate*)date;

+(UIColor*)getUIColorFromUColorsAtIndex:(NSUInteger)index;

+(NSDictionary*)jsonFromData:(id)responseId;

NS_ASSUME_NONNULL_END
@end
