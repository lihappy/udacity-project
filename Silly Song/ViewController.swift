//
//  ViewController.swift
//  Silly Song
//
//  Created by Li, Haibo on 1/12/17.
//  Copyright © 2017 Amazon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameField.delegate = self
        
        self.iconImage.image = UIImage(named: "icon")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        self.nameField.text = ""
        self.lyricsView.text = ""
    }

    @IBAction func displayLyrics(_ sender: Any) {
        if (self.nameField.text != nil) {
            self.lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: self.nameField.text!)
        }
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

func shortNameFromName(name: String) -> String {
    let lowercaseName = name.lowercased();
    let vowelSet = CharacterSet.init(charactersIn: "aeiou")
    let range = lowercaseName.rangeOfCharacter(from: vowelSet)
    return range == nil ? lowercaseName : lowercaseName.substring(from: range!.lowerBound)
}

let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameFromName(name: fullName)
    
    let lyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    return lyrics
}
