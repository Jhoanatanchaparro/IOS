//
//  CarDetailView.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 18/07/25.
//

import SwiftUI

struct CarDetailView: View {
    @ObservedObject var viewModel: CarDetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: viewModel.movie.posterURL) { phase in
                    phase.image?
                        .resizable()
                        .scaledToFit()
                }
                .frame(height: 300)
                .cornerRadius(12)

                Text(viewModel.movie.title)
                    .font(.title)
                    .bold()

                Text(viewModel.movie.overview)
                    .font(.body)

                HStack {
                    Spacer()
                    Image(systemName: viewModel.favoriteStatus.icon)
                        .foregroundColor(viewModel.favoriteStatus.color)
                        .font(.title)
                    Spacer()
                }
            }
            .padding()
        }
        .navigationTitle("Detalle")
    }
}
