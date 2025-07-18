//
//  Car.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 16/07/25.
//

import Foundation

struct Car: Identifiable {
    let id = UUID()
    let carId: Int
    let name: String
    let description: String
    let engine: Engine
    let brand: Brand
    
    private let releaseDate: Date?
    private let image: String
    
    var urlImage: URL? { URL(string: self.image) }
    
    var releaseDateShortFormat: String {
        self.releaseDate?.toStringWith("dd MMM 'del' yyyy") ?? "Próximamente"
    }
    
    var releaseDateFullFormat: String {
        self.releaseDate?.toStringWith("EEEE dd 'de' MMMM 'del' yyyy") ?? "Próximamente"
    }
    
    var nameFormat: String {
        "\(self.brand.name) : \(self.name)"
    }
    
    init(dto: CarDTO) {
        self.carId = dto.carId ?? 0
        self.name = dto.name ?? ""
        self.releaseDate = dto.releaseDate?.toDateWith("yyyy-MM-dd")
        self.image = dto.image ?? ""
        self.description = dto.description ?? ""
        self.engine = Engine(dto: dto.engine)
        self.brand = Brand(dto: dto.brand)
    }
}
