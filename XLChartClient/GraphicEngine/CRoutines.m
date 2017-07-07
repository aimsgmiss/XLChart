//
//  CRoutines.m
//  ICoo
//
//  Created by JuniorKey on 16/7/26.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//

#import "CRoutines.h"

@implementation CRoutines

+(BOOL)mTelNumber:(NSString*)telphone PasswordIsValid :(NSString*)password
{
    NSString*               pattern;
    NSPredicate*            pred;
    BOOL                    isTelphoneNumValid;
    BOOL                    isPasswordValid;
    
    if(telphone.length != 11) return false;
    pattern = @"^1+[3578]+\\d{9}";
    pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    isTelphoneNumValid = [pred evaluateWithObject:telphone];
    pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    isPasswordValid = [pred evaluateWithObject:password];
    return isTelphoneNumValid; //&& isPasswordValid;
}

+(BOOL)mTelNumberIsValid:(NSString *)telphone
{
    NSString*               pattern;
    NSPredicate*            pred;

    pattern = @"^1+[3578]+\\d{9}";
    pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
   return [pred evaluateWithObject:telphone];
}

+(BOOL)mPasswordIsValid:(NSString*)password
{
    NSString*               pattern;
    NSPredicate*            pred;
    
    pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
     return [pred evaluateWithObject:password];
}

+(NSArray*)itemIndexesWithPattern:(NSString*)pattern inString:(NSString*)inStr{
    
    NSRegularExpression*    regExp;
    NSError*                error;
    NSArray*                result;
    
    NSAssert(pattern != nil, @"%s:",__PRETTY_FUNCTION__);
    NSAssert(inStr != nil, @"%s:",__PRETTY_FUNCTION__);
    regExp = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    result = [regExp matchesInString:inStr options:NSMatchingReportCompletion range:NSMakeRange(0, [inStr length])];
    
    return result;
}
+(void)mMessageBox:(NSString*)message Delegate:(nullable id)target hudMode:(MBProgressHUDMode)mode
{
    [self mMessageBox:message Delegate:target hudMode:mode Completion:nil];
}

+(void)mMessageBox:(NSString*)message Delegate:(nullable id)target hudMode:(MBProgressHUDMode)mode Completion:( nullable void (^)())completion{
    MBProgressHUD*      hud;
    
    if(!target)
    {
        hud = [MBProgressHUD showHUDAddedTo:ICooKeyWindonw animated:YES];
        [hud mSetDelegate:ICooKeyWindonw backgroundColor:nil detailText:message dimBackground:YES];
    }
    else
    {
        hud = [MBProgressHUD showHUDAddedTo:((UIViewController*)target).view animated:YES];
        [hud mSetDelegate:target backgroundColor:nil detailText:message dimBackground:YES];
    }
    hud.mode = mode;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
        if (completion) {
            completion();
        }
    });
   
}

+(void)showAlertViewWithTitle:(NSString*)title Message:(NSString*)message InController:(UIViewController*) controller withOkActionHandler:(void(^ __nullable)(UIAlertAction* action))okHandler CancelActionHandler:(void(^ __nullable)(UIAlertAction* action))cancHandler
{
    [CRoutines showAlertViewWithTitle:title Message:message InController:controller withOkActionHandler:okHandler CancelActionHandler:cancHandler Completion:nil];
}

+(void)showAlertViewWithTitle:(NSString*)title Message:(NSString*)message InController:(UIViewController*) controller withOkActionHandler:(void(^)(UIAlertAction* action))okHandler CancelActionHandler:(void(^)(UIAlertAction* action))cancHandler Completion:(void (^ __nullable)(void))completion
{
    UIAlertController*          alertContr;
    UIAlertAction*              okAction;
    UIAlertAction*              cancelAction;
    
    alertContr = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:okHandler];
    cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:cancHandler];
    [alertContr addAction:okAction];
    [alertContr addAction:cancelAction];
    [controller presentViewController:alertContr animated:YES completion:completion];
}

+(NSString *)stringFromFormatterStyle:(NSNumberFormatterStyle)style number:(NSNumber*)number
{
    NSNumberFormatter*            formatter;
    
    formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = style;
    return   [formatter stringFromNumber:number];
}

+(NSString*)stringFromDate:(NSDate*)date
{
    NSDateFormatter*            formatter;
    
    formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    return [formatter stringFromDate:date];
}

+(UIColor*)getUIColorFromUColorsAtIndex:(NSUInteger)index
{
    NSArray*            uColors;
    
    uColors = @[kBrownColor,kGreenColor,kMagentaColor,kRedColor,kBlueColor,kGrayColor,kPurpleColor,kYellowColor,kOrangeColor,kCyanColor,kDarkGrayColor,kBrownColor,kBeryBlueColor,kBrazilRedColor,kDeepBrazilRedColor,kBlancBlueColor,kBuffYellowColor,kLightBuffYellowColor,kLightGreenColor,kNaviBKColor];
    if (index >=  (uColors.count - 1)) return kBlackColor;
    return uColors[index];
}

#pragma mark animation
+(void)prepareVisibleCellsForAnimation:(UITableView*) tableView{
    
    int                 i;
    UITableViewCell*    cell;
    
    for (i = 0; i < tableView.visibleCells.count; i++) {
        cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.frame = CGRectMake(-CGRectGetWidth(cell.bounds), cell.frame.origin.y,CGRectGetWidth(cell.bounds), CGRectGetHeight(cell.bounds));
        cell.alpha = 0.f;
    }
}

+(void)animateVisibleCells:(UITableView*) tableView{
    
    int                 i;
    UITableViewCell*    cell;
    
    for (i = 0; i < [tableView.visibleCells count]; i++) {
        cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        cell.alpha = 1.f;
        [UIView animateWithDuration:0.25f
                              delay:i * 0.1
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             cell.frame = CGRectMake(0.f, cell.frame.origin.y, CGRectGetWidth(cell.bounds), CGRectGetHeight(cell.bounds));
                         }
                         completion:nil];
    }
}

+(NSDictionary*)jsonFromData:(id)responseId{
    
    NSError*        error;
    NSDictionary*   dic;
    
    dic =  [NSJSONSerialization JSONObjectWithData:responseId options:NSJSONReadingMutableContainers error:&error];
    if (error) assert(false);
    return dic;
}

#pragma mark key chain
+(BOOL)mSaveTelphonePasswordToKeyChainPassword:(NSString*)password account:(NSString*)account
{
    NSError*                error;
    
    [SSKeychain setPassword:password forService:kICooService account:account error:&error];
    return TRUE;
}

+(BOOL)mDeletePasswordFromKeyChainAccount:(NSString*)account
{
    NSError*                error;
    NSArray*                allAcount;
    
    allAcount = [SSKeychain allAccounts];
    [allAcount enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([account isEqualToString:obj[@"acct"]]) {
            [SSKeychain deletePasswordForService:kICooService account:account error:nil];
        }
    }];
    
    return TRUE;
}



+(NSDictionary*)chineseEnglishRoleKeyValues{
    
    return @{
                 @"采购员" : kAccRolePurchase,
                 @"采购主管": kAccRolePurchaseManager,
                 @"财务员": kAccRoleClerk,
                 @"财务主管": kAccRoleClerkManager,
                 @"业务员": kAccRoleClerk,
                 @"业务主管": kAccRoleClerkManager,
                 @"老板":kAccRoleBoss,
                 @"管理员" : kAccRoleAdmin
        };
}
@end







