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
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if self.type == .Present {
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            let toVCfinalFrame = transitionContext.finalFrame(for: toVC!)
            let fromVCfinalFrame = transitionContext.finalFrame(for: fromVC!)
            print(toVCfinalFrame)
            print(fromVCfinalFrame)
            fromVC?.view.transform = CGAffineTransform.identity
            let containerView = transitionContext.containerView
            containerView.addSubview(toVC!.view)
            if let navVC = toVC as? UINavigationController {
                navVC.navigationBar.frame = CGRect(x: 0, y: -64, width: navVC.navigationBar.frame.size.width, height: navVC.navigationBar.frame.size.height)
                if let detailVC = navVC.viewControllers[0] as? DetailViewController {
                    detailVC.bottomView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: detailVC.bottomView.frame.size.width, height: detailVC.bottomView.frame.size.height)
                }
            }
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
                fromVC?.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                if let navVC = toVC as? UINavigationController {
                    navVC.navigationBar.frame = CGRect(x: 0, y: 0, width: navVC.navigationBar.frame.size.width, height: navVC.navigationBar.frame.size.height)
                    
                    if let detailVC = navVC.viewControllers[0] as? DetailViewController {
                        detailVC.bottomView.frame = CGRect(x: 0, y: 439, width: detailVC.bottomView.frame.size.width, height: detailVC.bottomView.frame.size.height)
                    }
                }
                
                }) { (_) -> Void in
                    transitionContext.completeTransition(true)
            }
        }
        if self.type == .Dismiss {
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            let toVCfinalFrame = transitionContext.finalFrame(for: toVC!)
            let fromVCfinalFrame = transitionContext.finalFrame(for: fromVC!)
            print(toVCfinalFrame)
            print(fromVCfinalFrame)
            toVC?.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
            let containerView = transitionContext.containerView
            containerView.addSubview(toVC!.view)
            containerView.addSubview(fromVC!.view)
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { () -> Void in
                toVC?.view.transform = CGAffineTransform.identity
                if let navVC = fromVC as? UINavigationController {
                    navVC.navigationBar.frame = CGRect(x: 0, y: -64, width: navVC.navigationBar.frame.size.width, height: navVC.navigationBar.frame.size.height)
                    
                    if let detailVC = navVC.viewControllers[0] as? DetailViewController {
                        detailVC.bottomView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: detailVC.bottomView.frame.size.width, height: detailVC.bottomView.frame.size.height)
                        detailVC.imageView.frame = CGRect(x: detailVC.imageView.frame.origin.x + 10, y: detailVC.imageView.frame.origin.y + 10, width: detailVC.imageView.frame.size.width - 20, height: detailVC.imageView.frame.size.height - 20)
                    }
                }
                
                }, completion: { (_) -> Void in
                    transitionContext.completeTransition(true)
            }) 
        }

    }
}
