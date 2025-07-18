//
//  Result+Handlers.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 17/07/25.
//

extension Result {
    func get(onSuccess: (Success) -> Void, onFailure: (Failure) -> Void) {
        _ = self.map(onSuccess).mapError { error in onFailure(error); return error }
    }
}
