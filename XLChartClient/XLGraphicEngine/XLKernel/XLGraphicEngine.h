//
//  XLGraphicEngine.h
//  XLGraphicEngine
//
//  Created by JuniorKey on 16/8/29.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#define kScreenWidth                    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight                   [UIScreen mainScreen].bounds.size.height

#define kWrapType(type)                 __unsafe_unretained type

typedef struct tagRECT_F
{
    CGFloat   left;
    CGFloat   top;
    CGFloat   right;
    CGFloat   bottom;
    
}RECT_F,*PRECT_F;

typedef struct _CGCOLOR
{
    CGFloat     r;
    CGFloat     g;
    CGFloat     b;
    CGFloat     a;
}CGCOLOR;

typedef struct _LineProperty
{
    CGLineCap   lineCap;
    CGFloat     lineWidth;
    CGLineJoin  lineJoin;
    CGFloat*    dashs;                      // 虚线数组
    size_t      count;                      // 虚线的个数
    CGCOLOR     stroColor;
}LineProperty,*PLineProperty;

typedef struct _TextAttr
{
    NSInteger              fontSize;
}TextAttr,*PTextAttr;


typedef struct _CircleAttr
{
    int                     circleType;      // 0 实心，1 空心
    int                     radius;          // 半径
    CGCOLOR                 fillColor;       // 填充颜色
    CGCOLOR                 strokColor;      // 绘制颜色
}CircleAttr,*PCircleAttr;

typedef enum _ArrowDirection
{
    arrowDirection_up      = 1,             //箭头向上
    arrowDirection_down,
    arrowDirection_left,
    arrowDirection_right,
}ArrowDirection;

typedef struct _ArrowAttr
{
    CGCOLOR                 strokColor;
    CGFloat                 lineWidth;
    CGLineCap               arrowCap;
    CGLineJoin              arrowJoin;
    CGFloat*                dashs;          // 虚线数组
    size_t                  count;          // 虚线的个数
    int                     radius;
    ArrowDirection          arrowDirection; //箭头方向
}ArrowAttr,*PArrowAttr;

typedef struct _RectangleAttr
{
    CGCOLOR                 strokColor;
    CGCOLOR                 fillColor;
    CGCOLOR                 bkColor;
    CGFloat                 lineWidth;
}RectangleAttr,*PRectangleAttr;

typedef struct _RoundRectangleAttr
{
    RectangleAttr           rectangleAttr;
    CGFloat                 radius;
}RoundRectangleAttr,*PRoundRectangleAttr;

@interface XLGraphicEngine : NSObject

/** 画图的上下文 */
@property (nonatomic,assign) CGContextRef   ctx;
/**
 *  画一条直线
 *
 * @param startPoint  开始点
 *
 * @param endPoint  结束点
 *
 * @param propery  线条的属性 nil时使用默认的
 *
 * @return nil
 */
-(void)mDrawLineStartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint LineProperty:(PLineProperty)pPropery;
/**
 *  画一条直线
 *
 * @param startPoint  开始点
 *
 * @param endPoint  结束点
 *
 * @param strokeColor  绘制的颜色
 *
 * @return nil
 */
-(void)mDrawLineStartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint strokeColor:(CGCOLOR)strokeColor;
/**
 *  增加一条直线（注意不是画在设备上，与直接画在设备上存在像素偏差）
 *
 * @param telphone  开始点
 *
 * @param password  结束点
 *
 * @param propery  线条的属性 nil时使用默认的
 *
 * @return nil
 */
-(void)mAddLineStartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint LineProperty:(PLineProperty)pPropery;

/**
 *  画千分位文字
 *
 * @param text  将要画千分位文字
 *
 * @param point  显示的位置
 *
 * @param textAttr  文本属性 nil时使用默认的
 *
 * @return nil
 *
 * @see
 * @see
 */
-(void)mDrawDecimalText:(NSString* )text Point:(CGPoint)point textAttr:(NSDictionary*)textAttr;
/**
 *  画文字
 *
 * @param text  将要画的文字
 *
 * @param point  显示的位置
 *
 * @param textAttr  文本属性 nil时使用默认的
 *
 * @return nil
 *
 * @see
 * @see
 */
-(void)mDrawText:(NSString*)text Point:(CGPoint)point textAttr:(NSDictionary*)textAttr;
/**
 *  根据某个字符串的属性计算字符串的大学
 *
 * @param str  将要计算的字符串
 *
 * @param textAttr  文本属性 nil时使用默认的
 *
 * @return nil
 *
 * @see
 * @see
 */
-(CGSize)mCalcuateTextSizeText:(NSString*)str textAttr:(NSDictionary*)textAttr;
/**
 *  绘制圆
 *
 * @param point  绘制的位置
 *
 * @param circAttrs  绘制的属性 nil时使用默认的
 *
 * @return nil
 *
 * @see
 * @see
 */
-(void)mDrawCirclePoint:(CGPoint)point circleAttrs:(PCircleAttr)circAttr;
/**
 *  画一根直线带上箭头
 *
 * @param startPoint  箭头开始点
 *
 * @param endPoint  箭头结束点
 *
 * @param arrowAttr  箭头属性 nil时使用默认的
 *
 * @return nil
 *
 * @see
 * @see
 */

-(void)mDrawArrowStartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint arrowAttr:(PArrowAttr)arrowAttr;
/**
 *  画一个普通的矩形
 *
 * @param rect  矩形范围
 *
 * @param pRectaAttr  矩形属性 nil时使用默认的
 *
 * @return 如果验证成功还回true,否则false
 *
 * @see
 * @see
 */

-(void)mDrawRectangle:(CGRect)rect RectangleAttr:(PRectangleAttr)pRectaAttr;
/**
 *  填充一个一个普通的矩形
 *
 * @param point  绘制的位置
 *
 * @param circAttrs  绘制的属性 nil时使用默认的
 *
 * @return nil
 *
 * @see
 * @see
 */
-(void)mFillRectangle:(CGRect)rect RectangleAttr:(PRectangleAttr)pRectaAttr;
/**
 *  画一个圆角矩形
 *
 * @param rect  矩形范围
 *
 * @param pRoundRectaAttr  圆角继续属性 nil时使用默认的
 *
 * @return 如果验证成功还回true,否则false
 *
 * @see
 * @see
 */
-(void)mDrawRoundRectangle:(CGRect)rect RoundRectangleAttr:(PRoundRectangleAttr)pRoundRectaAttr;
/**
 *  填充一个圆角矩形
 *
 * @param rect  矩形范围
 *
 * @param pRoundRectaAttr  圆角继续属性 nil时使用默认的
 *
 * @param uFillColor  填充颜色
 * @see
 * @see
 */
-(void)mFillRoundRectangle:(CGRect)rect RoundRectangleAttr:(PRoundRectangleAttr)pRoundRectaAttr fillColor:(UIColor*)uFillColor;
/**
 *  填充一个三角形
 *
 * @param fPoint  第一个点
 *
 * @param sPoint  第二个点
 *
 * @param tPoint  第三个点
 *
 * @param uFillColor  填充颜色
 * @see
 */
-(void)mFillTriangle:(CGPoint)fPoint secondPoint:(CGPoint)sPoint thirdPoint:(CGPoint)tPoint fillColor:(UIColor*)uFillColor;
/**
 *  画一个向上的气泡
 *
 * @param point  绘制的位置
 *
 * @param text  显示的文字
 *
 * @return nil
 *
 * @see
 * @see
 */
-(void)mDrawBuddle:(CGPoint)point text:(NSString*)text;

/**
 *  将UIColor转换为CGCOLOR
 *
 * @param color  将要转换的颜色
 *
 * @return nil

 */
-(CGCOLOR)UIColorConvertCGColor:(UIColor*)color;


-(NSMutableArray*)mGetInsidePointsCenter:(CGPoint)centerP Radius:(CGFloat)radius hitPoints:(NSArray*)points;

-(ArrowAttr)defaultArrowAttr;
-(LineProperty)defaultLineProperty;
-(CircleAttr)defaultCircleAttr;
-(RectangleAttr)defaultRectangleAttr;

@end

