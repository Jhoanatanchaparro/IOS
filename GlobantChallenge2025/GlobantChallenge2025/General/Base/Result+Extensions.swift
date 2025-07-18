//
//  Result+Extensions.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 18/07/25.
//

extension Result{
    var successValue: Success? {
        try? get()
    }
}
