//
//  RuleViewController.swift
//  Lots
//
//  Created by lidaye on 02/02/2017.
//  Copyright © 2017 fczm.pw. All rights reserved.
//

import UIKit
import TouchVisualizer

class RuleViewController: UIViewController {

    var participators = 3, luckyDogs = 1, maxParticipators = 5
    
    @IBOutlet weak var participatorLabel: UILabel!
    @IBOutlet weak var luckyDogsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice.current.userInterfaceIdiom == .pad {
            maxParticipators = 10
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Visualizer.stop()
    }

    // MARK: - Nagivation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lotsSegue" {
            let destination = segue.destination as! LotsViewController
            destination.participators = participators
            destination.luckyDogs = luckyDogs
        }
    }
    
    // MARK: - Action
    @IBAction func addParticipator(_ sender: Any) {
        if participators == maxParticipators {
            return
        }
        participators += 1
        participatorLabel.text = "\(participators)"
    }
    
    @IBAction func reduceParticipator(_ sender: Any) {
        if participators == 2 {
            return
        }
        participators -= 1
        participatorLabel.text = "\(participators)"
        if luckyDogs == participators {
            removeLuckDogs(sender)
        }
    }
    
    @IBAction func addLuckDogs(_ sender: Any) {
        if luckyDogs + 1 == participators {
            return
        }
        luckyDogs += 1
        luckyDogsLabel.text = "\(luckyDogs)"
    }

    @IBAction func removeLuckDogs(_ sender: Any) {
        if luckyDogs == 1 {
            return
        }
        luckyDogs -= 1
        luckyDogsLabel.text = "\(luckyDogs)"
    }
    
}
