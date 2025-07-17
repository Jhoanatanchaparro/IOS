//
//  DateManager.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 16/07/25.
//

import Foundation

extension String {
    func toDateWith(_ format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "es_PE")
        return dateFormatter.date(from: self)
    }
}

extension Date {
    func toStringWith(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "es_PE")
        return dateFormatter.string(from: self)
    }
}
