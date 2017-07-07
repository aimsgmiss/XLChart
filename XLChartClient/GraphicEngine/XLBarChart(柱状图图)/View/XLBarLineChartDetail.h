//
//  XLBarChartDetail.h
//  ICoo
//
//  Created by JuniorKey on 9/30/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLBaseChart.h"
#import "XLBarLineChartM.h"
@interface XLBarChartDetail : XLBaseAxisChart
/**  每个cell的宽度*/
@property (nonatomic,assign) CGFloat cellWidth;
/**  每个cell的宽度*/
@property (nonatomic,assign) CGFloat cellHeight;
/**  父试图左边距*/
@property (nonatomic,assign) CGFloat superViewLeftAxisMargin;
/**  */
@property (nonatomic,copy) XLBarLineChartMs* barChartMs;
/** x轴线在y轴中点 将y轴分为上半轴，下半轴*/
@property (nonatomic,assign) BOOL xAxisInYAxisMiddle;
@end
