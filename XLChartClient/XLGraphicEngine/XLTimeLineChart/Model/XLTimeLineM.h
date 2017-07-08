//
//  XLTimeLineM.h
//  ICoo
//
//  Created by JuniorKey on 9/23/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLBaseM.h"
#import <CoreGraphics/CoreGraphics.h>
@interface XLTimeLineM : XLBaseM
/**  0:出库，1:入库 ,2:没有发生过库存交易*/
@property (nonatomic,copy) NSString* type;
/**  出入库数量*/
@property (nonatomic,copy) NSString* qty;
/**  出入库时间的库存数量*/
@property (nonatomic,copy) NSString* inventoryQty;
/**  出入库时间*/
@property (nonatomic,strong) NSDate* date;
/**  XLTimeM的矩形范围*/
@property (nonatomic,assign) CGRect rect;

@end

@interface XLTimeLineMs : XLBaseM
/**  存放XLTimeLineM模型数组*/
@property (nonatomic,strong) NSMutableArray* timeLineMs;
/**  当前库存数量*/
@property (nonatomic,assign) NSInteger currentQty;
/**  最近days天数的出入库情况*/
@property (nonatomic,assign) NSInteger days;
/**  单位*/
@property (nonatomic,copy) NSString* unit;
@end
