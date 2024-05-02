//
//  TWTextEditor.swift
//
//
//  Created by Yousef Elsayed on 30/04/2024.
//

import Foundation

class TWTextEditor {
    
    let weightOfURL: Int = 23
    let weightOfEmoji: Int = 2
    let normalWeight: Int = 1

    public  func cleanAndCountURLs(text: String) -> (String, Int)  {
          var output = text
          var lenght = 0
          let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
          let matches = detector.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
          
          matches.forEach {
              output = (text as NSString).replacingCharacters(in: $0.range, with: "")
              lenght += weightOfURL //23 is the count of characters for any url according to twitter docs
          }
          return (output, lenght)
      }
    
    // Define a function to count characters according to Twitter's criteria
    func countTwitterCharacters(_ input: String) -> Int {
        
        var characterCount = 0
        let (cleanText, urlLength) = cleanAndCountURLs(text: input)
              
        characterCount = urlLength
        
        // Iterate over each char
        for char in cleanText {
            // Add the count for emojis and other characters
            characterCount += char.unicodeScalars.reduce(0) { $0 + ($1.properties.isEmoji ? weightOfEmoji : normalWeight) }
            
        }
        
        return characterCount
    }
   
}
