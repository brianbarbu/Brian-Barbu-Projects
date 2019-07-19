//
//  ViewController3.swift
//  Texas Hold'em Probability Statistics Calculator
//
//  Created by Brian Barbu on 6/28/18.
//  Copyright © 2018 Brian Barbu. All rights reserved.
//

import Foundation
import UIKit

class ViewController3: UIViewController {
    @IBOutlet weak var club2: UIImageView!
    @IBOutlet weak var spade2: UIImageView!
    @IBOutlet weak var heart2: UIImageView!
    @IBOutlet weak var diamond2: UIImageView!
    @IBOutlet weak var club3: UIImageView!
    @IBOutlet weak var spade3: UIImageView!
    @IBOutlet weak var heart3: UIImageView!
    @IBOutlet weak var diamond3: UIImageView!
    @IBOutlet weak var club4: UIImageView!
    @IBOutlet weak var spade4: UIImageView!
    @IBOutlet weak var heart4: UIImageView!
    @IBOutlet weak var diamond4: UIImageView!
    @IBOutlet weak var club5: UIImageView!
    @IBOutlet weak var spade5: UIImageView!
    @IBOutlet weak var heart5: UIImageView!
    @IBOutlet weak var diamond5: UIImageView!
    @IBOutlet weak var club6: UIImageView!
    @IBOutlet weak var spade6: UIImageView!
    @IBOutlet weak var heart6: UIImageView!
    @IBOutlet weak var diamond6: UIImageView!
    @IBOutlet weak var club7: UIImageView!
    @IBOutlet weak var spade7: UIImageView!
    @IBOutlet weak var heart7: UIImageView!
    @IBOutlet weak var diamond7: UIImageView!
    @IBOutlet weak var club8: UIImageView!
    @IBOutlet weak var spade8: UIImageView!
    @IBOutlet weak var heart8: UIImageView!
    @IBOutlet weak var diamond8: UIImageView!
    @IBOutlet weak var club9: UIImageView!
    @IBOutlet weak var spade9: UIImageView!
    @IBOutlet weak var heart9: UIImageView!
    @IBOutlet weak var diamond9: UIImageView!
    @IBOutlet weak var club10: UIImageView!
    @IBOutlet weak var spade10: UIImageView!
    @IBOutlet weak var heart10: UIImageView!
    @IBOutlet weak var diamond10: UIImageView!
    @IBOutlet weak var clubJ: UIImageView!
    @IBOutlet weak var spadeJ: UIImageView!
    @IBOutlet weak var heartJ: UIImageView!
    @IBOutlet weak var diamondJ: UIImageView!
    @IBOutlet weak var clubQ: UIImageView!
    @IBOutlet weak var spadeQ: UIImageView!
    @IBOutlet weak var heartQ: UIImageView!
    @IBOutlet weak var diamondQ: UIImageView!
    @IBOutlet weak var clubK: UIImageView!
    @IBOutlet weak var spadeK: UIImageView!
    @IBOutlet weak var heartK: UIImageView!
    @IBOutlet weak var diamondK: UIImageView!
    @IBOutlet weak var clubA: UIImageView!
    @IBOutlet weak var spadeA: UIImageView!
    @IBOutlet weak var heartA: UIImageView!
    @IBOutlet weak var diamondA: UIImageView!
    
    var clicked = 0
    var maxCount: Int!
    var selectedCards: [(uniqId: Int, uniqId: String)] = []

    @IBOutlet weak var cardtitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideHand()
        cardtitle.text = "Pick the \(maxCount!) cards that have been flopped:"
        /*
        let label = UILabel(frame: CGRect(x: 0, y: 30, width: 200, height: 21))
        label.font = label.font.withSize(20)
        label.textColor = UIColor.black
        label.textAlignment = .center
        //let width = (imageView?.frame.size.width)
        //let height = (imageView?.frame.size.height)
        label.text = "This \(maxCount!)"
        self.view.addSubview(label)
        */
        // Do any additional setup after loading the view, typically from a nib.
        let imageArray: [UIImageView] = [club2, spade2, heart2, diamond2, club3, spade3, heart3, diamond3, club4, spade4, heart4, diamond4, club5, spade5, heart5, diamond5, club6, spade6, heart6, diamond6, club7, spade7, heart7, diamond7, club8, spade8, heart8, diamond8, club9, spade9, heart9, diamond9, club10, spade10, heart10, diamond10, clubJ, spadeJ, heartJ, diamondJ, clubQ, spadeQ, heartQ, diamondQ, clubK, spadeK, heartK, diamondK, clubA, spadeA, heartA, diamondA]
        addGestureRecognizer(imageArray: imageArray)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addGestureRecognizer(imageArray: [UIImageView]){
        for imageView in imageArray{
            imageView.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture:)))
            imageView.addGestureRecognizer(tap)
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = UIColor.black.cgColor
        }
        
    }
    @objc func handleTap(gesture:UITapGestureRecognizer){
        let imageView = gesture.view
        let center = imageView?.center
        if(((imageView?.tag) == 0) && (clicked < maxCount)){
            imageView?.frame = CGRect(x: (imageView?.frame.origin.x)!, y: (imageView?.frame.origin.y)!, width: (imageView?.frame.size.width)! * 0.75, height: (imageView?.frame.size.height)! * 0.75);
            imageView?.center = center!
            imageView?.tag = 1
            imageView?.layer.borderWidth = 2
            imageView?.layer.borderColor = UIColor.red.cgColor
            clicked = clicked + 1
            addCard(imageView: imageView as! UIImageView)
        }
        else if((imageView?.tag) == 1){
            imageView?.frame = CGRect(x: (imageView?.frame.origin.x)!, y: (imageView?.frame.origin.y)!, width: (imageView?.frame.size.width)! * (4/3), height: (imageView?.frame.size.height)! * (4/3));
            imageView?.center = center!
            imageView?.tag = 0
            imageView?.layer.borderWidth = 1
            imageView?.layer.borderColor = UIColor.black.cgColor
            clicked = clicked - 1
            removeCard(imageView: imageView as! UIImageView)
        }
    }
    @IBAction func clickSubmit(_ sender: Any) {
        if(clicked == maxCount){
            performSegue(withIdentifier: "segue4", sender: self)
        }
        
    }
    @IBAction func clickRestart(_ sender: Any) {
        performSegue(withIdentifier: "segueRFlop", sender: self)
    }
    
    @IBAction func clickClear(_ sender: Any) {
        let imageArray: [UIImageView] = [club2, spade2, heart2, diamond2, club3, spade3, heart3, diamond3, club4, spade4, heart4, diamond4, club5, spade5, heart5, diamond5, club6, spade6, heart6, diamond6, club7, spade7, heart7, diamond7, club8, spade8, heart8, diamond8, club9, spade9, heart9, diamond9, club10, spade10, heart10, diamond10, clubJ, spadeJ, heartJ, diamondJ, clubQ, spadeQ, heartQ, diamondQ, clubK, spadeK, heartK, diamondK, clubA, spadeA, heartA, diamondA]
        for imageView in imageArray{
            let center = imageView.center
            if((imageView.tag) == 1){
                imageView.frame = CGRect(x: (imageView.frame.origin.x), y: (imageView.frame.origin.y), width: (imageView.frame.size.width) * (4/3), height: (imageView.frame.size.height) * (4/3));
                imageView.center = center
                imageView.tag = 0
                imageView.layer.borderWidth = 0.5
                imageView.layer.borderColor = UIColor.black.cgColor
                clicked = clicked - 1
                removeCard(imageView: imageView )
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is ViewController4){
            let next = segue.destination as! ViewController4
            next.maxCount = maxCount
            next.selectedCards = selectedCards
        }
        else if(segue.destination is ViewController){
            let next = segue.destination as! ViewController
            next.maxCount = nil
            next.selectedCards = []
        }
    }
    @objc func hideHand(){
        for card in selectedCards{
            if((card.0 == 2) && (card.1 == "clubs")){
                club2.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 3) && (card.1 == "clubs")){
                club3.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 4) && (card.1 == "clubs")){
                club4.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 5) && (card.1 == "clubs")){
                club5.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 6) && (card.1 == "clubs")){
                club6.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 7) && (card.1 == "clubs")){
                club7.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 8) && (card.1 == "clubs")){
                club8.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 9) && (card.1 == "clubs")){
                club9.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 10) && (card.1 == "clubs")){
                club10.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 11) && (card.1 == "clubs")){
                clubJ.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 12) && (card.1 == "clubs")){
                clubQ.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 13) && (card.1 == "clubs")){
                clubK.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 14) && (card.1 == "clubs")){
                clubA.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 2) && (card.1 == "spades")){
                spade2.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 3) && (card.1 == "spades")){
                spade3.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 4) && (card.1 == "spades")){
                spade4.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 5) && (card.1 == "spades")){
                spade5.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 6) && (card.1 == "spades")){
                spade6.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 7) && (card.1 == "spades")){
                spade7.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 8) && (card.1 == "spades")){
                spade8.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 9) && (card.1 == "spades")){
                spade9.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 10) && (card.1 == "spades")){
                spade10.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 11) && (card.1 == "spades")){
                spadeJ.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 12) && (card.1 == "spades")){
                spadeQ.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 13) && (card.1 == "spades")){
                spadeK.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 14) && (card.1 == "spades")){
                spadeA.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 2) && (card.1 == "hearts")){
                heart2.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 3) && (card.1 == "hearts")){
                heart3.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 4) && (card.1 == "hearts")){
                heart4.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 5) && (card.1 == "hearts")){
                heart5.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 6) && (card.1 == "hearts")){
                heart6.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 7) && (card.1 == "hearts")){
                heart7.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 8) && (card.1 == "hearts")){
                heart8.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 9) && (card.1 == "hearts")){
                heart9.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 10) && (card.1 == "hearts")){
                heart10.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 11) && (card.1 == "hearts")){
                heartJ.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 12) && (card.1 == "hearts")){
                heartQ.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 13) && (card.1 == "hearts")){
                heartK.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 14) && (card.1 == "hearts")){
                heartA.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 2) && (card.1 == "diamonds")){
                diamond2.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 3) && (card.1 == "diamonds")){
                diamond3.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 4) && (card.1 == "diamonds")){
                diamond4.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 5) && (card.1 == "diamonds")){
                diamond5.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 6) && (card.1 == "diamonds")){
                diamond6.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 7) && (card.1 == "diamonds")){
                diamond7.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 8) && (card.1 == "diamonds")){
                diamond8.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 9) && (card.1 == "diamonds")){
                diamond9.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 10) && (card.1 == "diamonds")){
                diamond10.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 11) && (card.1 == "diamonds")){
                diamondJ.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 12) && (card.1 == "diamonds")){
                diamondQ.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 13) && (card.1 == "diamonds")){
                diamondK.isHidden = true
            }
        }
        for card in selectedCards{
            if((card.0 == 14) && (card.1 == "diamonds")){
                diamondA.isHidden = true
            }
        }
    }
    
    @objc func addCard(imageView: UIImageView){
        if imageView == club2{
            selectedCards.append((2, "clubs"))
        }
        if imageView == club3{
            selectedCards.append((3, "clubs"))
        }
        if imageView == club4{
            selectedCards.append((4, "clubs"))
        }
        if imageView == club5{
            selectedCards.append((5, "clubs"))
        }
        if imageView == club6{
            selectedCards.append((6, "clubs"))
        }
        if imageView == club7{
            selectedCards.append((7, "clubs"))
        }
        if imageView == club8{
            selectedCards.append((8, "clubs"))
        }
        if imageView == club9{
            selectedCards.append((9, "clubs"))
        }
        if imageView == club10{
            selectedCards.append((10, "clubs"))
        }
        if imageView == clubJ{
            selectedCards.append((11, "clubs"))
        }
        if imageView == clubQ{
            selectedCards.append((12, "clubs"))
        }
        if imageView == clubK{
            selectedCards.append((13, "clubs"))
        }
        if imageView == clubA{
            selectedCards.append((14, "clubs"))
        }
        if imageView == spade2{
            selectedCards.append((2, "spades"))
        }
        if imageView == spade3{
            selectedCards.append((3, "spades"))
        }
        if imageView == spade4{
            selectedCards.append((4, "spades"))
        }
        if imageView == spade5{
            selectedCards.append((5, "spades"))
        }
        if imageView == spade6{
            selectedCards.append((6, "spades"))
        }
        if imageView == spade7{
            selectedCards.append((7, "spades"))
        }
        if imageView == spade8{
            selectedCards.append((8, "spades"))
        }
        if imageView == spade9{
            selectedCards.append((9, "spades"))
        }
        if imageView == spade10{
            selectedCards.append((10, "spades"))
        }
        if imageView == spadeJ{
            selectedCards.append((11, "spades"))
        }
        if imageView == spadeQ{
            selectedCards.append((12, "spades"))
        }
        if imageView == spadeK{
            selectedCards.append((13, "spades"))
        }
        if imageView == spadeA{
            selectedCards.append((14, "spades"))
        }
        if imageView == heart2{
            selectedCards.append((2, "hearts"))
        }
        if imageView == heart3{
            selectedCards.append((3, "hearts"))
        }
        if imageView == heart4{
            selectedCards.append((4, "hearts"))
        }
        if imageView == heart5{
            selectedCards.append((5, "hearts"))
        }
        if imageView == heart6{
            selectedCards.append((6, "hearts"))
        }
        if imageView == heart7{
            selectedCards.append((7, "hearts"))
        }
        if imageView == heart8{
            selectedCards.append((8, "hearts"))
        }
        if imageView == heart9{
            selectedCards.append((9, "hearts"))
        }
        if imageView == heart10{
            selectedCards.append((10, "hearts"))
        }
        if imageView == heartJ{
            selectedCards.append((11, "hearts"))
        }
        if imageView == heartQ{
            selectedCards.append((12, "hearts"))
        }
        if imageView == heartK{
            selectedCards.append((13, "hearts"))
        }
        if imageView == heartA{
            selectedCards.append((14, "hearts"))
        }
        if imageView == diamond2{
            selectedCards.append((2, "diamonds"))
        }
        if imageView == diamond3{
            selectedCards.append((3, "diamonds"))
        }
        if imageView == diamond4{
            selectedCards.append((4, "diamonds"))
        }
        if imageView == diamond5{
            selectedCards.append((5, "diamonds"))
        }
        if imageView == diamond6{
            selectedCards.append((6, "diamonds"))
        }
        if imageView == diamond7{
            selectedCards.append((7, "diamonds"))
        }
        if imageView == diamond8{
            selectedCards.append((8, "diamonds"))
        }
        if imageView == diamond9{
            selectedCards.append((9, "diamonds"))
        }
        if imageView == diamond10{
            selectedCards.append((10, "diamonds"))
        }
        if imageView == diamondJ{
            selectedCards.append((11, "diamonds"))
        }
        if imageView == diamondQ{
            selectedCards.append((12, "diamonds"))
        }
        if imageView == diamondK{
            selectedCards.append((13, "diamonds"))
        }
        if imageView == diamondA{
            selectedCards.append((14, "diamonds"))
        }
    }
    //selectedCards.index(where: { $0 == card})
    //.map { selectedCards.remove(at: $0) }
    @objc func removeCard(imageView: UIImageView){
        if imageView == club2{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (2,"clubs")})!)
        }
        if imageView == club3{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (3,"clubs")})!)
        }
        if imageView == club4{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (4,"clubs")})!)
        }
        if imageView == club5{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (5,"clubs")})!)
        }
        if imageView == club6{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (6,"clubs")})!)
        }
        if imageView == club7{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (7,"clubs")})!)
        }
        if imageView == club8{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (8,"clubs")})!)
        }
        if imageView == club9{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (9,"clubs")})!)
        }
        if imageView == club10{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (10,"clubs")})!)
        }
        if imageView == clubJ{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (11,"clubs")})!)
        }
        if imageView == clubQ{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (12,"clubs")})!)
        }
        if imageView == clubK{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (13,"clubs")})!)
        }
        if imageView == clubA{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (14,"clubs")})!)
        }
        if imageView == spade2{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (2,"spades")})!)
        }
        if imageView == spade3{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (3,"spades")})!)
        }
        if imageView == spade4{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (4,"spades")})!)
        }
        if imageView == spade5{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (5,"spades")})!)
        }
        if imageView == spade6{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (6,"spades")})!)
        }
        if imageView == spade7{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (7,"spades")})!)
        }
        if imageView == spade8{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (8,"spades")})!)
        }
        if imageView == spade9{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (9,"spades")})!)
        }
        if imageView == spade10{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (10,"spades")})!)
        }
        if imageView == spadeJ{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (11,"spades")})!)
        }
        if imageView == spadeQ{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (12,"spades")})!)
        }
        if imageView == spadeK{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (13,"spades")})!)
        }
        if imageView == spadeA{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (14,"spades")})!)
        }
        if imageView == heart2{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (2,"hearts")})!)
        }
        if imageView == heart3{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (3,"hearts")})!)
        }
        if imageView == heart4{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (4,"hearts")})!)
        }
        if imageView == heart5{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (5,"hearts")})!)
        }
        if imageView == heart6{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (6,"hearts")})!)
        }
        if imageView == heart7{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (7,"hearts")})!)
        }
        if imageView == heart8{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (8,"hearts")})!)
        }
        if imageView == heart9{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (9,"hearts")})!)
        }
        if imageView == heart10{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (10,"hearts")})!)
        }
        if imageView == heartJ{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (11,"hearts")})!)
        }
        if imageView == heartQ{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (12,"hearts")})!)
        }
        if imageView == heartK{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (13,"hearts")})!)
        }
        if imageView == heartA{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (14,"hearts")})!)
        }
        if imageView == diamond2{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (2,"diamonds")})!)
        }
        if imageView == diamond3{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (3,"diamonds")})!)
        }
        if imageView == diamond4{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (4,"diamonds")})!)
        }
        if imageView == diamond5{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (5,"diamonds")})!)
        }
        if imageView == diamond6{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (6,"diamonds")})!)
        }
        if imageView == diamond7{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (7,"diamonds")})!)
        }
        if imageView == diamond8{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (8,"diamonds")})!)
        }
        if imageView == diamond9{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (9,"diamonds")})!)
        }
        if imageView == diamond10{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (10,"diamonds")})!)
        }
        if imageView == diamondJ{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (11,"diamonds")})!)
        }
        if imageView == diamondQ{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (12,"diamonds")})!)
        }
        if imageView == diamondK{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (13,"diamonds")})!)
        }
        if imageView == diamondA{
            selectedCards.remove(at: selectedCards.index(where: {$0 == (14,"diamonds")})!)
        }
    }
    
}
