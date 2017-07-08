//
//  XLSegmentCellM.h
//  ICoo
//
//  Created by JuniorKey on 10/11/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLBaseM.h"
#import <CoreGraphics/CoreGraphics.h>

@interface XLSegmentCellM : XLBaseM
/**  是否被选中*/
@property (nonatomic,assign) BOOL selected;
 /**  SegmentType_Badge*/
/**  提示数量*/
@property (nonatomic,copy) NSString* badgeNumber;
/**  类型名称*/
@property (nonatomic,copy) NSString* name;
/**  外边矩形*/
@property (nonatomic,assign) CGRect outsideRect;
/**  内边矩形*/
@property (nonatomic,assign) CGRect insideRect;

/**  SegmentType_ImageTitle*/
/**  图片的名称*/
@property (nonatomic,copy) NSString* imageName;
/**  标题名称*/
@property (nonatomic,copy) NSString* title;
@end
