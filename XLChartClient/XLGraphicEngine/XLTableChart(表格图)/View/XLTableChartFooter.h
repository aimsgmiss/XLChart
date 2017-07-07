//
//  XLTableChartFooter.h
//  ICoo
//
//  Created by JuniorKey on 3/15/17.
//  Copyright © 2017 my.JuniorKey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLBaseChart.h"

@protocol XLTableChartFooterDelegate <NSObject>
-(void)didSelectedTableChartFooterBtnType:(TableChartFooterBtnType)btnType;
@end
@interface XLTableChartFooter : XLBaseChart
/** footer代理*/
@property (nonatomic,weak) id<XLTableChartFooterDelegate> tableChartFooterDelegate;
@end
