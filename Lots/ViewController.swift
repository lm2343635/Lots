//
//  ViewController.swift
//  Lots
//
//  Created by lidaye on 26/01/2017.
//  Copyright © 2017 fczm.pw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.isMultipleTouchEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        clearAllCircle()
        refreshCircle(touches)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        clearAllCircle()
        refreshCircle(touches)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        clearAllCircle()
        refreshCircle(touches)
        if touches.count == 2 {
            let random = createRandomMan(start: 0, end: 1)
            self.view.subviews[random()].backgroundColor = UIColor.red
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        clearAllCircle()
    }
    
    func createTouchCircle(inPoint: CGPoint) -> UIView! {
        let view = UIView(frame: CGRect(origin: inPoint, size: CGSize(width: 30, height: 30)))
        view.backgroundColor = UIColor.lightGray
        view.layer.cornerRadius = 15
        return view
    }

    func clearAllCircle() {
        self.view.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }
    
    func refreshCircle(_ touches: Set<UITouch>) {
        for touch in touches {
            let circleView = createTouchCircle(inPoint: touch.location(in: self.view))!
            self.view.addSubview(circleView)
        }
    }
    
    //随机数生成器函数
    func createRandomMan(start: Int, end: Int) ->() ->Int! {
        //根据参数初始化可选值数组
        var nums = [Int]();
        for i in start...end{
            nums.append(i)
        }
        
        func randomMan() -> Int! {
            if !nums.isEmpty {
                //随机返回一个数，同时从数组里删除
                let index = Int(arc4random_uniform(UInt32(nums.count)))
                return nums.remove(at: index)
            } else {
                //所有值都随机完则返回nil
                return nil
            }
        }
        
        return randomMan
    }
    
}
