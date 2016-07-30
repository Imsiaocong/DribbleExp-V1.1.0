//
//  ViewController.swift
//  parseJSON
//
//  Created by 王笛 on 16/7/10.
//  Copyright © 2016年 王笛iOS.Inc. All rights reserved.
//

import UIKit

class WeatherInfo {
    //暂时先这么放着
    let weatherLabel = UILabel()
    
    private let url:NSURL = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=Zhoushan&APPID=06ddf21c52f06e793a7fdcd658c4d998")!
    
    func parsingURL() {
        let data = NSData(contentsOfURL: url)
        let json = JSON(data: data!)
        weatherLabel.text = "\(json)"
    }

}

