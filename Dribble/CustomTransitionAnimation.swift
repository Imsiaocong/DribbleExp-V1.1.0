//
//  CustomTransitionAnimation.swift
//  Dribble
//
//  Created by 王笛 on 16/7/3.
//  Copyright © 2016年 王笛iOS.Inc. All rights reserved.
//

import UIKit

class CustomTransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.9
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        //1st step: get the view controller
        let container = transitionContext.containerView()
        let fromView = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ViewController
        let toView = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! DetailViewController
        
        //snapshot
        let snapshotView = fromView.selectedCell.cellImage.snapshotViewAfterScreenUpdates(false)
        let snapshotLabel = fromView.selectedCell.cellLabel.snapshotViewAfterScreenUpdates(false)
        let snapshotDesc = fromView.selectedCell.descLabel.snapshotViewAfterScreenUpdates(false)
        snapshotView.frame = container!.convertRect(fromView.selectedCell.cellImage.frame, fromView: fromView.selectedCell)
        snapshotLabel.frame = container!.convertRect(fromView.selectedCell.cellLabel.frame, fromView: fromView.selectedCell)
        snapshotDesc.frame = container!.convertRect(fromView.selectedCell.descLabel.frame, fromView: fromView.selectedCell)
        fromView.selectedCell.cellImage.hidden = true
        fromView.selectedCell.cellLabel.hidden = true
        toView.detailLabel.hidden = true
        fromView.selectedCell.cellLabel.sizeToFit()
        
        //toView: Set its frame
        toView.view.frame = transitionContext.finalFrameForViewController(toView)//这段看起来没什么用，可删去.
        toView.view.alpha = 0
        
        //add views to container
        container?.addSubview(toView.view)
        container?.addSubview(snapshotView)
        container?.addSubview(snapshotLabel)
        container?.addSubview(snapshotDesc)
        
        //fix the frame of animation
        toView.detailImage.layoutIfNeeded()
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            snapshotDesc.alpha = 0
            snapshotDesc.frame = CGRect(x: 0, y: -1000, width: 92, height: 21)
            snapshotView.frame = toView.detailImage.frame
            snapshotLabel.frame = toView.detailLabel.frame
            toView.view.alpha = 1
        }) { (finish: Bool) in //设置动画结束后的情况.
            fromView.selectedCell.cellImage.hidden = false
            fromView.selectedCell.cellLabel.hidden = false
            toView.detailLabel.hidden = false
            toView.detailImage.image = toView.image
            toView.detailLabel.text = toView.label.text
            snapshotView.removeFromSuperview()
            snapshotLabel.removeFromSuperview()
            snapshotDesc.removeFromSuperview()
            //一定要记得动画完成后执行此方法，让系统管理 navigation
            transitionContext.completeTransition(true)
            UIView.animateWithDuration(1, animations: {
                toView.moveToOffSet()
            })
        }
    }
    
}
