//
//  Brand.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 16/07/25.
//

import Foundation

struct Brand: Identifiable {
    let id = UUID()
    let brandId: Int
    let name: String
    let origin: String
    private let urlLogo: String
    
    var urlImage: URL? { URL(string: self.urlLogo) }
    
    init(dto: BrandDTO?) {
        self.brandId = dto?.brandId ?? 0
        self.name = dto?.name ?? ""
        self.origin = dto?.origin ?? ""
        self.urlLogo = dto?.urlLogo ?? ""
    }
}
