//
//  XLTableChartHeader.h
//  ICoo
//
//  Created by JuniorKey on 10/9/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLBaseChart.h"

@protocol XLTableChartHeaderDelegate <NSObject>
-(void)didSelectedTableChartHeaderIndex:(NSUInteger)index asending:(BOOL)asending;
@end
@interface XLTableChartHeader : XLBaseChart

/**  */
@property (nonatomic,retain) NSArray* tableCellWidths;
/**  标题栏高度*/
@property (nonatomic,assign) CGFloat headerHeight;
/**  标题栏的宽度*/
@property (nonatomic,assign) CGFloat headerWidth;
/** header代理 */
@property (nonatomic,weak) id<XLTableChartHeaderDelegate> tableChartHeaderDelegate;
@end
