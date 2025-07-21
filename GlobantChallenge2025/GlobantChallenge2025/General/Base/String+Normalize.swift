//
//  String+Normalize.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 21/07/25.
//

import Foundation

extension String {
    func normalized() -> String {
        folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
            .replacingOccurrences(of: " ", with: "")
    }
}
