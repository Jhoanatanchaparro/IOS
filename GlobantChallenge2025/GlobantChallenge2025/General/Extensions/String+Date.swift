//
//  String+Date.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 17/07/25.
//

import Foundation
extension String {
    func toDate(format: String = "yyyy-MM-dd") -> Date? {
        DateFormatter.shared(format: format).date(from: self)
    }
        
    }
extension DateFormatter{
    static func shared(format: String)-> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter
    }
}
