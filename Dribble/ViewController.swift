//
//  ViewController.swift
//  Dribble
//
//  Created by 王笛 on 16/7/3.
//  Copyright © 2016年 王笛iOS.Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundPic: UIImageView!
    var didShow: Bool!
    var selectedCell = CollectionViewCell()
    var currentImage = ""
    var image: UIImage!
    var label: UILabel!
    var headerView: UIVisualEffectView!
    var replica = UIImageView()
    var blur: UIVisualEffectView!
    var blur2: UIVisualEffectView!
    let customAnimation = CustomTransitionAnimation()
    let imgArray = ["0","1","2","3","4"]
    let ttlArray = ["Taylor Swift","Albums","Concerts","Website","Blog"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.dataSource = self
        collectionView.delegate   = self
        collectionView.backgroundColor = UIColor.clearColor()
        //self.navigationController?.navigationBarHidden = true
        let ges = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.didPress))
            ges.delegate = self
        let ges2 = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.headerViewAnimation))
            ges2.direction = .Up
            ges2.delegate = self
        let ges3 = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.headerViewAnimation2))
        ges3.direction = .Down
        ges3.delegate = self
        self.view.addGestureRecognizer(ges3)
        self.view.addGestureRecognizer(ges2)
        self.view.addGestureRecognizer(ges)
        //self.parsingURL()
        self.replica.layer.masksToBounds = true
        self.replica.contentMode = UIViewContentMode.ScaleAspectFill
        self.blur = UIVisualEffectView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.blur.effect = UIBlurEffect(style: .Light)
        self.blur.alpha = 0.9
        
        self.blur2 = UIVisualEffectView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height + 100))
        self.blur2.effect = UIBlurEffect(style: .Light)
        self.blur2.alpha = 0.9
        self.headerView = UIVisualEffectView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0))
        self.headerView.effect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        self.headerView.alpha = 1
        self.headerView.backgroundColor = UIColor.clearColor()
        self.didShow = false
        self.view.addSubview(headerView)
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 6, options: .CurveEaseOut, animations: { 
            self.headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }) { (Bool) in
                self.didShow = true
        }

        self.backgroundPic.addSubview(blur2)
        //self.backgroundPicture()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    /*
    func parsingURL() {
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=Zhoushan&APPID=06ddf21c52f06e793a7fdcd658c4d998")
        let data = NSData(contentsOfURL: url!)
        let json = JSON(data: data!)
        if let name = json["weather"][0]["main"].string{
            print(name)
            if json["weather"][0]["main"].string == "Clear" {
                self.weatherImg.image = UIImage(named: "Sunny")
            }else if json["weather"][0]["main"].string == "Clouds" {
                self.weatherImg.image = UIImage(named: "Clouds")
            }
            
        }
    }
 */
    /*
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("\(scrollView.contentOffset.x) y:\(scrollView.contentOffset.y)")
        
        let point = CGPoint(x: 340, y: 0)
        if scrollView.contentOffset.x > 170 {
            UIView.animateWithDuration(0.1, animations: {
                scrollView.setContentOffset(point, animated: true)
            })
        }
    }
    */
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationControllerOperation.Push {
            return CustomTransitionAnimation()
        } else {
            return nil
        }
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return ttlArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //let shadowLayer = CAShapeLayer()
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell
        cell.cellImage.image = UIImage(named: imgArray[indexPath.row])
        cell.cellLabel.text = ttlArray[indexPath.row]
        cell.cellLabel.adjustsFontSizeToFitWidth = true
        cell.cellLabel.font = UIFont(name: "STHeitiTC-Light", size: 17)
        cell.layer.cornerRadius = 5
        /*
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.masksToBounds = false
        cell.layer.shadowOpacity = 1
        cell.layer.shadowRadius = 5
        cell.layer.shadowOffset = CGSizeMake(0, 5)
        cell.layer.shadowPath = UIBezierPath(rect: cell.bounds).CGPath
        */
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.selectedCell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
        self.performSegueWithIdentifier("ShowDetail", sender: nil)
        
        blur.effect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        self.view.addSubview(blur)
    }
    /*
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
        if scrollView.contentOffset.x > 0 && scrollView.contentOffset.x <= 100{
            self.backgroundPic.image = UIImage(named: "0")
        }
        if scrollView.contentOffset.x > 100 && scrollView.contentOffset.x <= 400{
            self.backgroundPic.image = UIImage(named: "1")
        }
        if scrollView.contentOffset.x > 400 && scrollView.contentOffset.x <= 670{
            self.backgroundPic.image = UIImage(named: "2")
        }
        if scrollView.contentOffset.x > 670 && scrollView.contentOffset.x <= 970{
            self.backgroundPic.image = UIImage(named: "3")
        }
        if scrollView.contentOffset.x > 970 && scrollView.contentOffset.x <= 1062{
            self.backgroundPic.image = UIImage(named: "4")
        }
    }
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //let snapshotView = self.view.snapshotViewAfterScreenUpdates(false)
        if segue.identifier == "ShowDetail" {
            let DestinationView = segue.destinationViewController as! DetailViewController
            DestinationView.image = self.selectedCell.cellImage.image
            DestinationView.label = self.selectedCell.cellLabel
            
            
            if DestinationView.label.text! == "Taylor Swift" {
                //DestinationView.view.addSubview(snapshotView)
               DestinationView.view.backgroundColor = UIColor.clearColor()
               DestinationView.scrollView.addSubview(DestinationView.detailView)
            let cus = TheSecondView(desitination: DestinationView, label: DestinationView.label, extra: DestinationView.extra)
                cus.customizedView()
                
            }else if DestinationView.label.text == "Albums" {
                
                
                DestinationView.view.backgroundColor = UIColor.clearColor()
                
                
            }else if DestinationView.label.text == "Concerts" {
                
                
                DestinationView.view.backgroundColor = UIColor.clearColor()
                
                
            }else if DestinationView.label.text == "Website" {
                
                
                DestinationView.view.backgroundColor = UIColor.clearColor()
                
                
            }else if DestinationView.label.text == "Blog" {
                
                
                DestinationView.view.backgroundColor = UIColor.clearColor()
                
                
            }
        }
    }
    
    func didPress(gesture: UILongPressGestureRecognizer) {
        let point = gesture.locationInView(self.collectionView)
        if let indexPath : NSIndexPath = (self.collectionView?.indexPathForItemAtPoint(point)){
            let state = gesture.state
            let item = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
            if state == UIGestureRecognizerState.Began{
                UIView.animateWithDuration(0.5, animations: { 
                    item.alpha = 0.5
                })
            }else if state == UIGestureRecognizerState.Ended {
                UIView.animateWithDuration(0.5, animations: { 
                    item.alpha = 1
                    }, completion: { (Bool) in
                        self.collectionView(self.collectionView, didSelectItemAtIndexPath: indexPath)
                })
            }
            
        }
    }
    
    func headerViewAnimation() {
        if didShow == true {
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 6, options: .CurveEaseInOut, animations: {
            self.headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0)
            }, completion:{ (Bool) in
                self.didShow = false
        })
        }
    }
    
    func headerViewAnimation2() {
        if didShow == false {
        self.headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0)

        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 6, options: .CurveEaseInOut, animations: {
            self.headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }, completion: { (Bool) in
                self.didShow = true
        })
    }
    }
}
