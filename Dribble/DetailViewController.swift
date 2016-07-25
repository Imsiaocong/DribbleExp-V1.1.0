//
//  DetailViewController.swift
//  Dribble
//
//  Created by 王笛 on 16/7/3.
//  Copyright © 2016年 王笛iOS.Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate, UINavigationControllerDelegate {
    
    var detailImage = UIImageView()
    var detailLabel = UILabel()
    //@IBOutlet weak var detailView: UIView!
    var image: UIImage!
    var label: UILabel!
    var picLayer: CAShapeLayer!
    var model: AnyObject!
    private var percentDrivenTransition: UIPercentDrivenInteractiveTransition?
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailImage.frame = CGRect(x: 0, y: 0, width: 600, height: 500)
        self.scrollView.addSubview(detailImage)
        self.detailLabel.text = self.label.text
        self.detailLabel.frame = CGRect(x: 50, y: 450, width: 80, height: 5)
        self.scrollView.addSubview(detailLabel)
        self.detailLabel.adjustsFontSizeToFitWidth = true
        self.detailLabel.sizeToFit()
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 1500)
        //self.drawRact()
        //WeatherInfo().parsingURL()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.delegate = self
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(DetailViewController.edgePanGesture(_:)))
        edgePan.edges = .Left
        self.view.addGestureRecognizer(edgePan)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.detailImage.frame = CGRect(x: 0, y: scrollView.contentOffset.y, width: self.view.frame.size.width, height: self.view.frame.size.height - 100)
        self.detailLabel.frame = CGRect(x: 0, y: scrollView.contentOffset.y + 450, width: 80, height: 15)
        let progress = 300 - scrollView.contentOffset.y
        if scrollView.contentOffset.y > 0 {
            self.detailImage.alpha = progress / 300
        }
    }
    /*
    func drawRact() {
        
        self.picLayer = CAShapeLayer()
        self.picLayer.fillColor = UIColor.blackColor().CGColor
        self.detailImage.layer.mask = self.picLayer
        
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(0, 0))
        path.addLineToPoint(CGPointMake(self.detailImage.frame.size.width, 0))
        path.addLineToPoint(CGPointMake(self.detailImage.frame.size.width, self.detailImage.frame.size.height))
        path.addLineToPoint(CGPointMake(0, self.detailImage.frame.size.height - 100))
        self.picLayer.path = path.CGPath
    }
    */
    func edgePanGesture(edgePan: UIScreenEdgePanGestureRecognizer) {
        let progress = edgePan.translationInView(self.view).x / self.view.bounds.width
        
        if edgePan.state == UIGestureRecognizerState.Began {
            self.percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            self.navigationController?.popViewControllerAnimated(true)
        } else if edgePan.state == UIGestureRecognizerState.Changed {
            self.percentDrivenTransition?.updateInteractiveTransition(progress)
        } else if edgePan.state == UIGestureRecognizerState.Cancelled || edgePan.state == UIGestureRecognizerState.Ended {
            if progress > 0.5 {
                self.percentDrivenTransition?.finishInteractiveTransition()
            } else {
                self.percentDrivenTransition?.cancelInteractiveTransition()
            }
            self.percentDrivenTransition = nil
        }
    }
    
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationControllerOperation.Pop {
            return CustomBackwardTransition()
        } else {
            return nil
        }
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animationController is CustomBackwardTransition {
            return self.percentDrivenTransition
        } else {
            return nil
        }
    }
    
}
