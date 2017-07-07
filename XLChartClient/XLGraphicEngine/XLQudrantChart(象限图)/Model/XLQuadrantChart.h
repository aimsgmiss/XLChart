//
//  XLQuadrantChart.h
//  XLGraphicEngine
//
//  Created by JuniorKey on 16/8/29.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLBaseChart.h"
#import "XLQuadrantM.h"

@protocol XLQuadrantChartDelegate <NSObject>

@optional
/**  点击某个点附近某个范围的点*/
-(void)clickedNearbyContianPoints:(NSArray*)insidePoints;
@end

@interface XLQuadrantChart:XLBaseAxisChart
{

}
/**  点击小黑点按钮的代理*/
@property (nonatomic,weak) id<XLQuadrantChartDelegate> xlQuadrantDelegate;
/** */
@property (nonatomic,copy) XLQuadrantMS* quadrantMs;
@end
