//
//  TWTextEditorView.swift
//  
//
//  Created by Yousef Elsayed on 30/04/2024.
//

import UIKit

// MARK: - TWTextEditorViewDelegate Protocol

/// Protocol for handling text changes in the TWTextEditorView.
public protocol TWTextEditorViewDelegate: AnyObject {
    func textDidChange(_ textView: UITextView)
}

// MARK: - TWTextEditorView Class

/// A custom text editor view with a delegate and various text-related functionalities.
public class TWTextEditorView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet var view: UIView! // The main view
    @IBOutlet public weak var textView: UITextView! // Text view for text input
    
    // MARK: - Properties
    
    public var placeholderLabel: UILabel! // Label for the placeholder text
    public var maxCountOfCharacters: Int = 280 // Maximum number of characters allowed
    public var typedCharactersCount: Int { twTextEditor?.countTwitterCharacters(self.text) ?? 0 } // Typed characters count
    public var remainingCharactersCount: Int { maxCountOfCharacters - typedCharactersCount } // Remaining characters count
    
    private var text: String { return self.textView.text ?? "" } // Text in the text view
    
    weak public var viewDelegate: TWTextEditorViewDelegate? // Delegate for text changes
    private var twTextEditor: TWTextEditor? // Custom text editor object
    
    // MARK: - Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupNib()
        twTextEditor = TWTextEditor()
    }
    
    // MARK: - Nib Setup
    
    /// Attaches a view to a container.
    private func attach(view: UIView, toContainer container: UIView) {
        container.addSubview(view)
        view.fillSuperview() // Use your existing extension method to fill the container
    }
    
    /// Sets up the custom view from the nib file.
    private func setupNib() {
        UINib(nibName: String(describing: TWTextEditorView.self), bundle: Bundle.module).instantiate(withOwner: self, options: nil)
        attach(view: self.view, toContainer: self)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupTextEditor() // Initialize the text editor
        setupPlaceholder() // Initialize the placeholder
        textView.delegate = self // Set the text view delegate
    }
    
    // MARK: - Text Editor Setup
    
    /// Configures the text editor's visual elements.
    private func setupTextEditor() {
        textView.textColor = .black
        textView.font = .twFontReqularWithSize(size: 14)
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.twBorderColor.cgColor
        textView.keyboardType = .twitter
        view.layer.applyFigmaShadow() // Use your existing CALayer extension
    }
    
    // MARK: - Placeholder Setup
    
    /// Configures the placeholder label in the text view.
    private func setupPlaceholder() {
        placeholderLabel = UILabel()
        placeholderLabel.text = "Start typing! You can enter up to 280 characters."
        placeholderLabel.font = .twFontReqularWithSize(size: 14)
        placeholderLabel.sizeToFit() // Adjust the label size to fit its content
        textView.addSubview(placeholderLabel) // Add the placeholder to the text view
        placeholderLabel.frame.origin = CGPoint(x: 8, y: (textView.font?.pointSize ?? 0) / 2)
        placeholderLabel.textColor = UIColor.twPlaceHolderColor
        placeholderLabel.alpha = textView.text.isEmpty ? 1 : 0 // Show/hide based on text content
    }
    
    // MARK: - Public Functions
    
    /// Dismisses the keyboard when called.
    public func dismissKeyboard() {
        textView.resignFirstResponder() // Resign the text view as first responder
    }
    
    /// Clears all text in the text view.
    public func clearText() {
        textView.text = ""
        textViewDidChange(textView) // Trigger delegate method
    }
    
    /// Copies the current text to the clipboard.
    public func copyCurrentText() {
        UIPasteboard.general.string = text // Copy to clipboard
    }
}

// MARK: - UITextViewDelegate Implementation

extension TWTextEditorView: UITextViewDelegate {
    
    /// Called when the text in the text view changes.
    public func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.alpha = textView.text.isEmpty ? 1 : 0 // Show/hide placeholder
        viewDelegate?.textDidChange(textView) // Notify the delegate
    }
    
    /// Determines if text should be changed based on the character limit.
    public func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String
    ) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // Calculate the new text after applying the change
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        return updatedText.count <= maxCountOfCharacters // Check the character limit
    }
}
