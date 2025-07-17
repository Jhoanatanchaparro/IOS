//
//  SessionDTO.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 3/07/25.
//

struct SessionDTO: Decodable {
    let token: String
    let name: String
    let lastName: String
}

extension SessionDTO {
    static var mock: SessionDTO {
        SessionDTO(token: "myToken",
                   name: "kenyi",
                   lastName: "rodriguez")
    }
}
