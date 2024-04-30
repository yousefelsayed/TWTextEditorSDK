//
//  File.swift
//  
//
//  Created by Yousef Elsayed on 30/04/2024.
//

import Foundation

class TWTextEditor {
    
    let weightOfURL: Int = 23
    let weightOfEmoji: Int = 2
    let normalWeight: Int = 1
 
    //MARK:- Calculate length of given tweet
   public  func lengthOf(tweet: String) -> Int {
        
        let (cleanText, urlLength) = cleanAndCountURLs(text: tweet)
        
        var weightedLength = urlLength
        
        for char in cleanText {
            if char.isEmoji == true {
                weightedLength += weightOfEmoji //2 is the count of characters for any emoji according to twitter docs
                continue
            } else {
                weightedLength += normalWeight
            }
        }
        
         return weightedLength
     }
    
    
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
}
