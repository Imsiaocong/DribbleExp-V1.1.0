//
//  DetailViewController.swift
//  Dribble
//
//  Created by 王笛 on 16/7/3.
//  Copyright © 2016年 王笛iOS.Inc. All rights reserved.
//

import UIKit

enum didFinish {
    case yes
    case no
}

class DetailViewController: UIViewController, UIScrollViewDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    var detailView: UIView!
    var detailImage = UIImageView()
    var detailLabel = UILabel()
    var words = CLTypingLabel()
    var extra: UIView!
    //@IBOutlet weak var detailView: UIView!
    var image: UIImage!
    var label: UILabel!
    var picLayer: CAShapeLayer!
    var model: AnyObject!
    let offSet = CGPoint(x: 0, y: 600)
    private var percentDrivenTransition: UIPercentDrivenInteractiveTransition?
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.words.text = "> I Want To Attend WWDC 2017."
        //self.words.pauseTyping()
        //self.extra = words
        self.extra = UIView()
        self.detailView = UIView()
        self.detailView.frame = CGRect(x: 0, y: 700, width: self.view.frame.size.width, height: 800)
        self.scrollView.addSubview(detailView)
        self.detailView.addSubview(extra)
        
        self.detailImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.scrollView.addSubview(detailImage)
        self.detailLabel.text = self.label.text
        self.detailLabel.frame = CGRect(x: 50, y: 450, width: 200, height: 50)
        self.detailLabel.textColor = UIColor.whiteColor()
        self.scrollView.addSubview(detailLabel)
        self.detailLabel.font = UIFont(name: "STHeitiTC-Light", size: 35)
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
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.detailImage.frame = CGRect(x: 0, y: scrollView.contentOffset.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
        print(scrollView.contentOffset.y)
        let progress = 300 - scrollView.contentOffset.y
        if scrollView.contentOffset.y > 0 {
            self.detailImage.alpha = progress / 300
        }
        if scrollView.contentOffset.y > 300 {
            self.detailImage.alpha = 0
        }else if scrollView.contentOffset.y < 300 {
            self.scrollView.addSubview(self.detailImage)
            self.scrollView.addSubview(self.detailLabel)
        }
        if scrollView.contentOffset.y > 430 {
            self.detailLabel.frame = CGRect(x: 50, y: scrollView.contentOffset.y + 20, width: 200, height: 50)
            self.words.continueTyping()
            //scrollView.scrollEnabled = false
        }
    }
    
    //func moveToOffSet() {
    //    self.scrollView.setContentOffset(offSet, animated: true)
    //}

    func edgePanGesture(edgePan: UIScreenEdgePanGestureRecognizer) {
        let progress = edgePan.translationInView(self.view).x / self.view.bounds.width
        
        if edgePan.state == UIGestureRecognizerState.Began {
        self.extra.removeFromSuperview()
        self.percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            self.navigationController?.popViewControllerAnimated(true)
        } else if edgePan.state == UIGestureRecognizerState.Changed {
            self.percentDrivenTransition?.updateInteractiveTransition(progress)
        } else if edgePan.state == UIGestureRecognizerState.Cancelled || edgePan.state == UIGestureRecognizerState.Ended {
            if progress > 0.5 {
                self.detailView.addSubview(extra)
                self.percentDrivenTransition?.finishInteractiveTransition()
            } else {
                self.detailView.addSubview(extra)
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
