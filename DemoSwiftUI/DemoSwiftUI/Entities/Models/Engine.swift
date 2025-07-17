//
//  Engine.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 15/07/25.
//

import Foundation

struct Engine: Identifiable {
    let id = UUID()
    let engineId: Int
    let name: String
    let hp: Int
    let nm: Int
    let size: Double
    
    var hpFormat: String {
        self.hp == 0 ? "Sin especificar" : "\(self.hp) HP"
    }
    
    var nmFormat: String {
        self.nm == 0 ? "Sin especificar" : "\(self.nm) NM"
    }
    
    private var sizeNumberFormat: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        
        return formatter.string(from: NSNumber(value: self.size))
    }
    
    var sizeFormat: String {
        guard let numberFormat = self.sizeNumberFormat else {
            return "Sin especificar"
        }
        
        return "\(numberFormat) CC"
    }
    
    var description: String {
        """
        MODELO: \(self.name)
        POTENCIA: \(self.hpFormat) - \(self.nmFormat)
        CILINDRADA: \(self.sizeFormat)
        """
    }
    
    init(dto: EngineDTO?) {
        self.engineId = dto?.engineId ?? 0
        self.name = dto?.name ?? ""
        self.hp = dto?.hp ?? 0
        self.nm = dto?.nm ?? 0
        self.size = dto?.size ?? 0
    }
}
