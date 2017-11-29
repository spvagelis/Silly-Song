//
//  ViewController.swift
//  Silly Song
//
//  Created by vagelis spirou on 28/11/17.
//  Copyright © 2017 vagelis spirou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var lyricsView: UITextView!
    
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reset(_ sender: Any) {
        
        nameField.text = ""
        lyricsView.text = ""
        
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        
        if let name = nameField.text {
            
            let lyrics = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: name)
            lyricsView.text = lyrics
        }
        
        
    }
    
    func shortNameFromName(name: String) -> String {
        
        var myName = name.lowercased()
        myName = myName.folding(options: .diacriticInsensitive, locale: .current)
        let vowels = "aeiou"
        let setOfVowelsCharacters = CharacterSet(charactersIn: vowels)
        let lowerBound = myName.startIndex
        let upperBound = myName.endIndex
        var correctName = String()
        
        if let rangeOfFristVowel = myName.rangeOfCharacter(from: setOfVowelsCharacters, options: .diacriticInsensitive, range: lowerBound..<upperBound) {
            
            let startIndex = rangeOfFristVowel.lowerBound
            let substring = myName.suffix(from: startIndex)
            
            correctName = String(substring)
        } else {
            
            correctName = myName
        }
        
        return correctName
        
    }
    
    func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
        
        let shortName = shortNameFromName(name: fullName)
        
        let lyrics = lyricsTemplate
            .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
            .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
        
        return lyrics
    }
    

}

extension ViewController: UITextFieldDelegate {
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return false
    }
    
    
}








