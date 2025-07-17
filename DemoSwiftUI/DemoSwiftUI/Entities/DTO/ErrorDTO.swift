//
//  BaseError.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 20/06/25.
//

struct ServiceErrorDTO: Error {
    let errorMessage: String
    let statusCode: Int
    
    static var defaultError: ServiceErrorDTO {
        
    }
}
