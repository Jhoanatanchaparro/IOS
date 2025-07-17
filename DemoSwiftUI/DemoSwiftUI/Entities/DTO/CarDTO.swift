//
//  CarDTO.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 14/07/25.
//

struct CarDTO: Decodable {
    let carId: Int?
    let name: String?
    let releaseDate: String?
    let image: String?
    let description: String?
    let engine: EngineDTO?
    let brand: BrandDTO?
}

extension CarDTO {
    static var mock: CarDTO {
        CarDTO(carId: 1,
               name: "GR Supra",
               releaseDate: "2024-07-15",
               image: "https://example.com/images/gr-supra.png",
               description: "Lightweight Japanese sports car with agile handling.",
               engine: .mock,
               brand: .mock)
    }
}
