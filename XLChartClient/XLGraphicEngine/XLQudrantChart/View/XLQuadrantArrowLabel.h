//
//  XLQuadrantArrowLabel.h
//  XLGraphicEngine
//
//  Created by JuniorKey on 9/8/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLGraphicEngine.h"

@interface XLQuadrantArrowLabel : UILabel
  
@property (nonatomic,strong) XLGraphicEngine*   _pGraphicEngine;

@property (nonatomic,assign) NSInteger trend;

@end
