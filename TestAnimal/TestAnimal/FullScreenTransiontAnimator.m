//
//  FullScreenTransiontAnimator.m
//  TestAnimal
//
//  Created by FlyOceanFish on 2018/5/14.
//  Copyright © 2018年 FlyOceanFish. All rights reserved.
//

#import "FullScreenTransiontAnimator.h"
#import "MyTableViewCell.h"

@interface FullScreenTransiontAnimator()
{
    id<UIViewControllerContextTransitioning> _transitionContext;
}
@end
@implementation FullScreenTransiontAnimator
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    _transitionContext = transitionContext;
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    
    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    BOOL isPush = ([toViewController.navigationController.viewControllers indexOfObject:toViewController] > [fromViewController.navigationController.viewControllers indexOfObject:fromViewController]);
    
    [containerView addSubview:toView];
    if (isPush) {
        fromView.alpha = 0.5;
        toView.alpha = 0;
        UITableView *table = fromView.subviews[0];
        UITableViewCell *cell = [table cellForRowAtIndexPath:self.indexPath];
        float height = CGRectGetHeight(cell.frame);
        float width = CGRectGetWidth(cell.frame);
        float screenHeight = CGRectGetHeight(containerView.frame);
        float screenwidth = CGRectGetWidth(containerView.frame);
        UIView *snapshot = [cell snapshotViewAfterScreenUpdates:NO];
        snapshot.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y-table.contentOffset.y, width, height);
        [containerView addSubview:snapshot];

        
        CABasicAnimation *animal = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
        animal.fromValue = @(1);
        animal.toValue = @(screenHeight/width);
        
        CABasicAnimation *animal3 = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
        animal3.fromValue = @(1);
        animal3.toValue = @(screenwidth/height);
        
        CABasicAnimation *animal2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animal2.fromValue = @(0);
        animal2.toValue = @(M_PI_2);
        
        CABasicAnimation *animal4 = [CABasicAnimation animationWithKeyPath:@"position"];
        animal4.fromValue = @(snapshot.frame.origin);
        animal4.toValue = @(CGPointMake(screenwidth, 0));
        
        CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
        group.animations = @[animal,animal2,animal3,animal4];
        
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = NO;
        group.duration = 0.3;
        group.repeatCount = 1;
        group.delegate = self;
        snapshot.layer.anchorPoint = CGPointMake(0, 0);
        [snapshot.layer addAnimation:group forKey:@""];
        [UIView animateWithDuration:1 animations:^{
            fromView.alpha = 0;
            toView.alpha = 1;
        } completion:^(BOOL finished) {
            [snapshot removeFromSuperview];
            BOOL canceled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!canceled];
        }];
    }else{
        float screenHeight = CGRectGetHeight(containerView.frame);
        float screenwidth = CGRectGetWidth(containerView.frame);
        UIView *iv = fromView.subviews[0];
        iv = [iv snapshotViewAfterScreenUpdates:NO];
        CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_2);
        iv.transform = transform;
        iv.frame = CGRectMake(0, 0, screenwidth, screenHeight);
        
        fromView.alpha = 1;
        toView.alpha = 0;
        UITableView *table = toView.subviews[0];
        UITableViewCell *cell = [table cellForRowAtIndexPath:self.indexPath];

        [containerView addSubview:iv];
        float height = CGRectGetHeight(cell.frame);
        float width = CGRectGetWidth(cell.frame);
        
        CABasicAnimation *animal = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
        animal.fromValue = @(1);
        animal.toValue = @(width/screenHeight);
        
        CABasicAnimation *animal3 = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
        animal3.fromValue = @(1);
        animal3.toValue = @(height/screenwidth);
        
        CABasicAnimation *animal4 = [CABasicAnimation animationWithKeyPath:@"position"];
        animal4.fromValue = @(CGPointMake(iv.frame.origin.x, iv.frame.origin.y));
        animal4.toValue = @(CGPointMake(cell.frame.origin.x+width/2.0, (cell.frame.origin.y-table.contentOffset.y)+height/2.0+44-20));
        
        CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
        group.animations = @[animal,animal3,animal4];
        
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = NO;
        group.duration = 0.3;
        group.repeatCount = 1;
        group.delegate = self;
        [UIView animateWithDuration:0.3 animations:^{
            CGAffineTransform transform2 = CGAffineTransformRotate(transform, -M_PI_2);
            iv.transform = transform2;
        }];
        [iv.layer addAnimation:group forKey:@""];
        [UIView animateWithDuration:1 animations:^{
            toView.alpha = 1;
        } completion:^(BOOL finished) {
            [iv removeFromSuperview];
            BOOL canceled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!canceled];
        }];
    }

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    //    BOOL canceled = [_transitionContext transitionWasCancelled];
    //    [_transitionContext completeTransition:!canceled];
}
@end
