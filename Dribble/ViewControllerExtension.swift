//
//  ViewControllerExtension.swift
//  Dribble
//
//  Created by 王笛 on 16/8/8.
//  Copyright © 2016年 王笛iOS.Inc. All rights reserved.
//

import UIKit

extension ViewController{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x > 0 && scrollView.contentOffset.x <= 100{
            self.backgroundPic.image = UIImage(named: "0")
        }
        if scrollView.contentOffset.x > 100 && scrollView.contentOffset.x <= 400{
            self.backgroundPic.image = UIImage(named: "1")
        }
        if scrollView.contentOffset.x > 400 && scrollView.contentOffset.x <= 670{
            self.backgroundPic.image = UIImage(named: "2")
        }
        if scrollView.contentOffset.x > 670 && scrollView.contentOffset.x <= 850{
            self.backgroundPic.image = UIImage(named: "3")
        }
        if scrollView.contentOffset.x > 850 && scrollView.contentOffset.x <= 1062{
            self.backgroundPic.image = UIImage(named: "4")
        }
    }
    
    func addContent(state: didApear) {
        switch state {
        case .yes:
            print("Yes!")
        case .no:
            print("No!")
        }
    }
}
