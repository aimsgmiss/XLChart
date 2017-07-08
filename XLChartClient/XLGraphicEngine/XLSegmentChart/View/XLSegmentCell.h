//
//  XLSegmentCell.h
//  ICoo
//
//  Created by JuniorKey on 10/11/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLBaseChart.h"
#import "XLSegmentCellM.h"

@interface XLSegmentCell : XLBaseChart
{
    SegmentType     _sementType;
}
/**  segmentCell模型*/
@property (nonatomic,strong) XLSegmentCellM* segmentCellM;

-(instancetype)initWithFrame:(CGRect)frame type:(SegmentType)sType;
@end
