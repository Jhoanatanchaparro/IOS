//
//  EngineDTO.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 15/07/25.
//

struct EngineDTO: Decodable {
    let engineId: Int?
    let name: String?
    let hp: Int?
    let nm: Int?
    let size: Double?
}

extension EngineDTO {
    static var mock: EngineDTO {
        EngineDTO(engineId: 0,
                  name: "B58 3.0L I6 Turbo",
                  hp: 382,
                  nm: 500,
                  size: 3)
    }
}
