//
//  UserSession.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 3/07/25.
//

final class UserSession {
    static private(set) var current: UserSession?
    
    let token: String
    let name: String
    let lastName: String
    
    private init(dto: SessionDTO) {
        self.token = dto.token
        self.name = dto.name
        self.lastName = dto.lastName
    }
    
    static func new(_ dto: SessionDTO) {
        UserSession.current = UserSession(dto: dto)
        //Guardar en keychain
    }
    
    static func retive() {
        //recupera la sesion del keychain
    }
    
    static func clear() {
        UserSession.current = nil
        //borrar del keychain
    }
}
