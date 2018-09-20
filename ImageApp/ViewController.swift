//
//  ViewController.swift
//  ImageApp
//
//  Created by 沛沛 on 2018/9/18.
//  Copyright © 2018年 沛沛. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    var image: UIImage?
    var data: Data?
    var yyCache: YYCache?
    var kCache: ImageCache?

    override func viewDidLoad() {
        super.viewDidLoad()
        let btn1 = UIButton(frame: CGRect(x: 50, y: 50, width: 50, height: 20))
        btn1.backgroundColor = UIColor.red
        btn1.addTarget(self, action: #selector(ycache), for: .touchUpInside)
        let btn2 = UIButton(frame: CGRect(x: 50, y: 100, width: 50, height: 20))
        btn2.backgroundColor = UIColor.green
        btn2.addTarget(self, action: #selector(kcache), for: .touchUpInside)
        
        let btn3 = UIButton(frame: CGRect(x: 50, y: 150, width: 50, height: 20))
        btn3.backgroundColor = UIColor.red
        btn3.addTarget(self, action: #selector(ycache1), for: .touchUpInside)
        let btn4 = UIButton(frame: CGRect(x: 50, y: 200, width: 50, height: 20))
        btn4.backgroundColor = UIColor.green
        btn4.addTarget(self, action: #selector(kcache1), for: .touchUpInside)
        view.addSubview(btn1)
        view.addSubview(btn2)
        view.addSubview(btn3)
        view.addSubview(btn4)
        
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let yyPath = documentPath + "/yyCache"
        let fishPath = documentPath + "/kingfisher"
        yyCache = YYCache(path: yyPath)
        kCache = ImageCache(name: "peipei", path: fishPath)
        kCache?.maxCachePeriodInSecond = 1
        image = UIImage(named: "test")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    @objc func ycache() {
        let data = UIImagePNGRepresentation(image!)
        let time = Date()
//        yyCache?.setObject(data as NSCoding?, forKey: "yimage", with: {
//            let cost = Date().timeIntervalSince(time)
//            print(cost)
//        })
        
//        yyCache?.memoryCache.setObject(data, forKey: "yimage")
//        let cost = Date().timeIntervalSince(time)
//        print(cost)
        
//        yyCache?.diskCache.setObject(data as NSCoding?, forKey: "yimage", with: {
//            let cost = Date().timeIntervalSince(time)
//            print(cost)
//        })
        
        for index in 0..<30 {
            yyCache?.setObject(data as NSCoding?, forKey: "yimage\(index)", with: {
                if index==29 {
                    let cost = Date().timeIntervalSince(time)
                    print(cost)
                }
            })
        }
    }
    
    @objc func kcache() {
        let time = Date()
//        kCache?.store(image!, original: nil, forKey: "kimage", completionHandler: {
//            let cost = Date().timeIntervalSince(time)
//            print(cost)
//        })
        
//        kCache?.store(image!, original: nil, forKey: "kimage", toDisk: false, completionHandler: {
//            let cost = Date().timeIntervalSince(time)
//            print(cost)
//        })
        
        for index in 0..<30 {
            kCache?.store(image!, original: nil, forKey: "kimage\(index)", completionHandler: {
                if index==29 {
                    let cost = Date().timeIntervalSince(time)
                    print(cost)
                }
            })
        }
    }
    
    @objc func ycache1() {
        let time = Date()
//        yyCache?.object(forKey: "yimage", with: { (_, object) in
//            let data = object as! Data
//            let image = UIImage(data: data)
//            print(image ?? "nil")
//            let cost = Date().timeIntervalSince(time)
//            print(cost)
//        })

        yyCache?.diskCache.trim(toAge: 1, with: {
            let cost = Date().timeIntervalSince(time)
            print(cost)
        })
    }
    
    @objc func kcache1() {
        let time = Date()
//        kCache?.retrieveImage(forKey: "kimage", options: nil, completionHandler: { (image, _) in
//            print(image ?? "nil")
//            let cost = Date().timeIntervalSince(time)
//            print(cost)
//        })
        kCache?.cleanExpiredDiskCache(completion: {
            let cost = Date().timeIntervalSince(time)
            print(cost)
        })
    }
}

