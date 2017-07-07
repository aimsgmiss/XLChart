//
//  XLBaseM.h
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/9/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLBaseM : NSObject<NSCopying>
-(id)copyWithZone:(NSZone *)zone;
@end

@interface XLBaseAxisM : XLBaseM
/**  服务器传过来的原始x方向数据*/
@property (nonatomic,copy) NSString* xAxisOriginData;
/**  服务器传过来的原始y方向数据*/
@property (nonatomic,copy) NSString* yAxisOriginData;

/**  存放上边x轴数据(刻度数据)*/
@property (nonatomic,strong) NSMutableArray* xTopAxisScaleDatas;
/**  存放下边x轴数据(刻度数据)*/
@property (nonatomic,strong) NSMutableArray* xBottomAxisScaleDatas;
/**  存放左边y轴数据(刻度数据)*/
@property (nonatomic,strong) NSMutableArray* yLeftAxisScaleDatas;
/**  存放右边y轴数据(刻度数据)*/
@property (nonatomic,strong) NSMutableArray* yRightAxisScaleDatas;

@end
