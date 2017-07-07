//
//  define.h
//  ICoo
//
//  Created by JuniorKey on 16/7/23.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//

#ifndef define_h
#define define_h

//#define __DEBUG                         1
#define kTimeLineType                   @"时间线个数"
#define kServerAddressType              @"服务器地址"
#define kScreenWidth                    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight                   [UIScreen mainScreen].bounds.size.height
#define kStatusBarHeight                [UIApplication sharedApplication].statusBarFrame.size.height
#define kSystemVersion                  [[[UIDevice currentDevice]systemVersion]floatValue]
#define kIOS_VERSION_10_OR_ABOVE        [[[UIDevice currentDevice]systemVersion]floatValue] >= 10.0 ? YES : NO
#define kIOS_VERSION_BELOW_10           [[[UIDevice currentDevice]systemVersion]floatValue] < 10.0 ? YES : NO
#define IS_IPAD                         [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define IS_IPHONE                       [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define IS_IPHONE_4                     (fabs((double)kScreenHeight - (double )480) < DBL_EPSILON )
#define IS_IPHONE_5                     (fabs((double)kScreenHeight - (double )568) < DBL_EPSILON )
#define IS_IPHONE_6                     (fabs((double)kScreenHeight - (double )667) < DBL_EPSILON )
#define IS_IPHONE_6_PLUS                (fabs((double)kScreenHeight - (double )736) < DBL_EPSILON )
#define IS_IPHONE_7                     IS_IPHONE_6
#define IS_IPHONE_7_PLUS                IS_IPHONE_6_PLUS
#define kIphone4Height                  480
#define kIphone5Height                  568
#define kIphone6Height                  667
#define kIphone6plusHeight              736
#define kScaleLen                       5  //刻度值的长度
#define kDivisor                        10000

#define ICooUserDefaults                [NSUserDefaults standardUserDefaults]
#define ICooNotificationCenter          [NSNotificationCenter defaultCenter]
#define ICooSharedApplication           [UIApplication sharedApplication]
#define ICooKeyWindonw                  ICooSharedApplication.keyWindow
#define kServerAddressKey               @"http://192.168.199.135:9000"
#define kTimeLineCountKey               @"kTimeLineCountKey"
#define kICooService                    @"kICooService"

#define kAutoLoginState                 @"kAutoLoginState"
#define kAutoLoginYes                   @"kAutoLoginYes"
#define kAutoLoginNo                    @"kAutoLoginNo"

#define kLoinAccount                    @"kLoinAccount"
#define kConvertColor(value)            value/255
#define kBarChartDirectionRight         @"right"
#define kBarChartDirectionUp            @"up"
#define kChartDefault                   @"kChartDefault"
#define kDegreeToRadian(degree)         degree * M_PI/180
#define kRadianToDegree(radian)         radian * 180/M_PI

#define kServerLists                    @"kServerLists"
#define kAccountLists                   @"kAccountLists"

#define kTableHeaderNotifiTableDetail   @"kTableHeaderNotifiTableDetail"

#define kAccRoleClerk                   @"clerk"
#define kAccRoleClerkManager            @"clerkManager"
#define kAccRoleBoss                    @"boss"
#define kAccRoleAdmin                   @"admin"
#define kAccRoleTreasurer               @"treasurer"
#define kAccRoleTreasurerManager        @"treasurerManager"
#define kAccRolePurchase                @"purchase"
#define kAccRolePurchaseManager         @"purchaseManager"

#define kTableChartPreIndexStr          @"[i:"
#define kScrenScale                     [UIScreen mainScreen].bounds.size.width/320.0
#define DEBUG_MODE 1
#ifdef DEBUG_MODE
#define XLLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define XLLog( s, ... )
#endif

#define kColorWithRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define  kBlackColor            [UIColor blackColor]
#define  kDarkGrayColor         [UIColor darkGrayColor]
#define  kLightGrayColor        [UIColor lightGrayColor]
#define  kWhiteColor            [UIColor whiteColor]
#define  kGrayColor             [UIColor grayColor]
#define  kRedColor              [UIColor redColor]
#define  kGreenColor            [UIColor greenColor]
#define  kBlueColor             [UIColor blueColor]
#define  kCyanColor             [UIColor cyanColor]
#define  kYellowColor           [UIColor yellowColor]
#define  kMagentaColor          [UIColor magentaColor]
#define  kOrangeColor           [UIColor orangeColor]
#define  kPurpleColor           [UIColor purpleColor]
#define  kBrownColor            [UIColor brownColor]
#define  kClearColor            [UIColor clearColor]
#define  kBeryBlueColor         [UIColor colorWithRed:156/255.0 green:209/255.0 blue:220/255.0 alpha:1]
#define  kBrazilRedColor        [UIColor colorWithRed:212/255.0 green:130/255.0 blue:100/255.0 alpha:1]
#define  kDeepBrazilRedColor    [UIColor colorWithRed:215/255.0 green:82/255.0 blue:78/255.0 alpha:1]
#define  kBlancBlueColor        [UIColor colorWithRed:51/255.0 green:122/255.0 blue:182/255.0 alpha:1]
#define  kBuffYellowColor       [UIColor colorWithRed:240/255.0 green:173/255.0 blue:78/255.0 alpha:1]
#define  kLightBuffYellowColor  [UIColor colorWithRed:252/255.0 green:248/255.0 blue:227/255.0 alpha:1]
#define  kLightGreenColor       [UIColor colorWithRed:50/255.0 green:194/255.0 blue:77/255.0 alpha:1]
#define  kNaviBKColor           [UIColor colorWithRed:0.0 green:153/255.0 blue:204/255.0 alpha:1]

#define  kCGBlack               (CGCOLOR){0,0,0,255}
#define  kCGLightBlack          (CGCOLOR){0,0,0,50}
#define  kCGBlueColor           (CGCOLOR){0,0,255,255}
#define  kCGRedColor            (CGCOLOR){255,0,0,255}
#define  kCGGreenColor          (CGCOLOR){0,255,0,255}
#define  kCGLightBlue           (CGCOLOR){46,199,201,255}
#define  kCGMindColor           (CGCOLOR){220,150,50,255}
#define  kCGlightPurpleColor    (CGCOLOR){182,162,222,20}
#define  kCGPurpleColor         (CGCOLOR){182,162,222,255}
#define  kCGLightBlueColor      (CGCOLOR){238,238,238,255}
#define  kCGLightGrayColor      (CGCOLOR){0xed,0xed,0xed,100}
#define  kCGGrayColor           (CGCOLOR){0xed,0xed,0xed,255}
#define  kCGBeryBlueColor       (CGCOLOR){156,209,220,255}

#define kSystemFontSize9BlackColor      @{NSFontAttributeName:[UIFont systemFontOfSize:9],NSForegroundColorAttributeName:kBlackColor}
#define kBoldFontSize9LightGrayColor    @{NSFontAttributeName:[UIFont boldSystemFontOfSize:9],NSForegroundColorAttributeName:kLightGrayColor}
#define kSystemFontSize9WhiteColor      @{NSFontAttributeName:[UIFont systemFontOfSize:9],NSForegroundColorAttributeName:kWhiteColor}
#define kSystemFontSize10BlackColor     @{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:kBlackColor}
#define kBoldFontSize10LightGrayColor   @{NSFontAttributeName:[UIFont boldSystemFontOfSize:10],NSForegroundColorAttributeName:kLightGrayColor}
#define kBoldFontSize10LightWhiteColor  @{NSFontAttributeName:[UIFont boldSystemFontOfSize:10],NSForegroundColorAttributeName:kWhiteColor}
#define kSystemFontSize10WhiteColor     @{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:kWhiteColor}

#define kSystemFontSize11BlackColor     @{NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName:kBlackColor}
#define kSystemFontSize11LightGrayColor @{NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName:kLightGrayColor}
#define kSystemFontSize11WhiteColor     @{NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName:kWhiteColor}
#define kBoldFontSize11BlackColor       @{NSFontAttributeName:[UIFont boldSystemFontOfSize:11],NSForegroundColorAttributeName:kBlackColor}
#define kBoldFontSize11WhiteColor       @{NSFontAttributeName:[UIFont boldSystemFontOfSize:11],NSForegroundColorAttributeName:kWhiteColor}
#define kBoldFontSize11LightGrayColor   @{NSFontAttributeName:[UIFont boldSystemFontOfSize:11],NSForegroundColorAttributeName:kLightGrayColor}

#define kSystemFontSize12BlackColor     @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:kBlackColor}
#define kBoldFontSize12RedColor         @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12],NSForegroundColorAttributeName:kRedColor}
#define kBoldFontSize12LightGrayColor   @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12],NSForegroundColorAttributeName:kLightGrayColor}
#define kBoldFontSize12BlackColor       @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12],NSForegroundColorAttributeName:kBlackColor}
#define kBoldFontSize12CyanColor        @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12],NSForegroundColorAttributeName:kCyanColor}
#define kBoldFontSize12WhiteColor       @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12],NSForegroundColorAttributeName:kWhiteColor}
#define kSystemFontSize12WhiteColor     @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:kWhiteColor}
#define kSystemFontSize12WhiteColor     @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:kWhiteColor}

#define kSystemFontSize13BlackColor     @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:kBlackColor}
#define kBoldFontSize13LightGrayColor   @{NSFontAttributeName:[UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName:kLightGrayColor}
#define kSystemFontSize13WhiteColor     @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:kWhiteColor}
#define kBoldFontSize13BlackColor       @{NSFontAttributeName:[UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName:kBlackColor}
#define kBoldFontSize13WhiteColor       @{NSFontAttributeName:[UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName:kWhiteColor}
#define kBoldFontSize13RedColor         @{NSFontAttributeName:[UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName:kRedColor}


#define kSystemFontSize15BlackColor     @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:kBlackColor}
#define kSystemFontSize15WhiteColor     @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:kWhiteColor}
#define kBoldFontSize15BlackColor       @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName:kBlackColor}
#define kBoldFontSize15WhiteColor       @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName:kWhiteColor}
#define kBoldFontSize15LightGrayColor   @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName:kLightGrayColor}

#define XLAddMethodImTemplate(methodName)                           \
-(NSMutableArray*)methodName                                        \
{                                                                   \
if(!_##methodName) _##methodName = [[NSMutableArray alloc]init];    \
return _##methodName;                                               \
}                                                                   \


#define TICK                    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define TOCK                    NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start);

typedef NS_ENUM(NSUInteger,SegmentType){
    SegmentType_Line                    = 0,        // 选中的时候最下边是根线
    SegmentType_Badge,                              //
    SegmentType_ImageTitle,                         //上边是图片，下边是文字
};

typedef NS_ENUM(NSUInteger,SegmentScrollDirection){
    SegmentScrollDirection_Horizontal  = 0,         // 分类试图水平滚动
    SegmentScrollDirection_Vertical,                // 分类是垂直滚动
};

typedef struct _SegmentProperty {
    SegmentType             sType;                  // 分类试图水平滚动
    SegmentScrollDirection  sDirection;             // 分类是垂直滚动
}SegmentProperty;

typedef NS_ENUM(NSUInteger,ChartZoomType){
    ChartZoomTypeNormal                 = 0,        //正常
    ChartZoomTypeDeflate,                           //缩小
};

typedef NS_ENUM(NSUInteger,EBarChartType){
    barChartType_DirectionUp            = 0,        //柱状图方向向上
    barChartType_DirectionRight,                    //柱状图方向向右
} ;

typedef NS_ENUM(NSUInteger,PieChartType){
    PieChartType_TitleRectHorizontal    = 0,         //
    PieChartType_TitleRectVertical,                  //饼图图方向向右
};

typedef NS_ENUM(NSUInteger,TableChartFooterBtnType){
    TableChartFooterBtnType_PrePageBtn        = 0,    // 上一页
    TableChartFooterBtnType_NextPageBtn,              // 下一页
};
typedef NS_ENUM(NSUInteger,TitleRectChartType){
    TitleRectChartType_Horizontal       = 0,         // 滚动条方向水平
    TitleRectChartType_Vertical,                     // 滚动条方向垂直
};

typedef NS_ENUM(NSUInteger,AxisChart_Type){
    AxisChart_top,                                  //上边的轴线
    AxisChart_bottom,                               //下边的轴线
    AxisChart_left,                                 //左边的轴线
    AxisChart_right,                                //右边的轴线
};

typedef NS_ENUM(NSInteger,LoginState) {              //登录状态
    Login_OnLine,
    Login_OffLine,
    AutoLogin_Yes,
    AutoLogin_No
};

//typedef NS_ENUM(NSInteger,AutoLoginState) {          //是否自动登录
//    AutoLogin_Yes,
//    AutoLogin_No
//};

#endif
