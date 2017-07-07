//
//  XLPopupChartM.h
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/14/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//


#import "XLBaseM.h"
#import "define.h"
#import "XLGraphicEngine.h"

@interface XLPopupChartM : XLBaseM
{
    @public
    /// 画实心圆填充的颜色
    CGCOLOR             _circleFillColor;
}
@property (nonatomic,copy) NSString* titleName;

@property (nonatomic,copy) NSString* detialName1;

@property (nonatomic,copy) NSString* detialName2;
/**  字体属性*/
@property (nonatomic,strong) NSDictionary* fontAttr;
/**  内容属性*/
@property (nonatomic,strong) NSDictionary* contentDic;
/**  触发的店*/
@property (nonatomic,assign) CGPoint touchPoint;
@end
