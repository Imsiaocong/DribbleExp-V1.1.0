//
//  ViewController.swift
//  Dribble
//
//  Created by 王笛 on 16/7/3.
//  Copyright © 2016年 王笛iOS.Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedCell = CollectionViewCell()
    var image: UIImage!
    var label: UILabel!
    var replica = UIImageView()
    let customAnimation = CustomTransitionAnimation()
    let imgArray = ["0","1","2","3","4","5","6","7","8","9"]
    let ttlArray = ["Taylor Swift","Albums","Concerts","Website","Blog","Fans","grs","vzx","tyut","pkm"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.dataSource = self
        collectionView.delegate   = self
        collectionView.backgroundColor = UIColor.clearColor()
        //self.navigationController?.navigationBarHidden = true
        let ges = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.didPress))
        ges.delegate = self
        self.view.addGestureRecognizer(ges)
        //
        self.replica.layer.masksToBounds = true
        self.replica.contentMode = UIViewContentMode.ScaleAspectFill
        
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell
        cell.cellImage.image = UIImage(named: imgArray[indexPath.row])
        cell.cellLabel.text = ttlArray[indexPath.row]
        cell.cellLabel.adjustsFontSizeToFitWidth = true
        cell.cellLabel.font = UIFont(name: "STHeitiTC-Light", size: 17)
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.selectedCell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
        self.performSegueWithIdentifier("ShowDetail", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let DestinationView = segue.destinationViewController as! DetailViewController
            DestinationView.image = self.selectedCell.cellImage.image
            DestinationView.label = self.selectedCell.cellLabel
            
            
            if DestinationView.label.text! == "Taylor Swift" {
               DestinationView.view.backgroundColor = UIColor.whiteColor()
            let cus = TheSecondView(desitination: DestinationView, label: DestinationView.label, extra: DestinationView.extra)
                cus.customizedView()
                
            }else if DestinationView.label.text == "Albums" {
                
                
                DestinationView.view.backgroundColor = UIColor.whiteColor()
                
                
            }else if DestinationView.label.text == "Concerts" {
                
                
                DestinationView.view.backgroundColor = UIColor.cyanColor()
                
                
            }else if DestinationView.label.text == "Website" {
                
                
                DestinationView.view.backgroundColor = UIColor.darkGrayColor()
                
                
            }else if DestinationView.label.text == "Blog" {
                
                
                DestinationView.view.backgroundColor = UIColor.clearColor()
                
                
            }else if DestinationView.label.text == "Fans" {
                
                
                DestinationView.view.backgroundColor = UIColor(red: 0.281, green: 0.412, blue: 0.245, alpha: 0.5)
                
                
            }else if DestinationView.label.text == "7" {
                
                
                DestinationView.view.backgroundColor = UIColor(red: 0.534, green: 0.412, blue: 0.245, alpha: 0.5)
                
                
            }else if DestinationView.label.text == "8" {
                
                
                DestinationView.view.backgroundColor = UIColor(red: 0.334, green: 0.412, blue: 0.245, alpha: 0.5)
                
                
            }else if DestinationView.label.text == "9" {
                
                
                DestinationView.view.backgroundColor = UIColor(red: 0.934, green: 0.412, blue: 0.245, alpha: 0.5)
                
                
            }else if DestinationView.label.text == "0" {
                
                
                DestinationView.view.backgroundColor = UIColor(red: 1.234, green: 0.412, blue: 0.245, alpha: 0.5)
                
                
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

}

