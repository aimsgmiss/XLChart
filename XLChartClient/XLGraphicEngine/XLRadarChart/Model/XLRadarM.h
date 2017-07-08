//
//  XLRadarM.h
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/8/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XLBaseM.h"

@interface XLRadarM : XLBaseM
/**  分类的名字*/
@property (nonatomic,copy) NSString* category;
/**  雷达项*/
@property (nonatomic,strong) NSMutableArray* items;
/**  原始的数据*/
@property (nonatomic,strong) NSMutableArray* originData;
/**  每一项的百分比*/
@property (nonatomic,strong) NSMutableArray* percent;
/**  填充颜色*/
@property (nonatomic,strong) UIColor* fillColor;
@end

@interface XLRadarMs : NSObject

@end
