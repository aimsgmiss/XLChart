//
//  CRoutines.h
//  ICoo
//
//  Created by JuniorKey on 16/7/26.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRoutines : NSObject

NS_ASSUME_NONNULL_BEGIN
/**
 *  验证电话号码是否合法
 *
 * @param telphone  电话号码
 *
 * @return 如果验证成功还回true,否则false
 */
+(BOOL)mTelNumberIsValid:(NSString *)telphone;
/**
 *  验证密码是否合法
 *
 * @param telphone  电话号码
 *
 * @return 如果验证成功还回true,否则false
 */
+(BOOL)mPasswordIsValid:(NSString*)password;

/**
 *  验证电话号码和密码
 *
 * @param telphone  电话号码
 *
 * @param password  密码
 *
 * @return 如果验证成功还回true,否则false
 *
 * @see
 * @see 
 */
+(BOOL)mTelNumber:(NSString*)telphone PasswordIsValid :(NSString*)password;



/**
 *  显示AlertView
 *
 * @param title  标题
 *
 * @param message  详细信息
 *
 * @param controller  在那个试图控制进行跳转
 *
 * @param OkHandler  确认按钮处理
 *
 * @param CancHandler 取消按钮处理
 *
 * @param completion  完成之后
 *
 * @return 如果验证成功还回true,否则false
 *
 * @see
 * @see
 */
+(void)showAlertViewWithTitle:(NSString*)title Message:(NSString*)message InController:(UIViewController*) controller withOkActionHandler:(void(^)(UIAlertAction* action))okHandler CancelActionHandler:(void(^)(UIAlertAction* action))cancHandler Completion:(void (^ __nullable)(void))completion;
/**
 *  显示AlertView
 *
 * @param title  标题
 *
 * @param message  详细信息
 *
 * @param controller  在那个试图控制进行跳转
 *
 * @param okHandler  确认按钮处理
 *
 * @param cancHandler 取消按钮处理
 *
 * @return 如果验证成功还回true,否则false
 
 * @see
 * @see
 */
+(void)showAlertViewWithTitle:(NSString*)title Message:(NSString*)message InController:(UIViewController*)controller withOkActionHandler:(void(^ __nullable)(UIAlertAction* action))okHandler CancelActionHandler:(void(^ __nullable)(UIAlertAction* action))cancHandler;

/**
 *  将number格式为百分比，科学技术法等
 *
 * @param style  格式化样式
 *
 * @param number  格式化的数字
 * @return 格式化的字符串
 *
 * @see
 * @see
 */
+(NSString*)stringFromFormatterStyle:(NSNumberFormatterStyle)style number:(NSNumber*)number;
/**
 *  将日期转换为字符串
 *
 * @param date  被转化的日期
 *
 * @return 字符串
 *
 * @see
 * @see
 */
+(NSString*)stringFromDate:(NSDate*)date;
/**
 *  换回一个颜色
 *
 * @param index  索引
 *
 * @return UIColor对象
 *
 * @see
 * @see
 */
+(UIColor*)getUIColorFromUColorsAtIndex:(NSUInteger)index;
/*准备播放动画**/
+(void)prepareVisibleCellsForAnimation:(UITableView*) tableView;
/*开始播放动画**/
+(void)animateVisibleCells:(UITableView*) tableView;
/** 将data转换为字典*/
+(NSDictionary*)jsonFromData:(id)responseId;
/**  将密码保存在钥匙串中*/
+(BOOL)mSaveTelphonePasswordToKeyChainPassword:(NSString*)password account:(NSString*)account;
/**  根据账号删除密码*/
+(BOOL)mDeletePasswordFromKeyChainAccount:(NSString*)account;

/** 中文和英文角色转换数组*/
+(NSDictionary*)chineseEnglishRoleKeyValues;
NS_ASSUME_NONNULL_END
@end
