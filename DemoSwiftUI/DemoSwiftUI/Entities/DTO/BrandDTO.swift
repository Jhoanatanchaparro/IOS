//
//  BrandDTO.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 15/07/25.
//

struct BrandDTO: Decodable {
    let brandId: Int?
    let name: String?
    let origin: String?
    let urlLogo: String?
}

extension BrandDTO {
    static var mock: BrandDTO {
        BrandDTO(brandId: 100,
                 name: "Toyota",
                 origin: "Japan",
                 urlLogo: "https://example.com/logos/toyota.png")
    }
}
