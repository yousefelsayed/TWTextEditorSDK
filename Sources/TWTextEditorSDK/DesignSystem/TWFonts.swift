//
//  TWFonts.swift
//
//
//  Created by Yousef Elsayed on 30/04/2024.
//

import UIKit
import Foundation

public let fontBundle = Bundle.module

public func registerFonts() {
    _ = UIFont.registerFont(bundle: .module, fontName: "DINNextLTArabic-Regular", fontExtension: "ttf")
    _ = UIFont.registerFont(bundle: .module, fontName: "DINNextLTArabic-Medium", fontExtension: "ttf")
    _ = UIFont.registerFont(bundle: .module, fontName: "DINNextLTArabic-Bold", fontExtension: "ttf")
}

extension UIFont {
    static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) -> Bool {

        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension) else {
            fatalError("Couldn't find font \(fontName)")
        }

        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
            fatalError("Couldn't load data from the font \(fontName)")
        }

        guard let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }

        var error: Unmanaged<CFError>?
        let success = CTFontManagerRegisterGraphicsFont(font, &error)
        guard success else {
            print("Error registering font: maybe it was already registered.")
            return false
        }

        return true
    }
}

extension UIFont {
    public static func twFontReqularWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: "DINNextLTArabic-Regular", size: size)!
    }
    
    public static func twFontMediumWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: "DINNextLTArabic-Medium", size: size)!
    }
    
    public  static func twFontBoldWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: "DINNextLTArabic-Bold", size: size)!
    }
}
