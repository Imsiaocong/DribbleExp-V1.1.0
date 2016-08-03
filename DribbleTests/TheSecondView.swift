//
//  TheSecondView.swift
//  Dribble
//
//  Created by 王笛 on 16/7/17.
//  Copyright © 2016年 王笛iOS.Inc. All rights reserved.
//

import UIKit

class TheSecondView {
    
    private let designatedView: UIViewController!
    private let label: UILabel!
    private var extra: UIView!
    private let frame = CGRect(x: 0, y: 0, width: 600, height: 1000)
    
    init(desitination: UIViewController, label: UILabel, extra: UIView) {
        self.designatedView = desitination
        self.label = label
        self.extra = extra
    }
    
    func customizedView() {
        self.label.text = "Taylor Swift"
        self.extra.addSubview(ExtraViewController().view)
    }
}

class ExtraViewController: UIViewController {
    
    var imageViews: [UIImageView]!
    var resueArray: [UIImageView]!
    var maxLength: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.imageViews = [UIImageView]()
        self.resueArray = [UIImageView]()
        createImageViews(5)
        self.maxLength = self.view.bounds.width * 0.5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //STEP1: APPEND IMAGES TO OUR ARRAY
    func createImageViews(count: Int) {
        for index in 0..<count {
            let imageView = createOneImageView(index)
            imageView.image = UIImage(named: "\(index)")
            self.view.insertSubview(imageView, atIndex: 1)
            self.imageViews.append(imageView)
        }
    }
    //STEP2: SET ATTRIBUTES OF THE IMAGE
    func createOneImageView(index: Int) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.frame = CGRectInset(self.view.frame, 20, 100)
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        
        setUpImageView(imageView, index: index)
        
        //点击手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(ExtraViewController.tapPanGesture(_:)))
        imageView.addGestureRecognizer(tap)
        
        //滑动手势
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ExtraViewController.panPanGesture(_:)))
        imageView.addGestureRecognizer(pan)
        imageView.userInteractionEnabled = true
        
        return imageView
    }
    //STEP3: GIVING OUR IMAGES 3D EFFECTS
    func setUpImageView(imageView: UIImageView, index: Int) {
        var transform = CATransform3DIdentity
        transform.m34 = -0.001
        imageView.layer.transform = transform
        
        imageView.layer.transform = CATransform3DTranslate(imageView.layer.transform, 0, -7.0 * CGFloat(index), 0)
        imageView.layer.transform = CATransform3DScale(imageView.layer.transform, 1 - 0.08 * CGFloat(index), 1, 1)
        imageView.layer.opacity = 1 - 0.2 * Float(index)
    }
    
    func tapPanGesture(tap: UITapGestureRecognizer) {
        let imageView = tap.view!
        
        //设置zPosition属性，可以让卡片翻转的时候不受后面卡片的影响
        imageView.layer.zPosition = 200
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            imageView.layer.transform = CATransform3DRotate(imageView.layer.transform, CGFloat(M_PI), 0, 1, 0)
        })
    }
    
    func panPanGesture(pan: UIPanGestureRecognizer) {
        let trans = pan.translationInView(self.view).x
        let delta = trans * 0.6
        
        if pan.state == .Changed {
            if abs(trans) > self.maxLength {
                pan.enabled = false
                let imageView = self.imageViews.first
                let current = imageView?.layer.valueForKeyPath("transform.translation.x") as! CGFloat
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    imageView?.layer.setValue((current > 0) ? self.view.bounds.width : -self.view.bounds.width, forKeyPath: "transform.translation.x")
                    }, completion: nil)
            } else {
                for index in 0..<self.imageViews.count {
                    let imageView = self.imageViews[index]
                    
                    imageView.layer.setValue((1 - (CGFloat(index) / CGFloat(self.imageViews.count))) * delta, forKeyPath: "transform.translation.x")
                    imageView.layer.setValue((1 - (CGFloat(index) / CGFloat(self.imageViews.count))) * (delta / self.maxLength) * (15.0 / 180) * CGFloat(M_PI), forKeyPath: "transform.rotation.z")
                }
            }
        } else if pan.state == .Ended || pan.state == .Cancelled {
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                for index in 0..<self.imageViews.count {
                    //防止移动超过规定距离后，这个动画和将第一个卡片移出屏幕的动画冲突
                    if !pan.enabled && index == 0 {
                        continue
                    }
                    
                    let imageView = self.imageViews[index]
                    imageView.layer.setValue(0, forKeyPath: "transform.translation.x")
                    imageView.layer.setValue(0, forKeyPath: "transform.rotation.z")
                }
                }, completion: {(finished: Bool) -> Void in
                    if !pan.enabled {
                        pan.enabled = true
                        let first = self.imageViews.removeAtIndex(0)
                        first.removeFromSuperview()
                        self.resueArray.append(first)
                        
                        self.endAnimation()
                    }
            })
        }
        
    }
    
    func endAnimation() {
        for index in 0..<self.imageViews.count {
            let imageView = self.imageViews[index]
            
            UIView.animateWithDuration(0.5, delay: NSTimeInterval(index) * 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                
                imageView.layer.setValue(-7.0 * CGFloat(index), forKeyPath: "transform.translation.y")
                imageView.layer.setValue(1 - 0.08 * CGFloat(index), forKeyPath: "transform.scale.x")
                imageView.layer.opacity = 1 - 0.2 * Float(index)
                
                }, completion: {(finish: Bool) -> Void in
                    //最后一个动画完毕后，添加新的Card到最后
                    if index == self.imageViews.count - 1 {
                        self.addNewCard()
                    }
            })
        }
    }
    
    func addNewCard() {
        var imageView: UIImageView
        
        if self.resueArray.isEmpty {
            imageView = createOneImageView(self.imageViews.count)
        } else {
            imageView = self.resueArray.removeAtIndex(0)
            setUpImageView(imageView, index: self.imageViews.count)
        }
        
        imageView.image = UIImage(named: String(format: "Taylor Swift %05d", arguments: [arc4random_uniform(5)]))
        
        self.view.insertSubview(imageView, atIndex: 1)
        self.imageViews.append(imageView)
    }
    
}
