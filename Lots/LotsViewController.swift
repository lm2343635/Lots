//
//  ViewController.swift
//  Lots
//
//  Created by lidaye on 26/01/2017.
//  Copyright © 2017 fczm.pw. All rights reserved.
//

import UIKit
import TouchVisualizer

let raduis: CGFloat = 45.0
let touchColor = UIColor(red: 52.0/255.0, green: 152.0/255.0, blue: 219.0/255.0, alpha: 0.8)
let luckyColor = UIColor.red

class LotsViewController: UIViewController {

    @IBOutlet weak var participatorsLabel: UILabel!
    
    var participators = 3, luckyDogs = 1
    var touchCount = 0
    var monitoring = true
    var touchViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set touch pointer
        var config = Configuration()
        config.color = touchColor
        config.defaultSize = CGSize(width: 2 * raduis, height: 2 * raduis)
        Visualizer.start(config)
    }
    
    // MARK: - Touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !monitoring {
            return
        }
        
        touchCount += touches.count
        participatorsLabel.text = "\(touchCount)"

        if touchCount == participators {
            monitoring = false
            let touches = Visualizer.getTouches()
            Visualizer.stop()
            for touch in touches {
                createTouchCircle(touch)
            }
            showResult()
        }

    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if monitoring {
            touchCount -= touches.count
            participatorsLabel.text = "\(touchCount)"
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if monitoring {
            touchCount -= touches.count
            participatorsLabel.text = "\(touchCount)"
        }
    }
    
    // MARK: - Action
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func reload(_ sender: Any) {
    }
    
    // MARK: - Service
    func showResult() {
        monitoring = false
        let random = createRandomMan(start: 0, end: participators - 1)
        for _ in 0..<luckyDogs {
            touchViews[random()].backgroundColor = luckyColor
        }
    }
    
    // Create a touch circle for a touch event
    func createTouchCircle(_ touch: UITouch) {
        let inPoint = touch.location(in: self.view)
        let view = UIView(frame: CGRect(x: inPoint.x - raduis,
                                        y: inPoint.y - raduis,
                                        width: 2 * raduis,
                                        height: 2 * raduis))
        view.backgroundColor = touchColor
        view.layer.cornerRadius = raduis
        self.view.addSubview(view)
        touchViews.append(view)
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
