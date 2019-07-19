//
//  ViewController.swift
//  Texas Hold'em Probability Statistics Calculator
//
//  Created by Brian Barbu on 6/16/18.
//  Copyright © 2018 Brian Barbu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var selectedCards: [(uniqId: Int, uniqId: String)] = []
    var maxCount: Int? = nil
    var first = 0
    @IBAction func ClickToStart(_ sender: Any) {
        performSegue(withIdentifier: "segue1", sender: self)
        first = 1
    }
    
    @IBAction func ClickPre(_ sender: Any) {
        maxCount = 0
        performSegue(withIdentifier: "segue2", sender: self)
    }
    
    @IBAction func ClickFlop(_ sender: Any) {
        maxCount=3
        performSegue(withIdentifier: "segue2", sender: self)
    }
    
    @IBAction func ClickFourth(_ sender: Any) {
        maxCount = 4
        performSegue(withIdentifier: "segue2", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is ViewController2){
            let next = segue.destination as! ViewController2
            next.maxCount = maxCount
            next.selectedCards = selectedCards
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

