//
//  FullScreenTransiontAnimator.h
//  TestAnimal
//
//  Created by FlyOceanFish on 2018/5/14.
//  Copyright © 2018年 FlyOceanFish. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface FullScreenTransiontAnimator : NSObject<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>
@property (nonatomic,strong)NSIndexPath *indexPath;
@end
