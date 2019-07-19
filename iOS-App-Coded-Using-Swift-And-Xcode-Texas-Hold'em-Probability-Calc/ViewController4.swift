//
//  ViewController4.swift
//  Texas Hold'em Probability Statistics Calculator
//
//  Created by Brian Barbu on 7/10/18.
//  Copyright © 2018 Brian Barbu. All rights reserved.
//

import UIKit

class ViewController4: UIViewController {
    
    
    @IBOutlet weak var pair: UILabel!
    @IBOutlet weak var twoPair: UILabel!
    @IBOutlet weak var triple: UILabel!
    @IBOutlet weak var straight: UILabel!
    @IBOutlet weak var flush: UILabel!
    @IBOutlet weak var full: UILabel!
    @IBOutlet weak var four: UILabel!
    @IBOutlet weak var straightFlush: UILabel!
    @IBOutlet weak var royalFlush: UILabel!
    @IBOutlet weak var nothing: UILabel!
    
    var maxCount: Int!
    var selectedCards: [(uniqId: Int, uniqId: String)] = []
    
    @IBOutlet weak var card1: UIImageView!
    @IBOutlet weak var card2: UIImageView!
    @IBOutlet weak var card3: UIImageView!
    @IBOutlet weak var card4: UIImageView!
    @IBOutlet weak var card5: UIImageView!
    @IBOutlet weak var card6: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let labelCards = UILabel(frame: CGRect(x: 0, y: 30, width: 300, height: 60))
        labelCards.font = labelCards.font.withSize(16)
        labelCards.numberOfLines = 4
        */
        orderCards()
        showCards()
        /*
        for card in selectedCards{
            let name = String(card.0) + card.1
            labelCards.text = (labelCards.text ?? "") + name
        }
        self.view.addSubview(labelCards)
        */
        calcOdds()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func restart(_ sender: Any) {
        performSegue(withIdentifier: "segueR", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is ViewController){
            let next = segue.destination as! ViewController
            next.maxCount = nil
            next.selectedCards = []
        }
    }
    @objc func calcOdds(){
        let pairtext = String(format: "%.3f",calcPair())
        pair.text = "\(pairtext)%"
        let twopairtext = String(format: "%.3f",calcTwoPair())
        twoPair.text = "\(twopairtext)%"
        let tripletext = String(format: "%.3f",calcTrip())
        triple.text = "\(tripletext)%"
        let fourtext = String(format: "%.3f",calcFour())
        four.text = "\(fourtext)%"
        let flushtext = String(format: "%.3f",calcFlush())
        flush.text = "\(flushtext)%"
        let fulltext = String(format: "%.3f",calcFull())
        full.text = "\(fulltext)%"
        let straighttext = String(format: "%.3f",calcStraight())
        straight.text = "\(straighttext)%"
        let straightflushtext = String(format: "%.3f", calcStraightFlush())
        straightFlush.text = "\(straightflushtext)%"
        let royalflushtext = String(format: "%.3f", calcRoyalFlush())
        royalFlush.text = "\(royalflushtext)%"
        let nothingtext = String(format: "%.3f", calcNothing())
        nothing.text = "\(nothingtext)%"
    }
    func orderCards(){
        var sortedCards: [(uniqId: Int, uniqId: String)] = []
        for index in 2...14{
            for card in selectedCards{
                if card.0 == index{
                    sortedCards.append(card)
                }
            }
        }
        selectedCards = sortedCards
        //selectedCards.remove(at: selectedCards.index(where: {$0 == (13,"diamonds")})!)
    }
    func showCards(){
        let imageList: [UIImageView] = [card1, card2, card3, card4, card5, card6]
        for card in selectedCards{
            for image in imageList{
                if image.image == nil{
                    if(card.0 == 2 && card.1 == "clubs"){
                        image.image = UIImage(named: "2clubs")
                    }
                    else if(card.0 == 3 && card.1 == "clubs"){
                        image.image = UIImage(named: "3clubs")
                    }
                    else if(card.0 == 4 && card.1 == "clubs"){
                        image.image = UIImage(named: "4clubs")
                    }
                    else if(card.0 == 5 && card.1 == "clubs"){
                        image.image = UIImage(named: "5clubs")
                    }
                    else if(card.0 == 6 && card.1 == "clubs"){
                        image.image = UIImage(named: "6clubs")
                    }
                    else if(card.0 == 7 && card.1 == "clubs"){
                        image.image = UIImage(named: "7clubs")
                    }
                    else if(card.0 == 8 && card.1 == "clubs"){
                        image.image = UIImage(named: "8clubs")
                    }
                    else if(card.0 == 9 && card.1 == "clubs"){
                        image.image = UIImage(named: "9clubs")
                    }
                    else if(card.0 == 10 && card.1 == "clubs"){
                        image.image = UIImage(named: "10clubs")
                    }
                    else if(card.0 == 11 && card.1 == "clubs"){
                        image.image = UIImage(named: "Jclubs")
                    }
                    else if(card.0 == 12 && card.1 == "clubs"){
                        image.image = UIImage(named: "Qclubs")
                    }
                    else if(card.0 == 13 && card.1 == "clubs"){
                        image.image = UIImage(named: "Kclubs")
                    }
                    else if(card.0 == 14 && card.1 == "clubs"){
                        image.image = UIImage(named: "Aclubs")
                    }
                    else if(card.0 == 2 && card.1 == "spades"){
                        image.image = UIImage(named: "2spades")
                    }
                    else if(card.0 == 3 && card.1 == "spades"){
                        image.image = UIImage(named: "3spades")
                    }
                    else if(card.0 == 4 && card.1 == "spades"){
                        image.image = UIImage(named: "4spades")
                    }
                    else if(card.0 == 5 && card.1 == "spades"){
                        image.image = UIImage(named: "5spades")
                    }
                    else if(card.0 == 6 && card.1 == "spades"){
                        image.image = UIImage(named: "6spades")
                    }
                    else if(card.0 == 7 && card.1 == "spades"){
                        image.image = UIImage(named: "7spades")
                    }
                    else if(card.0 == 8 && card.1 == "spades"){
                        image.image = UIImage(named: "8spades")
                    }
                    else if(card.0 == 9 && card.1 == "spades"){
                        image.image = UIImage(named: "9spades")
                    }
                    else if(card.0 == 10 && card.1 == "spades"){
                        image.image = UIImage(named: "10spades")
                    }
                    else if(card.0 == 11 && card.1 == "spades"){
                        image.image = UIImage(named: "Jspades")
                    }
                    else if(card.0 == 12 && card.1 == "spades"){
                        image.image = UIImage(named: "Qspades")
                    }
                    else if(card.0 == 13 && card.1 == "spades"){
                        image.image = UIImage(named: "Kspades")
                    }
                    else if(card.0 == 14 && card.1 == "spades"){
                        image.image = UIImage(named: "Aspades")
                    }
                    else if(card.0 == 2 && card.1 == "hearts"){
                        image.image = UIImage(named: "2hearts")
                    }
                    else if(card.0 == 3 && card.1 == "hearts"){
                        image.image = UIImage(named: "3hearts")
                    }
                    else if(card.0 == 4 && card.1 == "hearts"){
                        image.image = UIImage(named: "4hearts")
                    }
                    else if(card.0 == 5 && card.1 == "hearts"){
                        image.image = UIImage(named: "5hearts")
                    }
                    else if(card.0 == 6 && card.1 == "hearts"){
                        image.image = UIImage(named: "6hearts")
                    }
                    else if(card.0 == 7 && card.1 == "hearts"){
                        image.image = UIImage(named: "7hearts")
                    }
                    else if(card.0 == 8 && card.1 == "hearts"){
                        image.image = UIImage(named: "8hearts")
                    }
                    else if(card.0 == 9 && card.1 == "hearts"){
                        image.image = UIImage(named: "9hearts")
                    }
                    else if(card.0 == 10 && card.1 == "hearts"){
                        image.image = UIImage(named: "10hearts")
                    }
                    else if(card.0 == 11 && card.1 == "hearts"){
                        image.image = UIImage(named: "Jhearts")
                    }
                    else if(card.0 == 12 && card.1 == "hearts"){
                        image.image = UIImage(named: "Qhearts")
                    }
                    else if(card.0 == 13 && card.1 == "hearts"){
                        image.image = UIImage(named: "Khearts")
                    }
                    else if(card.0 == 14 && card.1 == "hearts"){
                        image.image = UIImage(named: "Ahearts")
                    }
                    else if(card.0 == 2 && card.1 == "diamonds"){
                        image.image = UIImage(named: "2diamonds")
                    }
                    else if(card.0 == 3 && card.1 == "diamonds"){
                        image.image = UIImage(named: "3diamonds")
                    }
                    else if(card.0 == 4 && card.1 == "diamonds"){
                        image.image = UIImage(named: "4diamonds")
                    }
                    else if(card.0 == 5 && card.1 == "diamonds"){
                        image.image = UIImage(named: "5diamonds")
                    }
                    else if(card.0 == 6 && card.1 == "diamonds"){
                        image.image = UIImage(named: "6diamonds")
                    }
                    else if(card.0 == 7 && card.1 == "diamonds"){
                        image.image = UIImage(named: "7diamonds")
                    }
                    else if(card.0 == 8 && card.1 == "diamonds"){
                        image.image = UIImage(named: "8diamonds")
                    }
                    else if(card.0 == 9 && card.1 == "diamonds"){
                        image.image = UIImage(named: "9diamonds")
                    }
                    else if(card.0 == 10 && card.1 == "diamonds"){
                        image.image = UIImage(named: "10diamonds")
                    }
                    else if(card.0 == 11 && card.1 == "diamonds"){
                        image.image = UIImage(named: "Jdiamonds")
                    }
                    else if(card.0 == 12 && card.1 == "diamonds"){
                        image.image = UIImage(named: "Qdiamonds")
                    }
                    else if(card.0 == 13 && card.1 == "diamonds"){
                        image.image = UIImage(named: "Kdiamonds")
                    }
                    else if(card.0 == 14 && card.1 == "diamonds"){
                        image.image = UIImage(named: "Adiamonds")
                    }
                    break
                }
            }
        }
    }
    func factorial(num: Int) -> Double{
        var answer: Double = 1
        for index in 1...num{
            answer = answer * Double(index)
        }
        return answer
    }
    func combine(comTup: (Int, Int)) -> Double{
        var answer: Double
        if(comTup.0 == comTup.1){
            answer = 1
        }
        else{
            let factN: Double = factorial(num: comTup.0)
            let factR: Double = factorial(num: comTup.1)
            let factNR: Double = factorial(num: comTup.0 - comTup.1)
            answer = factN / (factR * factNR)
        }
        return answer
    }
    // helper functions
    //counts each card number
    func getNumList() -> [Int]{
        var two:Int = 0
        var three:Int = 0
        var four:Int = 0
        var five:Int = 0
        var six:Int = 0
        var seven:Int = 0
        var eight:Int = 0
        var nine:Int = 0
        var ten:Int = 0
        var jack:Int = 0
        var queen:Int = 0
        var king:Int = 0
        var ace:Int = 0
        for card in selectedCards{
            if card.0 == 2{
                two = two + 1
            }
            if card.0 == 3{
                three = three + 1
            }
            if card.0 == 4{
                four = four + 1
            }
            if card.0 == 5{
                five = five + 1
            }
            if card.0 == 6{
                six = six + 1
            }
            if card.0 == 7{
                seven = seven + 1
            }
            if card.0 == 8{
                eight = eight + 1
            }
            if card.0 == 9{
                nine = nine + 1
            }
            if card.0 == 10{
                ten = ten + 1
            }
            if card.0 == 11{
                jack = jack + 1
            }
            if card.0 == 12{
                queen = queen + 1
            }
            if card.0 == 13{
                king = king + 1
            }
            if card.0 == 14{
                ace = ace + 1
            }
        }
        return [two, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace]
    }
    //counts each suit number
    func getSuitList() -> [Int]{
        var spade: Int = 0
        var club: Int = 0
        var heart: Int = 0
        var diamond: Int = 0
        for card in selectedCards{
            if card.1 == "clubs"{
                club = club + 1
            }
            if card.1 == "spades"{
                spade = spade + 1
            }
            if card.1 == "hearts"{
                heart = heart + 1
            }
            if card.1 == "diamonds"{
                diamond = diamond + 1
            }
        }
        return [club, spade, heart, diamond]
    }
    //count exactly pairs
    func countPair() -> Int{
        var pairCount = 0
        let numCountList = getNumList()
        for count in numCountList{
            if count == 2{
                pairCount = pairCount + 1
            }
        }
        return pairCount
    }
    //count exactly triples
    func countTrip() -> Int{
        var tripCount = 0
        let numCountList = getNumList()
        for count in numCountList{
            if count == 3{
                tripCount = tripCount + 1
            }
        }
        return tripCount
    }
    //10 straight possibilities
    func countStraightPossib() -> [Int]{
        var straight26: Int = 0
        var straight37: Int = 0
        var straight48: Int = 0
        var straight59: Int = 0
        var straight610: Int = 0
        var straight711: Int = 0
        var straight812: Int = 0
        var straight913: Int = 0
        var straight1014: Int = 0
        var straight145: Int = 0
        if(selectedCards.contains(where: { $0.0 == 2})){
            straight26 = straight26 + 1
            straight145 = straight145 + 1
        }
        if(selectedCards.contains(where: { $0.0 == 3})){
            straight26 = straight26 + 1
            straight37 = straight37 + 1
            straight145 = straight145 + 1
        }
        if(selectedCards.contains(where: { $0.0 == 4})){
            straight26 = straight26 + 1
            straight37 = straight37 + 1
            straight48 = straight48 + 1
            straight145 = straight145 + 1
        }
        if(selectedCards.contains(where: { $0.0 == 5})){
            straight26 = straight26 + 1
            straight37 = straight37 + 1
            straight48 = straight48 + 1
            straight59 = straight59 + 1
            straight145 = straight145 + 1
        }
        if(selectedCards.contains(where: { $0.0 == 6})){
            straight26 = straight26 + 1
            straight37 = straight37 + 1
            straight48 = straight48 + 1
            straight59 = straight59 + 1
            straight610 = straight610 + 1
        }
        if(selectedCards.contains(where: { $0.0 == 7})){
            straight37 = straight37 + 1
            straight48 = straight48 + 1
            straight59 = straight59 + 1
            straight610 = straight610 + 1
            straight711 = straight711 + 1
        }
        if(selectedCards.contains(where: { $0.0 == 8})){
            straight48 = straight48 + 1
            straight59 = straight59 + 1
            straight610 = straight610 + 1
            straight711 = straight711 + 1
            straight812 = straight812 + 1
        }
        if(selectedCards.contains(where: { $0.0 == 9})){
            straight59 = straight59 + 1
            straight610 = straight610 + 1
            straight711 = straight711 + 1
            straight812 = straight812 + 1
            straight913 = straight913 + 1
        }
        if(selectedCards.contains(where: { $0.0 == 10})){
            straight610 = straight610 + 1
            straight711 = straight711 + 1
            straight812 = straight812 + 1
            straight913 = straight913 + 1
            straight1014 = straight1014 + 1
        }
        if(selectedCards.contains(where: { $0.0 == 11})){
            straight711 = straight711 + 1
            straight812 = straight812 + 1
            straight913 = straight913 + 1
            straight1014 = straight1014 + 1
        }
        if(selectedCards.contains(where: { $0.0 == 12})){
            straight812 = straight812 + 1
            straight913 = straight913 + 1
            straight1014 = straight1014 + 1
        }
        if(selectedCards.contains(where: { $0.0 == 13})){
            straight913 = straight913 + 1
            straight1014 = straight1014 + 1
        }
        if(selectedCards.contains(where: { $0.0 == 14})){
            straight1014 = straight1014 + 1
            straight145 = straight145 + 1
        }
        return [straight26, straight37, straight48, straight59, straight610, straight711, straight812, straight913, straight1014, straight145]
    }
    //each straight is an [Int] in [[Int]] of the four suits, so 10 possbile straights each as a [Int] in [[Int]]
    func countStraightFlushPossib() -> [[Int]]{
        var straight26: [Int] = [0,0,0,0]
        var straight37: [Int] = [0,0,0,0]
        var straight48: [Int] = [0,0,0,0]
        var straight59: [Int] = [0,0,0,0]
        var straight610: [Int] = [0,0,0,0]
        var straight711: [Int] = [0,0,0,0]
        var straight812: [Int] = [0,0,0,0]
        var straight913: [Int] = [0,0,0,0]
        var straight1014: [Int] = [0,0,0,0]
        var straight145: [Int] = [0,0,0,0]
        for card in selectedCards{
            if(card.0 == 2){
                if(card.1 == "clubs"){
                    straight26[0] = straight26[0] + 1
                    straight145[0] = straight145[0] + 1
                }
                else if(card.1 == "spades"){
                    straight26[1] = straight26[1] + 1
                    straight145[1] = straight145[1] + 1
                }
                else if(card.1 == "hearts"){
                    straight26[2] = straight26[2] + 1
                    straight145[2] = straight145[2] + 1
                }
                else if(card.1 == "diamonds"){
                    straight26[3] = straight26[3] + 1
                    straight145[3] = straight145[3] + 1
                }
            }
            else if(card.0 == 3){
                if(card.1 == "clubs"){
                    straight26[0] = straight26[0] + 1
                    straight37[0] = straight37[0] + 1
                    straight145[0] = straight145[0] + 1
                }
                else if(card.1 == "spades"){
                    straight26[1] = straight26[1] + 1
                    straight37[1] = straight37[1] + 1
                    straight145[1] = straight145[1] + 1
                }
                else if(card.1 == "hearts"){
                    straight26[2] = straight26[2] + 1
                    straight37[2] = straight37[2] + 1
                    straight145[2] = straight145[2] + 1
                }
                else if(card.1 == "diamonds"){
                    straight26[3] = straight26[3] + 1
                    straight37[3] = straight37[3] + 1
                    straight145[3] = straight145[3] + 1
                }
            }
            else if(card.0 == 4){
                if(card.1 == "clubs"){
                    straight26[0] = straight26[0] + 1
                    straight37[0] = straight37[0] + 1
                    straight48[0] = straight48[0] + 1
                    straight145[0] = straight145[0] + 1
                }
                else if(card.1 == "spades"){
                    straight26[1] = straight26[1] + 1
                    straight37[1] = straight37[1] + 1
                    straight48[1] = straight48[1] + 1
                    straight145[1] = straight145[1] + 1
                }
                else if(card.1 == "hearts"){
                    straight26[2] = straight26[2] + 1
                    straight37[2] = straight37[2] + 1
                    straight48[2] = straight48[2] + 1
                    straight145[2] = straight145[2] + 1
                }
                else if(card.1 == "diamonds"){
                    straight26[3] = straight26[3] + 1
                    straight37[3] = straight37[3] + 1
                    straight48[3] = straight48[3] + 1
                    straight145[3] = straight145[3] + 1
                }
            }
            else if(card.0 == 5){
                if(card.1 == "clubs"){
                    straight26[0] = straight26[0] + 1
                    straight37[0] = straight37[0] + 1
                    straight48[0] = straight48[0] + 1
                    straight59[0] = straight59[0] + 1
                    straight145[0] = straight145[0] + 1
                }
                else if(card.1 == "spades"){
                    straight26[1] = straight26[1] + 1
                    straight37[1] = straight37[1] + 1
                    straight48[1] = straight48[1] + 1
                    straight59[1] = straight59[1] + 1
                    straight145[1] = straight145[1] + 1
                }
                else if(card.1 == "hearts"){
                    straight26[2] = straight26[2] + 1
                    straight37[2] = straight37[2] + 1
                    straight48[2] = straight48[2] + 1
                    straight59[2] = straight59[2] + 1
                    straight145[2] = straight145[2] + 1
                }
                else if(card.1 == "diamonds"){
                    straight26[3] = straight26[3] + 1
                    straight37[3] = straight37[3] + 1
                    straight48[3] = straight48[3] + 1
                    straight59[3] = straight59[3] + 1
                    straight145[3] = straight145[3] + 1
                }
            }
            else if(card.0 == 6){
                if(card.1 == "clubs"){
                    straight26[0] = straight26[0] + 1
                    straight37[0] = straight37[0] + 1
                    straight48[0] = straight48[0] + 1
                    straight59[0] = straight59[0] + 1
                    straight610[0] = straight610[0] + 1
                }
                else if(card.1 == "spades"){
                    straight26[1] = straight26[1] + 1
                    straight37[1] = straight37[1] + 1
                    straight48[1] = straight48[1] + 1
                    straight59[1] = straight59[1] + 1
                    straight610[1] = straight610[1] + 1
                }
                else if(card.1 == "hearts"){
                    straight26[2] = straight26[2] + 1
                    straight37[2] = straight37[2] + 1
                    straight48[2] = straight48[2] + 1
                    straight59[2] = straight59[2] + 1
                    straight610[2] = straight610[2] + 1
                }
                else if(card.1 == "diamonds"){
                    straight26[3] = straight26[3] + 1
                    straight37[3] = straight37[3] + 1
                    straight48[3] = straight48[3] + 1
                    straight59[3] = straight59[3] + 1
                    straight610[3] = straight610[3] + 1
                }
            }
            else if(card.0 == 7){
                if(card.1 == "clubs"){
                    straight37[0] = straight37[0] + 1
                    straight48[0] = straight48[0] + 1
                    straight59[0] = straight59[0] + 1
                    straight610[0] = straight610[0] + 1
                    straight711[0] = straight711[0] + 1
                }
                else if(card.1 == "spades"){
                    straight37[1] = straight37[1] + 1
                    straight48[1] = straight48[1] + 1
                    straight59[1] = straight59[1] + 1
                    straight610[1] = straight610[1] + 1
                    straight711[1] = straight711[1] + 1
                }
                else if(card.1 == "hearts"){
                    straight37[2] = straight37[2] + 1
                    straight48[2] = straight48[2] + 1
                    straight59[2] = straight59[2] + 1
                    straight610[2] = straight610[2] + 1
                    straight711[2] = straight711[2] + 1
                }
                else if(card.1 == "diamonds"){
                    straight37[3] = straight37[3] + 1
                    straight48[3] = straight48[3] + 1
                    straight59[3] = straight59[3] + 1
                    straight610[3] = straight610[3] + 1
                    straight711[3] = straight711[3] + 1
                }
            }
            else if(card.0 == 8){
                if(card.1 == "clubs"){
                    straight48[0] = straight48[0] + 1
                    straight59[0] = straight59[0] + 1
                    straight610[0] = straight610[0] + 1
                    straight711[0] = straight711[0] + 1
                    straight812[0] = straight812[0] + 1
                }
                else if(card.1 == "spades"){
                    straight48[1] = straight48[1] + 1
                    straight59[1] = straight59[1] + 1
                    straight610[1] = straight610[1] + 1
                    straight711[1] = straight711[1] + 1
                    straight812[1] = straight812[1] + 1
                }
                else if(card.1 == "hearts"){
                    straight48[2] = straight48[2] + 1
                    straight59[2] = straight59[2] + 1
                    straight610[2] = straight610[2] + 1
                    straight711[2] = straight711[2] + 1
                    straight812[2] = straight812[2] + 1
                }
                else if(card.1 == "diamonds"){
                    straight48[3] = straight48[3] + 1
                    straight59[3] = straight59[3] + 1
                    straight610[3] = straight610[3] + 1
                    straight711[3] = straight711[3] + 1
                    straight812[3] = straight812[3] + 1
                }
            }
            else if(card.0 == 9){
                if(card.1 == "clubs"){
                    straight59[0] = straight59[0] + 1
                    straight610[0] = straight610[0] + 1
                    straight711[0] = straight711[0] + 1
                    straight812[0] = straight812[0] + 1
                    straight913[0] = straight913[0] + 1
                }
                else if(card.1 == "spades"){
                    straight59[1] = straight59[1] + 1
                    straight610[1] = straight610[1] + 1
                    straight711[1] = straight711[1] + 1
                    straight812[1] = straight812[1] + 1
                    straight913[1] = straight913[1] + 1
                }
                else if(card.1 == "hearts"){
                    straight59[2] = straight59[2] + 1
                    straight610[2] = straight610[2] + 1
                    straight711[2] = straight711[2] + 1
                    straight812[2] = straight812[2] + 1
                    straight913[2] = straight913[2] + 1
                }
                else if(card.1 == "diamonds"){
                    straight59[3] = straight59[3] + 1
                    straight610[3] = straight610[3] + 1
                    straight711[3] = straight711[3] + 1
                    straight812[3] = straight812[3] + 1
                    straight913[3] = straight913[3] + 1
                }
            }
            else if(card.0 == 10){
                if(card.1 == "clubs"){
                    straight610[0] = straight610[0] + 1
                    straight711[0] = straight711[0] + 1
                    straight812[0] = straight812[0] + 1
                    straight913[0] = straight913[0] + 1
                    straight1014[0] = straight1014[0] + 1
                }
                else if(card.1 == "spades"){
                    straight610[1] = straight610[1] + 1
                    straight711[1] = straight711[1] + 1
                    straight812[1] = straight812[1] + 1
                    straight913[1] = straight913[1] + 1
                    straight1014[1] = straight1014[1] + 1
                }
                else if(card.1 == "hearts"){
                    straight610[2] = straight610[2] + 1
                    straight711[2] = straight711[2] + 1
                    straight812[2] = straight812[2] + 1
                    straight913[2] = straight913[2] + 1
                    straight1014[2] = straight1014[2] + 1
                }
                else if(card.1 == "diamonds"){
                    straight610[3] = straight610[3] + 1
                    straight711[3] = straight711[3] + 1
                    straight812[3] = straight812[3] + 1
                    straight913[3] = straight913[3] + 1
                    straight1014[3] = straight1014[3] + 1
                }
            }
            else if(card.0 == 11){
                if(card.1 == "clubs"){
                    straight711[0] = straight711[0] + 1
                    straight812[0] = straight812[0] + 1
                    straight913[0] = straight913[0] + 1
                    straight1014[0] = straight1014[0] + 1
                }
                else if(card.1 == "spades"){
                    straight711[1] = straight711[1] + 1
                    straight812[1] = straight812[1] + 1
                    straight913[1] = straight913[1] + 1
                    straight1014[1] = straight1014[1] + 1
                }
                else if(card.1 == "hearts"){
                    straight711[2] = straight711[2] + 1
                    straight812[2] = straight812[2] + 1
                    straight913[2] = straight913[2] + 1
                    straight1014[2] = straight1014[2] + 1
                }
                else if(card.1 == "diamonds"){
                    straight711[3] = straight711[3] + 1
                    straight812[3] = straight812[3] + 1
                    straight913[3] = straight913[3] + 1
                    straight1014[3] = straight1014[3] + 1
                }
            }
            else if(card.0 == 12){
                if(card.1 == "clubs"){
                    straight812[0] = straight812[0] + 1
                    straight913[0] = straight913[0] + 1
                    straight1014[0] = straight1014[0] + 1
                }
                else if(card.1 == "spades"){
                    straight812[1] = straight812[1] + 1
                    straight913[1] = straight913[1] + 1
                    straight1014[1] = straight1014[1] + 1
                }
                else if(card.1 == "hearts"){
                    straight812[2] = straight812[2] + 1
                    straight913[2] = straight913[2] + 1
                    straight1014[2] = straight1014[2] + 1
                }
                else if(card.1 == "diamonds"){
                    straight812[3] = straight812[3] + 1
                    straight913[3] = straight913[3] + 1
                    straight1014[3] = straight1014[3] + 1
                }
            }
            else if(card.0 == 13){
                if(card.1 == "clubs"){
                    straight913[0] = straight913[0] + 1
                    straight1014[0] = straight1014[0] + 1
                }
                else if(card.1 == "spades"){
                    straight913[1] = straight913[1] + 1
                    straight1014[1] = straight1014[1] + 1
                }
                else if(card.1 == "hearts"){
                    straight913[2] = straight913[2] + 1
                    straight1014[2] = straight1014[2] + 1
                }
                else if(card.1 == "diamonds"){
                    straight913[3] = straight913[3] + 1
                    straight1014[3] = straight1014[3] + 1
                }
            }
            else if(card.0 == 14){
                if(card.1 == "clubs"){
                    straight1014[0] = straight1014[0] + 1
                    straight145[0] = straight145[0] + 1
                }
                else if(card.1 == "spades"){
                    straight1014[1] = straight1014[1] + 1
                    straight145[1] = straight145[1] + 1
                }
                else if(card.1 == "hearts"){
                    straight1014[2] = straight1014[2] + 1
                    straight145[2] = straight145[2] + 1
                }
                else if(card.1 == "diamonds"){
                    straight1014[3] = straight1014[3] + 1
                    straight145[3] = straight145[3] + 1
                }
            }
        }
        return [straight26, straight37, straight48, straight59, straight610, straight711, straight812, straight913, straight1014, straight145]
    }
    
    //four suits int counts in [Int]
    func countRoyalFlushPossib() -> [Int]{
        var clubs: Int = 0
        var spades: Int = 0
        var hearts: Int = 0
        var diamonds: Int = 0
        for card in selectedCards{
            if(card.0 == 10){
                if(card.1 == "clubs"){
                    clubs = clubs + 1
                }
                else if(card.1 == "spades"){
                    spades = spades + 1
                }
                else if(card.1 == "hearts"){
                    hearts = hearts + 1
                }
                else if(card.1 == "diamonds"){
                    diamonds = diamonds + 1
                }
            }
            else if(card.0 == 11){
                if(card.1 == "clubs"){
                    clubs = clubs + 1
                }
                else if(card.1 == "spades"){
                    spades = spades + 1
                }
                else if(card.1 == "hearts"){
                    hearts = hearts + 1
                }
                else if(card.1 == "diamonds"){
                    diamonds = diamonds + 1
                }
            }
            else if(card.0 == 12){
                if(card.1 == "clubs"){
                    clubs = clubs + 1
                }
                else if(card.1 == "spades"){
                    spades = spades + 1
                }
                else if(card.1 == "hearts"){
                    hearts = hearts + 1
                }
                else if(card.1 == "diamonds"){
                    diamonds = diamonds + 1
                }
            }
            else if(card.0 == 13){
                if(card.1 == "clubs"){
                    clubs = clubs + 1
                }
                else if(card.1 == "spades"){
                    spades = spades + 1
                }
                else if(card.1 == "hearts"){
                    hearts = hearts + 1
                }
                else if(card.1 == "diamonds"){
                    diamonds = diamonds + 1
                }
            }
            else if(card.0 == 14){
                if(card.1 == "clubs"){
                    clubs = clubs + 1
                }
                else if(card.1 == "spades"){
                    spades = spades + 1
                }
                else if(card.1 == "hearts"){
                    hearts = hearts + 1
                }
                else if(card.1 == "diamonds"){
                    diamonds = diamonds + 1
                }
            }
        }
        return [clubs, spades, hearts, diamonds]
    }
    //true if a pair exists
    func isPair() -> Bool{
        /*_ = selectedCards.sort{if(($0.0 == $1.0)){
         yes = 1
         }
         return true
         }
         */
        var pairCount = 0
        let numCountList = getNumList()
        for count in numCountList{
            if count >= 2{
                pairCount = pairCount + 1
            }
        }
        if pairCount > 0{
            return true
        }
        else{
            return false
        }
    }
    //true if two pairs exist
    func isTwoPair() -> Bool{
        var pairCount = 0
        let numCountList = getNumList()
        for count in numCountList{
            if count >= 2{
                pairCount = pairCount + 1
            }
        }
        if pairCount > 1{
            return true
        }
        else{
            return false
        }
    }
    //true if a triple exists
    func isTriple() -> Bool{
        var tripCount = 0
        let numCountList = getNumList()
        for count in numCountList{
            if count >= 3{
                tripCount = tripCount + 1
            }
        }
        if tripCount > 0{
            return true
        }
        else{
            return false
        }
    }
    //true if a pair and a triple exist
    func isFullHouse() -> Bool{
        var pairCount = 0
        var tripCount = 0
        var fourCount = 0
        let numCountList = getNumList()
        for count in numCountList{
            if count == 2{
                pairCount = pairCount + 1
            }
            if count == 3{
                tripCount = tripCount + 1
            }
            if count == 4{
                fourCount = fourCount + 1
            }
        }
        if (fourCount > 0) && (tripCount > 0 || pairCount > 0){
            return true
        }
        else if (tripCount == 2){
            return true
        }
        else if (tripCount == 1) && (pairCount > 0){
            return true
        }
        else{
            return false
        }
    }
    //true if four of a kidn exists
    func isFour() -> Bool{
        var fourCount = 0
        let numCountList = getNumList()
        for count in numCountList{
            if count >= 4{
                fourCount = fourCount + 1
            }
        }
        if fourCount > 0{
            return true
        }
        else{
            return false
        }
    }
    //true if a full straight exists
    func isStraight() -> Bool{
        var yesstraight = false
        let straightCount = countStraightPossib()
        for straight in straightCount{
            if straight == 5{
                yesstraight = true
            }
        }
        return yesstraight
    }
    //true if 5 cards of same suit exist
    func isFlush() -> Bool{
        var yesflush = false
        let suitList = getSuitList()
        for count in suitList{
            if count >= 5{
                yesflush = true
            }
        }
        return yesflush
    }
    //true if 5 cards of same suit in straight exist
     func isStraightFlush() -> Bool{
        var yesStraightFlush = false
        let possibStraightFlush = countStraightFlushPossib()
        for straightType in possibStraightFlush{
            for suitType in straightType{
                if suitType == 5{
                    yesStraightFlush = true
                }
            }
        }
        return yesStraightFlush
        /*
        var suitType: Int = -1
        let suitList = getSuitList()
        var suit: String = ""
        for count in suitList{
            if count >= 5{
                suitType = suitList.index(of: count)!
            }
        }
        if(suitType == -1){
            return false
        }
        else{
            if(suitType == 0){
                suit = "clubs"
            }
            else if(suitType == 1){
                suit = "spades"
            }
            else if(suitType == 2){
                suit = "hearts"
            }
            else if(suitType == 3){
                suit = "diamonds"
            }
            if(selectedCards.contains(where: { $0.0 == 2 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 3 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 4 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 5 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 6 && $0.1 == suit})){
                return true
            }
            else if(selectedCards.contains(where: { $0.0 == 3 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 4 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 5 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 6 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 7 && $0.1 == suit})){
                return true
            }
            else if(selectedCards.contains(where: { $0.0 == 4 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 5 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 6 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 7 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 8 && $0.1 == suit})){
                return true
            }
            else if(selectedCards.contains(where: { $0.0 == 5 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 6 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 7 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 8 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 9 && $0.1 == suit})){
                return true
            }
            else if(selectedCards.contains(where: { $0.0 == 6 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 7 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 8 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 9 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 10 && $0.1 == suit})){
                return true
            }
            else if(selectedCards.contains(where: { $0.0 == 7 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 8 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 9 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 10 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 11 && $0.1 == suit})){
                return true
            }
            else if(selectedCards.contains(where: { $0.0 == 8 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 9 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 10 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 11 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 12 && $0.1 == suit})){
                return true
            }
            else if(selectedCards.contains(where: { $0.0 == 9 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 10 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 11 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 12 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 13 && $0.1 == suit})){
                return true
            }
            else if(selectedCards.contains(where: { $0.0 == 10 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 11 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 12 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 13 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 14 && $0.1 == suit})){
                return true
            }
            else if(selectedCards.contains(where: { $0.0 == 14 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 2 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 3 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 4 && $0.1 == suit}) && selectedCards.contains(where: { $0.0 == 5 && $0.1 == suit})){
                return true
            }
            else{
                return false
            }
        }
 */
     }
    //true if 5 cards 10 - Ace exist all of the same suit
     func isRoyalFlush() -> Bool{
        var yesRoyalFlush = false
        let possibRoyalFlush = countRoyalFlushPossib()
        for suitType in possibRoyalFlush{
            if suitType == 5{
                yesRoyalFlush = true
            }
        }
        return yesRoyalFlush
        /*
        if(selectedCards.contains(where: { $0.0 == 10 && $0.1 == "clubs"}) && selectedCards.contains(where: { $0.0 == 11 && $0.1 == "clubs"}) && selectedCards.contains(where: { $0.0 == 12 && $0.1 == "clubs"}) && selectedCards.contains(where: { $0.0 == 13 && $0.1 == "clubs"}) && selectedCards.contains(where: { $0.0 == 14 && $0.1 == "clubs"})){
            return true
        }
        else if(selectedCards.contains(where: { $0.0 == 10 && $0.1 == "spades"}) && selectedCards.contains(where: { $0.0 == 11 && $0.1 == "spades"}) && selectedCards.contains(where: { $0.0 == 12 && $0.1 == "spades"}) && selectedCards.contains(where: { $0.0 == 13 && $0.1 == "spades"}) && selectedCards.contains(where: { $0.0 == 14 && $0.1 == "spades"})){
            return true
        }
        else if(selectedCards.contains(where: { $0.0 == 10 && $0.1 == "hearts"}) && selectedCards.contains(where: { $0.0 == 11 && $0.1 == "hearts"}) && selectedCards.contains(where: { $0.0 == 12 && $0.1 == "hearts"}) && selectedCards.contains(where: { $0.0 == 13 && $0.1 == "hearts"}) && selectedCards.contains(where: { $0.0 == 14 && $0.1 == "hearts"})){
            return true
        }
        else if(selectedCards.contains(where: { $0.0 == 10 && $0.1 == "diamonds"}) && selectedCards.contains(where: { $0.0 == 11 && $0.1 == "diamonds"}) && selectedCards.contains(where: { $0.0 == 12 && $0.1 == "diamonds"}) && selectedCards.contains(where: { $0.0 == 13 && $0.1 == "diamonds"}) && selectedCards.contains(where: { $0.0 == 14 && $0.1 == "diamonds"})){
            return true
        }
        else{
            return false
        }
 */
     }
    
    func calcPair() -> Double{
        var answer: Double!
        let amount = selectedCards.count
        if isPair() == true{
            answer = 1.00
        }
        else{
            if (amount == 6){
                answer = 1 - (28/46)
            }
            else if(amount == 5){
                answer = 1 - ((28/46)*(32/47))
            }
            else if(amount == 2){
                let prob1: Double = ((44/50)*(40/49))
                let prob2: Double = ((36/48)*(32/47)*(28/46))
                answer = 1 - (prob1 * prob2)
            }
        }
        return answer * 100
    }
    func calcTwoPair() -> Double{
        var answer: Double!
        let amount = selectedCards.count
        if isTwoPair() == true{
            answer = 1.00
        }
        else{
            if (amount == 6){
                if(isPair()){
                    answer = 1 - (34/46)
                }
                else{
                    answer = 0.0
                }
            }
            else if(amount == 5){
                if(isPair()){
                    answer = 1 - (38/47)*(34/46)
                }
                else{
                    answer = (15/47) * (12/46)
                }
            }
            else if(amount == 2){
                if(isPair()){
                    //prob no twoPair to find prob of two pair
                    let prob1: Double = ((46/49)*(42/48))
                    let prob2: Double = ((38/47)*(34/46))
                    answer = 1 - (prob1*prob2)
                }
                else{
                    let twoPairFromHand: Double = (combine(comTup: (2,1)) * combine(comTup: (3,1)) * combine(comTup: (1,1)) * combine(comTup: (3,1)) * combine(comTup: (48,3))) / combine(comTup: (50,5))
                    let onePairHandOnePairFlop: Double = (combine(comTup: (2,1)) * combine(comTup: (3,1)) * combine(comTup: (11,1)) * combine(comTup: (4,2)) * combine(comTup: (47,2))) / combine(comTup: (50,5))
                    let twoPairFromFlop: Double = (combine(comTup: (11,1)) * combine(comTup: (4,2)) * combine(comTup: (10,1)) * combine(comTup: (4,2)) * combine(comTup: (46,1))) / combine(comTup: (50,5))
                    answer = twoPairFromHand + onePairHandOnePairFlop + twoPairFromFlop
                }
            }
        }
        return answer * 100
    }
    func calcTrip() -> Double{
        var answer: Double!
        let amount = selectedCards.count
        if isTriple() == true{
            answer = 1.00
        }
        else{
            if (amount == 6){
                if(isTwoPair()){
                    answer = 1 - (42/46)
                }
                else if(isPair()){
                    answer = 1 - (44/46)
                }
                else{
                    answer = 0.0
                }
            }
            else if(amount == 5){
                if(isTwoPair()){
                    let tripFromPairs: Double = 1 - ((43/47)*(42/46))
                    let tripFromFifth: Double = (3/47)*(2/46)
                    answer = tripFromPairs + tripFromFifth
                }
                else if(isPair()){
                    let tripFromPair: Double = 1 - ((45/47) * (44/46))
                    let otherTrip: Double = combine(comTup: (3,1)) * combine(comTup: (3,2))
                    let totalPossibs: Double = combine(comTup: (47,2))
                    answer = (tripFromPair + (otherTrip/totalPossibs))
                }
                else{
                    answer = 0.0
                }
            }
            else if(amount == 2){
                if(isPair()){
                    let tripFromPair: Double = ((combine(comTup: (2,1)) * combine(comTup: (49,4))) / combine(comTup: (50,5)))
                    let otherTrips: Double = ((combine(comTup: (12,1)) * combine(comTup: (4,3)) * combine(comTup: (45,2))) / combine(comTup: (50,5)))
                    answer = tripFromPair + otherTrips
                }
                else{
                    let tripFromHand: Double = ((combine(comTup: (2,1)) * combine(comTup: (3,2)) * combine(comTup: (48,3))) / combine(comTup: (50,5)))
                    let tripFromRest: Double = ((combine(comTup: (11,1)) * combine(comTup: (4,3)) * combine(comTup: (47,2))) / combine(comTup: (50,5)))
                    answer = tripFromHand + tripFromRest
                }
            }
        }
        return answer * 100
    }
    func calcFull() -> Double{
        var answer: Double!
        let amount = selectedCards.count
        if isFullHouse() == true{
            answer = 1.00
        }
        else{
            if (amount == 6){
                if isFour(){
                    answer = ((combine(comTup:(2,1)) * combine(comTup:(3,1))) / combine(comTup:(46,1)))
                }
                else if isTriple(){
                    answer = ((combine(comTup:(3,1)) * combine(comTup:(3,1))) / combine(comTup:(46,1)))
                }
                else if isTwoPair(){
                    answer = ((combine(comTup:(2,1)) * combine(comTup:(2,1))) / combine(comTup:(46,1)))
                }
                else{
                    answer = 0.0
                }
            }
            else if(amount == 5){
                if isFour(){
                    let fromNonFlop: Double = ((combine(comTup:(11,1)) * combine(comTup:(4,2))) / combine(comTup:(47,2)))
                    let fromFlop: Double = ((combine(comTup:(1,1)) * combine(comTup:(3,1)) * combine(comTup:(46,1))) / combine(comTup:(47,2)))
                    answer = fromNonFlop + fromFlop
                }
                else if isTriple(){
                    let fromNonFlop: Double = ((combine(comTup:(10,1)) * combine(comTup:(4,2))) / combine(comTup:(47,2)))
                    let fromFlop: Double = ((combine(comTup:(2,1)) * combine(comTup:(3,1)) * combine(comTup:(46,1))) / combine(comTup:(47,2)))
                    answer = fromNonFlop + fromFlop
                }
                else if isTwoPair(){
                    let fromPair: Double = ((combine(comTup:(2,1)) * combine(comTup:(2,1)) * combine(comTup:(46,1))) / combine(comTup:(47,2)))
                    let fromNon: Double = ((combine(comTup:(1,1)) * combine(comTup:(3,2))) / combine(comTup:(47,2)))
                    answer = fromNon + fromPair
                }
                else if isPair(){
                    let fromPair: Double = ((combine(comTup:(1,1)) * combine(comTup:(2,1)) * combine(comTup:(3,1)) * combine(comTup:(3,1))) / combine(comTup:(47,2)))
                    let fromNon: Double = ((combine(comTup:(3,1)) * combine(comTup:(3,2))) / combine(comTup:(47,2)))
                    answer = fromNon + fromPair
                }
                else{
                    answer = 0.0
                }
            }
            else if(amount == 2){
                if isPair(){
                    let tripFromNon: Double = (combine(comTup:(12,1)) * combine(comTup:(4,3)) * combine(comTup:(47,2))) / combine(comTup:(50,5))
                    let tripFromPair: Double = (combine(comTup:(1,1)) * combine(comTup:(2,1)) * combine(comTup:(12,1)) * combine(comTup:(4,2)) * combine(comTup:(47,2))) / combine(comTup:(50,5))
                    let fullFromNon: Double = (combine(comTup:(12,1)) * combine(comTup:(4,3)) * combine(comTup:(11,1)) * combine(comTup:(4,2))) / combine(comTup:(50,5))
                    answer = tripFromNon + tripFromPair + fullFromNon
                }
                else{
                    //this is full from hand
                    let fullFromFlop = (combine(comTup:(2,1)) * combine(comTup:(3,2)) * combine(comTup:(1,1)) * combine(comTup:(3,1)) * combine(comTup:(47,2))) / combine(comTup:(50,5))
                    let tripFromFlopPairFromNon = (combine(comTup:(2,1)) * combine(comTup:(3,2)) * combine(comTup:(11,1)) * combine(comTup:(4,2)) * combine(comTup:(46,1))) / combine(comTup:(50,5))
                    let pairFromFlopTripFromNon = (combine(comTup:(2,1)) * combine(comTup:(3,1)) * combine(comTup:(11,1)) * combine(comTup:(4,3)) * combine(comTup:(46,1))) / combine(comTup:(50,5))
                    // this is full all flop
                    let fullFromNon = (combine(comTup:(11,1)) * combine(comTup:(4,3)) * combine(comTup:(10,1)) * combine(comTup:(4,2))) / combine(comTup:(50,5))
                    answer = fullFromFlop + tripFromFlopPairFromNon + pairFromFlopTripFromNon + fullFromNon
                    
                }
            }
        }
        return answer * 100
    }
    func calcFour() -> Double{
        var answer: Double!
        let amount = selectedCards.count
        if isFour() == true{
            answer = 1.00
        }
        else{
            if (amount == 6){
                let tripCount = countTrip()
                if tripCount == 2{
                    answer = (combine(comTup: (2,1)) * combine(comTup: (1,1))) / combine(comTup: (46,1))
                }
                //or pairCount == 1 && tripCount == 1
                else if(tripCount == 1){
                    answer = (combine(comTup: (1,1)) * combine(comTup: (1,1))) / combine(comTup: (46,1))
                }
                else{
                    answer = 0.00
                }
                
            }
            else if(amount == 5){
                if(isFullHouse()){
                    let fromThree: Double = combine(comTup: (1,1)) * combine(comTup: (1,1)) * combine(comTup: (46,1))
                    let fromTwo: Double = combine(comTup: (1,1)) * combine(comTup: (2,2))
                    answer = (fromThree + fromTwo) / combine(comTup: (47,2))
                }
                else if(isTriple()){
                    answer = (combine(comTup: (1,1)) * combine(comTup: (46,1))) / combine(comTup: (47,2))
                }
                else if(isTwoPair()){
                    answer = (combine(comTup: (2,1)) * combine(comTup: (2,2))) / combine(comTup: (47,2))
                }
                else if(isPair()){
                    answer = (combine(comTup: (1,1)) * combine(comTup: (2,2))) / combine(comTup: (47,2))
                }
                else{
                    answer = 0.00
                }
            }
            else if(amount == 2){
                if(isPair()){
                    let fromPreFlop: Double = combine(comTup: (1,1)) * combine(comTup: (2,2)) * combine(comTup: (48,3))
                    let notPreFlop: Double = combine(comTup: (12,1)) * combine(comTup: (4,4)) * combine(comTup: (46,1))
                    answer = (fromPreFlop + notPreFlop) / combine(comTup: (50,5))
                }
                else{
                    let fromPreFlop: Double = combine(comTup: (2,1)) * combine(comTup: (3,3)) * combine(comTup: (47,2))
                    let notPreFlop: Double = combine(comTup: (11,1)) * combine(comTup: (4,4)) * combine(comTup: (46,1))
                    answer = (fromPreFlop + notPreFlop) / combine(comTup: (50,5))
                }
            }
        }
        return answer * 100
    }
    func calcStraight() -> Double{
        var answer: Double!
        let amount = selectedCards.count
        let straightPossibs: [Int] = countStraightPossib()
        if isStraight(){
            answer = 1.00
        }
        else{
            answer = 0.0
            if (amount == 6){
                for num in straightPossibs{
                    var straightProb: Double = 0.0
                    if(num == 4){
                        straightProb = combine(comTup: (4,1)) / combine(comTup: (46,1))
                    }
                    answer = answer + straightProb
                }
            }
            else if(amount == 5){
                for num in straightPossibs{
                    var straightProb: Double = 0.0
                    if(num == 3){
                        straightProb = (combine(comTup: (4,1)) * combine(comTup: (4,1))) / combine(comTup: (47,2))
                    }
                    else if(num == 4){
                        straightProb = (combine(comTup: (4,1)) * combine(comTup: (46,1))) / combine(comTup: (47,2))
                    }
                    answer = answer + straightProb
                }
            }
            else if(amount == 2){
                for num in straightPossibs{
                    var straightProb: Double = 0.0
                    if(num == 1){
                        straightProb = (combine(comTup: (4,1)) * combine(comTup: (4,1)) * combine(comTup: (4,1)) * combine(comTup: (4,1)) * combine(comTup: (46,1))) / combine(comTup: (50,5))
                    }
                    else if(num == 2){
                        straightProb = (combine(comTup: (4,1)) * combine(comTup: (4,1)) * combine(comTup: (4,1)) * combine(comTup: (47,2))) / combine(comTup: (50,5))
                    }
                    //num == 0
                    else{
                        straightProb = (combine(comTup: (4,1)) * combine(comTup: (4,1)) * combine(comTup: (4,1)) * combine(comTup: (4,1)) * combine(comTup: (4,1))) / combine(comTup: (50,5))
                    }
                    answer = answer + straightProb
                }
            }
        }
        return answer * 100
    }
    func calcFlush() -> Double{
        var answer: Double = 0
        let amount = selectedCards.count
        let suitList = getSuitList()
        if isFlush(){
            answer = 1.00
        }
        else{
            if (amount == 6){
                for suit in suitList{
                    var tempAnswer: Double = 0
                    if(suit == 4){
                        tempAnswer = ((combine(comTup: (1,1)) * combine(comTup: (9,1))) / combine(comTup: (46,1)))
                    }
                    answer = answer + tempAnswer
                }
            }
            else if(amount == 5){
                for suit in suitList{
                    var tempAnswer: Double = 0
                    if suit == 3{
                        tempAnswer = ((combine(comTup: (1,1)) * combine(comTup: (10,2))) / combine(comTup: (47,2)))
                    }
                    else if suit == 4{
                        tempAnswer = ((combine(comTup: (1,1)) * combine(comTup: (9,1)) * combine(comTup: (46,1))) / combine(comTup: (47,2)))
                    }
                    answer = answer + tempAnswer
                }
            }
            else if(amount == 2){
                for suit in suitList{
                    var tempAnswer: Double = 0
                    if suit == 2{
                        tempAnswer = (combine(comTup: (1,1)) * combine(comTup: (11,3)) * combine(comTup: (47,2))) / combine(comTup: (50,5))
                    }
                    else if suit == 1{
                        tempAnswer = (combine(comTup: (1,1)) * combine(comTup: (12,4)) * combine(comTup: (46,1))) / combine(comTup: (50,5))
                    }
                    answer = answer + tempAnswer
                }
            }
        }
        return answer * 100
    }
    func calcStraightFlush() -> Double{
        var answer: Double = 0
        let amount = selectedCards.count
        let straightFlushPossibs: [[Int]] = countStraightFlushPossib()
        if(isStraightFlush()){
            answer = 1.0
        }
        else{
            if amount == 6{
                for straightType in straightFlushPossibs{
                    for suitType in straightType{
                        var tempAnswer: Double = 0
                        if suitType == 4{
                            tempAnswer = combine(comTup: (1,1)) / combine(comTup:(46,1))
                        }
                        answer = answer + tempAnswer
                    }
                }
            }
            else if amount == 5{
                for straightType in straightFlushPossibs{
                    for suitType in straightType{
                        var tempAnswer: Double = 0
                        if suitType == 4{
                            tempAnswer = (combine(comTup: (1,1)) * combine(comTup: (46,1)))  / combine(comTup:(47,2))
                        }
                        else if(suitType == 3){
                            tempAnswer = (combine(comTup: (1,1)) * combine(comTup: (1,1))) / combine(comTup:(47,2))
                        }
                        answer = answer + tempAnswer
                    }
                }
            }
            else if amount == 2{
                for straightType in straightFlushPossibs{
                    for suitType in straightType{
                        var tempAnswer: Double = 0
                        if suitType == 2{
                            tempAnswer = (combine(comTup: (1,1)) * combine(comTup: (1,1)) * combine(comTup: (1,1)) * combine(comTup: (47,2))) / combine(comTup:(50,5))
                        }
                        else if suitType == 1{
                            tempAnswer = (combine(comTup: (1,1)) * combine(comTup: (1,1)) * combine(comTup: (1,1)) * combine(comTup: (1,1)) * combine(comTup: (46,1))) / combine(comTup:(50,5))
                        }
                        else{
                            tempAnswer = (combine(comTup: (1,1)) * combine(comTup: (1,1)) * combine(comTup: (1,1)) * combine(comTup: (1,1)) * combine(comTup: (1,1))) / combine(comTup:(50,5))
                        }
                        answer = answer + tempAnswer
                    }
                }
            }
        }
        return answer * 100
    }
    func calcRoyalFlush() -> Double{
        var answer: Double = 0
        let amount = selectedCards.count
        let royalPossibs: [Int] = countRoyalFlushPossib()
        if(isRoyalFlush()){
            answer = 1.0
        }
        else{
            if amount == 6{
                for suitType in royalPossibs{
                    var tempAnswer: Double = 0
                    if suitType == 4{
                        tempAnswer = combine(comTup: (1,1)) / combine(comTup: (46,1))
                    }
                    answer = answer + tempAnswer
                }
            }
            else if amount == 5{
                for suitType in royalPossibs{
                    var tempAnswer: Double = 0
                    if suitType == 4{
                        tempAnswer = (combine(comTup: (1,1)) * combine(comTup: (46,1))) / combine(comTup: (47,2))
                    }
                    else if suitType == 3{
                        tempAnswer = (combine(comTup: (1,1)) * combine(comTup: (1,1))) / combine(comTup: (47,2))
                    }
                    answer = answer + tempAnswer
                }
            }
            else if amount == 2{
                for suitType in royalPossibs{
                    var tempAnswer: Double = 0
                    if suitType == 2{
                        tempAnswer = (combine(comTup: (1,1)) * combine(comTup: (1,1)) * combine(comTup: (1,1)) * combine(comTup: (47,2))) / combine(comTup: (50,5))
                    }
                    else if suitType == 1{
                        tempAnswer = (combine(comTup: (1,1)) * combine(comTup: (1,1)) * combine(comTup: (1,1)) * combine(comTup: (1,1)) * combine(comTup: (46,1))) / combine(comTup: (50,5))
                    }
                    //suitType == 0
                    else{
                        tempAnswer = (combine(comTup: (1,1)) * combine(comTup: (1,1)) * combine(comTup: (1,1)) * combine(comTup: (1,1)) * combine(comTup: (1,1))) / combine(comTup: (50,5))
                    }
                    answer = answer + tempAnswer
                }
            }
        }
        return answer * 100
    }
    func calcNothing() -> Double{
        let pairPossib: Double = calcPair() / 100
        let twoPairPossib: Double = calcTwoPair() / 100
        let triplePossib: Double = calcTrip() / 100
        let straightPossib: Double = calcStraight() / 100
        let flushPossib: Double = calcFlush() / 100
        let fourPossib: Double = calcFour() / 100
        let fullPossib: Double = calcFull() / 100
        let straightFlushPossib: Double = calcStraightFlush() / 100
        let royalFlushPossib: Double = calcRoyalFlush() / 100
        let answer: Double = ((1 - pairPossib) * (1 - twoPairPossib) * (1 - triplePossib) * (1 - straightPossib) * (1 - flushPossib) * (1 - fourPossib) * (1 - fullPossib) * (1 - straightFlushPossib) * (1 - royalFlushPossib))
        return answer * 100
    }
    
}
