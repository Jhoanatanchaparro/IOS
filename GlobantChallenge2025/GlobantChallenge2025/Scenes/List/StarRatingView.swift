//
//  StarRatingView.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 25/07/25.
//

import SwiftUI

struct StarRatingView: View {
    let rating: Double  

    private let maxRating = 5

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<maxRating, id: \.self) { index in
                Image(systemName: starType(for: index))
                    .foregroundColor(.yellow)
            }
        }
    }

    private func starType(for index: Int) -> String {
        let scaledRating = rating / 2
        if Double(index) < scaledRating.rounded(.down) {
            return "star.fill"
        } else if Double(index) < scaledRating {
            return "star.leadinghalf.filled"
        } else {
            return "star"
        }
    }
}
