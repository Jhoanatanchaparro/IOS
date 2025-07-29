//
//  Localized.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 22/07/25.
//


import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
