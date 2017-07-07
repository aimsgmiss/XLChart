//
//  XLTableChartFooter.m
//  ICoo
//
//  Created by JuniorKey on 3/15/17.
//  Copyright © 2017 my.JuniorKey. All rights reserved.
//

#import "XLTableChartFooter.h"

@interface XLTableChartFooter()
/** 上一页按钮*/
@property (nonatomic,strong) UIButton* previousPageBtn;
/** 下一页按钮*/
@property (nonatomic,strong) UIButton* nextPageBtn;
@end
@implementation XLTableChartFooter

-(instancetype)initWithFrame:(CGRect)frame zoomType:(ChartZoomType)zoomType
{
    self = [super initWithFrame:frame zoomType:zoomType];
    self.userInteractionEnabled = YES;
    _previousPageBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 40, 20)];
    [_previousPageBtn setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [_previousPageBtn addTarget:self action:@selector(pageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_previousPageBtn];
    _nextPageBtn = [[UIButton alloc]initWithFrame:CGRectMake(60, 5, 40, 20)];
    [_nextPageBtn setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    [_nextPageBtn addTarget:self action:@selector(pageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.backgroundColor = [UIColor colorWithRed:kCGLightBlue.r/255.0f green:kCGLightBlue.g/255.0f blue:kCGLightBlue.b/255.0f alpha:1];
    [self addSubview:_nextPageBtn];
    return self;
}

-(void)pageBtnClick:(UIButton*)sender{
    
    TableChartFooterBtnType         btnType;
    
    if (sender == _previousPageBtn) btnType = TableChartFooterBtnType_PrePageBtn;
    else if(sender == _nextPageBtn) btnType = TableChartFooterBtnType_NextPageBtn;
    if ([self.tableChartFooterDelegate respondsToSelector:@selector(didSelectedTableChartFooterBtnType:)]) {
        [self.tableChartFooterDelegate didSelectedTableChartFooterBtnType:btnType];
    }
}
@end
