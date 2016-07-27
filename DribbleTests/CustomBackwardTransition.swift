//
//  CustomBackwardTransition.swift
//  Dribble
//
//  Created by 王笛 on 16/7/21.
//  Copyright © 2016年 王笛iOS.Inc. All rights reserved.
//

import UIKit

class CustomBackwardTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! DetailViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! ViewController
        let container = transitionContext.containerView()
        
        let snapshotView = fromVC.view.snapshotViewAfterScreenUpdates(false)
        let snapshotLabel = fromVC.detailLabel.snapshotViewAfterScreenUpdates(false)
        snapshotView.frame = container!.convertRect(fromVC.detailImage.frame, fromView: fromVC.view)
        snapshotLabel.frame = container!.convertRect(fromVC.detailLabel.frame, fromView: fromVC.view)
        fromVC.detailImage.hidden = true
        fromVC.detailLabel.hidden = true
        
        toVC.view.frame = transitionContext.finalFrameForViewController(toVC)
        toVC.selectedCell.cellImage.hidden = true
        toVC.selectedCell.cellLabel.hidden = true
        
        container!.insertSubview(toVC.view, belowSubview: fromVC.view)
        container!.addSubview(snapshotView)
        //container!.addSubview(snapshotLabel)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            snapshotView.frame = container!.convertRect(toVC.selectedCell.cellImage.frame, fromView: toVC.selectedCell)
            snapshotLabel.frame = container!.convertRect(toVC.selectedCell.cellLabel.frame, fromView: toVC.selectedCell)
            fromVC.view.alpha = 0
        }) { (finish: Bool) -> Void in
            toVC.selectedCell.cellImage.hidden = false
            toVC.selectedCell.cellLabel.hidden = false
            snapshotLabel.removeFromSuperview()
            snapshotView.removeFromSuperview()
            fromVC.detailImage.hidden = false
            fromVC.detailLabel.hidden = false
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
    
}
