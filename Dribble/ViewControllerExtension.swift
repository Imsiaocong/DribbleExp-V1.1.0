//
//  ViewControllerExtension.swift
//  Dribble
//
//  Created by 王笛 on 16/8/8.
//  Copyright © 2016年 王笛iOS.Inc. All rights reserved.
//

import UIKit

extension ViewController {
    func backgroundPicture() {
        self.backgroundPic = UIImageView()
        self.backgroundPic = UIImageView(frame: CGRect(x: 0, y: 0, width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height))
        self.backgroundPic.image = UIImage(named: "1")
        self.backgroundPic.alpha = 0.2
        self.collectionView.backgroundView?.addSubview(self.backgroundPic)
    }
}
