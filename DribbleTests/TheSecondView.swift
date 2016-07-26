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
    
    init(desitination: UIViewController, label: UILabel) {
        self.designatedView = desitination
        self.label = label
    }
    
    func customizedView() {
        self.label.text = "Swift"
    }
}
