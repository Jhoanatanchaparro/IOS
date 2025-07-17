//
//  ServiceParse.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 15/07/25.
//

import Alamofire
import Foundation

struct ServiceParse<Jim: Decodable> {
    static func decode(_ responseData: DataResponsePublisher<Data>.Output) throws -> Jim  {
        guard let statusCode = responseData.response?.statusCode else {
            throw ServiceErrorDTO(statusCode: 0)
        }
        
        guard let data = responseData.data else {
            throw ServiceErrorDTO(statusCode: statusCode)
        }
        
        do {
            let response = try JSONDecoder().decode(Jim.self, from: data)
            return response
            
        } catch {
            throw error
        }
    }
}
