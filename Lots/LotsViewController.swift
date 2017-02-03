//
//  ViewController.swift
//  Lots
//
//  Created by lidaye on 26/01/2017.
//  Copyright © 2017 fczm.pw. All rights reserved.
//

import UIKit
import TouchVisualizer

let raduis: CGFloat = 30.0

class LotsViewController: UIViewController {
    
    @IBOutlet weak var touchView: UIView!
    @IBOutlet weak var participatorsLabel: UILabel!
    
    var participators = 3, luckyDogs = 1
    var touchCount = 0
    var monitoring = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Allow this view to multiple touch
        self.view.isMultipleTouchEnabled = true
        
        Visualizer.start()

    }
    
    // MARK: - Touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchCount += touches.count
        participatorsLabel.text = "\(touchCount)"

        if touchCount == participators && monitoring {
//            showTouch(touches)
//            showResult()
        }

    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchCount -= touches.count
        participatorsLabel.text = "\(touchCount)"
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchCount -= touches.count
        participatorsLabel.text = "\(touchCount)"
    }
    
    // MARK: - Action
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Service

    func showResult() {
        monitoring = false
        let random = createRandomMan(start: 0, end: participators - 1)
        for _ in 0..<luckyDogs {
            touchView.subviews[random()].backgroundColor = UIColor.red
        }
    }
    
    // Create a touch circle for a touch event
    func createTouchCircle(_ touch: UITouch) {
        let inPoint = touch.location(in: self.view)
        let view = UIView(frame: CGRect(x: inPoint.x - raduis,
                                        y: inPoint.y - raduis,
                                        width: 2 * raduis,
                                        height: 2 * raduis))
        view.backgroundColor = UIColor.lightGray
        view.layer.cornerRadius = raduis
        touchView.addSubview(view)
    }

    func clearAllCircle() {
        touchView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }
    
    // Create random
    func createRandomMan(start: Int, end: Int) ->() ->Int! {
        var nums = [Int]();
        for i in start...end{
            nums.append(i)
        }
        
        func randomMan() -> Int! {
            if !nums.isEmpty {
                let index = Int(arc4random_uniform(UInt32(nums.count)))
                return nums.remove(at: index)
            } else {
                return nil
            }
        }
        
        return randomMan
    }
    
}
