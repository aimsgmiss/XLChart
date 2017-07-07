//
//  XLTableCellM.h
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/18/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "XLBaseM.h"


@interface XLTableCellM : XLBaseM
/** 存放一行数据的数组*/
@property (nonatomic,strong) NSMutableArray* items;
/**  矩形范围*/
@property (nonatomic,assign) CGRect rect;
/**  是否被选中*/
@property (nonatomic,assign) BOOL selected;
/**  选中的背景颜色*/
@property (nonatomic,strong) UIColor* selectedBackgroundColor;
/**  背景颜色*/
@property (nonatomic,strong) UIColor* bkColor;

-(NSString*)getItemNameIndex:(NSInteger)index;
@end

@interface XLTableCellMs : XLBaseM
/**  选中的背景颜色*/
@property (nonatomic,strong) NSMutableArray* headers;
/**  存放XLTableCellM的数组*/
@property (nonatomic,strong) NSMutableArray* tableCellMs;
@end
