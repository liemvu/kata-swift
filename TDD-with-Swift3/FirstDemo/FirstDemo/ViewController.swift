//
//  ViewController.swift
//  FirstDemo
//
//  Created by Liem Vo on 5/7/17.
//  Copyright © 2017 Cyberbot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfVowels(in string : String) -> Int {
        let vowels: [Character] = ["a", "e", "i", "o", "u",
                                   "A", "E", "I", "O", "U"]
        return string.characters.reduce(0) {
            $0 + (vowels.contains($1) ? 1 : 0)
        }
    }
    
    func makeHeadline(from string: String) -> String {
        var lastChar:Character = Character.init(" ")
        return string.characters.reduce("") {
            let sChar = String(describing: $1)
            let res = $0 + (lastChar == " " ? sChar.uppercased() : sChar)
            lastChar = $1
            return res
        }
    }
}

