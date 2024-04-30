import XCTest
@testable import TWTextEditorSDK

final class TWTextEditorSDKTests: XCTestCase {
    var sut: TWTextEditor!
    
    override  func setUp() {
        sut = TWTextEditor()
    }
  
    
    func testLengthOfTweetWithRandomCharacters_ShouldReturnTrue() {
        //Arrange
        let tweet = "Hello  "
        //Act
        let lengthOfTweet = sut.lengthOf(tweet: tweet)
        //Assert
        
        XCTAssertEqual(lengthOfTweet, 7, "ERROR:- Length of the given tweet  supposed to equal 7")
        
       }
    
    func testLengthOfTweetWithEmoji_ShouldReturnFalse() {
        //Arrange
        let tweet = "😀😀"
        //Act
        let lengthOfTweet = sut.lengthOf(tweet: tweet)
        //Assert
        XCTAssertFalse(lengthOfTweet == tweet.count, "ERROR:- Length of the given tweet with emoji supposed not to equal tweet count")
        
       }
    
    func testCleanAndCountFoundURL_ShoullReturnTrue() {
        //Arrange
        let tweet = "google.com"
        //Act
        let (_, urlLength) = sut.cleanAndCountURLs(text: tweet)
        //Assert
        
        XCTAssertEqual(urlLength, sut.weightOfURL , "ERROR:- Length of the given tweet with  URL not to equal tweet count")
        
    }
    
    func testGivenTweetWithDifferentTypeOfInput_ShouldReturnTrue() {
        //Arrange
        
        let tweet = "google.com😀😀"
        //Act
        
        let lengthOfTweet = sut.lengthOf(tweet: tweet)

        //Assert
        
        XCTAssertEqual(lengthOfTweet, 27 , "ERROR:- Length of the given tweet with emoji and url supposed to equal 27")
    }
    
    // Test case: Length of an empty tweet should be zero
       func testLengthOfEmptyTweet_ShouldReturnZero() {
           // Arrange
           let tweet = ""
           
           // Act
           let lengthOfTweet = sut.lengthOf(tweet: tweet)
           
           // Assert
           XCTAssertEqual(lengthOfTweet, 0, "Length of an empty tweet should be zero")
       }
       
       // Test case: Tweet with multiple whitespace characters
       func testLengthOfTweetWithMultipleWhitespaces_ShouldReturnCorrectLength() {
           // Arrange
           let tweet = "   " // Three spaces
           
           // Act
           let lengthOfTweet = sut.lengthOf(tweet: tweet)
           
           // Assert
           XCTAssertEqual(lengthOfTweet, 3, "Length of tweet with multiple whitespaces should be correct")
       }
       
       // Test case: Tweet with maximum allowed characters
       func testLengthOfTweetWithMaxCharacters_ShouldReturn280() {
           // Arrange
           let tweet = String(repeating: "A", count: 280)
           
           // Act
           let lengthOfTweet = sut.lengthOf(tweet: tweet)
           
           // Assert
           XCTAssertEqual(lengthOfTweet, 280, "Length of a tweet with max characters should be 280")
       }
       
       // Test case: Clean and count URL with different formats
       func testCleanAndCountFoundURLWithDifferentFormats_ShouldReturnCorrectURLLength() {
           // Arrange
           let tweet = "Check out http://google.com and www.example.com"
           
           // Act
           let (_, urlLength) = sut.cleanAndCountURLs(text: tweet)
           
           // Assert
           XCTAssertEqual(urlLength, sut.weightOfURL * 2, "Length of cleaned URLs should match expected URL length")
       }
       
       // Test case: Length of tweet with Unicode characters and emojis
       func testLengthOfTweetWithUnicodeAndEmojis_ShouldReturnCorrectLength() {
           // Arrange
           let tweet = "Hello 👋! ¿Cómo estás? 😀"
           
           // Act
           let lengthOfTweet = sut.lengthOf(tweet: tweet)
           
           // Assert
           XCTAssertEqual(lengthOfTweet, 25, "Length of tweet with Unicode characters and emojis should be correct")
       }
       
       // Test case: Invalid input handling
       func testLengthOfTweetWithInvalidInput_ShouldHandleGracefully() {
           // Arrange
           let tweet = nil as String? // Optional nil
           
           // Act
           let lengthOfTweet = sut.lengthOf(tweet: tweet ?? "")
           
           // Assert
           XCTAssertEqual(lengthOfTweet, 0, "Length of invalid input (nil) should be zero")
       }
       
}
