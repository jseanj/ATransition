//
//  ATransition.swift
//  ATransition
//
//  Created by jin.shang on 16/1/23.
//  Copyright © 2016年 jin.shang. All rights reserved.
//

import UIKit

enum SegueType: String {
    case Present
    case Dismiss
}

class ATransition: NSObject, UIViewControllerAnimatedTransitioning {
    var type: SegueType
    
    init(type: SegueType) {
        self.type = type
        super.init()
    }
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if self.type == .Present {
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            let toVCfinalFrame = transitionContext.finalFrameForViewController(toVC!)
            let fromVCfinalFrame = transitionContext.finalFrameForViewController(fromVC!)
            print(toVCfinalFrame)
            print(fromVCfinalFrame)
            fromVC?.view.transform = CGAffineTransformIdentity
            let containerView = transitionContext.containerView()
            containerView?.addSubview(toVC!.view)
            if let navVC = toVC as? UINavigationController {
                navVC.navigationBar.frame = CGRectMake(0, -64, navVC.navigationBar.frame.size.width, navVC.navigationBar.frame.size.height)
                if let detailVC = navVC.viewControllers[0] as? DetailViewController {
                    detailVC.bottomView.frame = CGRectMake(0, UIScreen.mainScreen().bounds.height, detailVC.bottomView.frame.size.width, detailVC.bottomView.frame.size.height)
                }
            }
            UIView.animateWithDuration(self.transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                fromVC?.view.transform = CGAffineTransformMakeScale(0.8, 0.8)
                if let navVC = toVC as? UINavigationController {
                    navVC.navigationBar.frame = CGRectMake(0, 0, navVC.navigationBar.frame.size.width, navVC.navigationBar.frame.size.height)
                    
                    if let detailVC = navVC.viewControllers[0] as? DetailViewController {
                        detailVC.bottomView.frame = CGRectMake(0, 439, detailVC.bottomView.frame.size.width, detailVC.bottomView.frame.size.height)
                    }
                }
                
                }) { (_) -> Void in
                    transitionContext.completeTransition(true)
            }
        }
        if self.type == .Dismiss {
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            let toVCfinalFrame = transitionContext.finalFrameForViewController(toVC!)
            let fromVCfinalFrame = transitionContext.finalFrameForViewController(fromVC!)
            print(toVCfinalFrame)
            print(fromVCfinalFrame)
            toVC?.view.transform = CGAffineTransformMakeScale(0.9, 0.9)
            
            let containerView = transitionContext.containerView()
            containerView?.addSubview(toVC!.view)
            containerView?.addSubview(fromVC!.view)
            UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
                toVC?.view.transform = CGAffineTransformIdentity
                if let navVC = fromVC as? UINavigationController {
                    navVC.navigationBar.frame = CGRectMake(0, -64, navVC.navigationBar.frame.size.width, navVC.navigationBar.frame.size.height)
                    
                    if let detailVC = navVC.viewControllers[0] as? DetailViewController {
                        detailVC.bottomView.frame = CGRectMake(0, UIScreen.mainScreen().bounds.height, detailVC.bottomView.frame.size.width, detailVC.bottomView.frame.size.height)
                        detailVC.imageView.frame = CGRectMake(detailVC.imageView.frame.origin.x + 10, detailVC.imageView.frame.origin.y + 10, detailVC.imageView.frame.size.width - 20, detailVC.imageView.frame.size.height - 20)
                    }
                }
                
                }) { (_) -> Void in
                    transitionContext.completeTransition(true)
            }
        }

    }
}