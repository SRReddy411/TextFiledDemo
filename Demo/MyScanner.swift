//
//  MyScanner.swift
//  Demo
//
//  Created by volivesolutions on 09/07/18.
//  Copyright © 2018 volivesolutions. All rights reserved.
//

import Foundation


class MyScanner {
    let string: String
    var index: String.Index
    
    init(_ string: String) {
        self.string = string
        index = string.startIndex
    }
    
    var remains: String { return String(string[index...]) }
    
    /// Skip characters in a string
    ///
    /// This rendition is safe to use with strings that have characters
    /// represented by more than one unicode scalar.
    ///
    /// - Parameter skipString: A string with all of the characters to skip.
    
    func skip(charactersIn skipString: String) {
        while index < string.endIndex, skipString.contains(string[index]) {
            index = string.index(index, offsetBy: 1)
        }
    }
    
    /// Skip characters in character set
    ///
    /// Note, character sets cannot (yet) include characters that are represented by
    /// more than one unicode scalar (e.g. 👩‍👩‍👧‍👦 or 🇯🇵 or 👰🏻). If you want to test
    /// for these multi-unicode characters, you have to use the `String` rendition of
    /// this method.
    ///
    /// This will simply stop scanning if it encounters a multi-unicode character in
    /// the string being scanned (because it knows the `CharacterSet` can only represent
    /// single-unicode characters) and you want to avoid false positives (e.g., mistaking
    /// the Jamaican flag, 🇯🇲, for the Japanese flag, 🇯🇵).
    ///
    /// - Parameter characterSet: The character set to check for membership.
    
    func skip(charactersIn characterSet: CharacterSet) {
        while index < string.endIndex,
            string[index].unicodeScalars.count == 1,
            let character = string[index].unicodeScalars.first,
            characterSet.contains(character) {
                index = string.index(index, offsetBy: 1)
        }
    }
    
}
