//
//  Untitled.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 18/07/25.
//

extension Dictionary {
    func value(for key: Key, or defaultValue: Value) -> Value {
        self[key] ?? defaultValue
    }
}
