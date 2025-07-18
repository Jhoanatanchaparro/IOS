//
//  Error+Result.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 17/07/25.
//

import Foundation
extension Optional where Wrapped == Error {
    func map<T>(_ transform: (Error) -> T) -> Result<T, Error>? {
        self.map { .failure($0) }
    }
}
