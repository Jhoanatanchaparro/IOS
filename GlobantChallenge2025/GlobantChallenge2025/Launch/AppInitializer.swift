//
//  AppInitializer.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 17/07/25.
//
import SwiftUI

struct AppInitializer {
    static func buildRootView() -> some View {
        let service = MovieRemoteService()
        let interactor = MoviesInteractor(service: service)
        let viewModel = CarsListViewModel(interactor: interactor)
        return CarsListView(viewModel: viewModel)
    }
}

