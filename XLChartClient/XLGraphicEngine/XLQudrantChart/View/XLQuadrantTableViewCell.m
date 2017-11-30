//
//  XLQuadrantTableViewCell.m
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/8/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "XLQuadrantTableViewCell.h"
#import "XLQuadrantArrowLabel.h"


@interface XLQuadrantTableViewCell ()

@property (weak, nonatomic) IBOutlet XLQuadrantArrowLabel *arrowLabel;

@property (weak, nonatomic) IBOutlet UILabel *textStrLabel;

@end
@implementation XLQuadrantTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self setNeedsDisplay];
    // Configure the view for the selected state
}

-(void)setQModel:(XLQuadrantM *)qModel
{
    if (_qModel != qModel) {
        _qModel = qModel;
        self.textStrLabel.text = _qModel.name;
        self.arrowLabel.trend = _qModel.trend;
    }
}
@end
