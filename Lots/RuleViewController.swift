//
//  RuleViewController.swift
//  Lots
//
//  Created by lidaye on 02/02/2017.
//  Copyright © 2017 fczm.pw. All rights reserved.
//

import UIKit

class RuleViewController: UIViewController {

    var participators = 4, luckyDogs = 1
    
    @IBOutlet weak var participatorLabel: UILabel!
    @IBOutlet weak var luckyDogsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
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
        if participators == 10 {
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
