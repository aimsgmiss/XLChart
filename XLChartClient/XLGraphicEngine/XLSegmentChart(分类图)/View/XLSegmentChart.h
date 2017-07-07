//
//  XLSegmentView.h
//  XLGraphicEngine
//
//  Created by JuniorKey on 16/8/31.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLBaseChart.h"
#import "XLSegmentCell.h"
#import "XLSegmentCellM.h"

@class XLSegmentChart;
@protocol XLSegmentViewDelegate <NSObject>
-(void)segmentClicked:(XLSegmentChart*)sender;
@end
@interface XLSegmentChart : XLBaseChart
/** 分割线的title */
@property (nonatomic,strong) NSArray* segmentTitles;
/** 当前被选中按钮的索引*/
@property (nonatomic,assign) NSInteger selectedIndex;
/** 当前选中的标题*/
@property (nonatomic,copy) NSString* selectedTitle;
/**  消息条的个数*/
@property (nonatomic,strong) NSArray* badgeNumbers;
/** 分割试图的代理 */
@property (nonatomic,weak) id <XLSegmentViewDelegate> segmentDelegate;
/** 选中的cell */
@property (nonatomic,strong)XLSegmentCell* selectedSegmentCell;

-(instancetype)initWithFrame:(CGRect)frame type:(SegmentType)sType;
-(instancetype)initWithFrame:(CGRect)frame type:(SegmentType)sType segmScrollDirection:(SegmentScrollDirection)segmScrollDirection;
@end
