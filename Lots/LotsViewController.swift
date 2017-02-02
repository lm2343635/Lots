//
//  ViewController.swift
//  Lots
//
//  Created by lidaye on 26/01/2017.
//  Copyright © 2017 fczm.pw. All rights reserved.
//

import UIKit

let raduis: CGFloat = 50.0

class LotsViewController: UIViewController {
    
    @IBOutlet weak var touchView: UIView!
    @IBOutlet weak var participatorsLabel: UILabel!
    
    var participators = 4, luckyDogs = 1
    var monitoring = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Allow this view to multiple touch
        touchView.isMultipleTouchEnabled = true
    }
    
    // MARK: - Touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        refreshParticipators(touches.count)
        if touches.count == participators && monitoring {
            showTouch(touches)
            showResult()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        refreshParticipators(touches.count)
        if touches.count == participators && monitoring {
            showTouch(touches)
            showResult()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        refreshParticipators(touches.count)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        refreshParticipators(touches.count)
    }
    
    // MARK: - Action
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Service
    func refreshParticipators(_ participators: Int) {
        participatorsLabel.text = "\(participators)"
    }
    
    func showResult() {
        monitoring = false
        let random = createRandomMan(start: 0, end: participators - 1)
        for _ in 0..<luckyDogs {
            touchView.subviews[random()].backgroundColor = UIColor.red
        }
    }
    
    func showTouch(_ touches: Set<UITouch>) {
        for touch in touches {
            self.view.addSubview(createTouchCircle(inPoint: touch.location(in: self.view)))
        }
    }
    
    func createTouchCircle(inPoint: CGPoint) -> UIView! {
        let view = UIView(frame: CGRect(x: inPoint.x - raduis,
                                        y: inPoint.y - raduis,
                                        width: 2 * raduis,
                                        height: 2 * raduis))
        view.backgroundColor = UIColor.lightGray
        view.layer.cornerRadius = raduis
        return view
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
