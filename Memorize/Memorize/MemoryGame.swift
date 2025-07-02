//
//  Untitled.swift
//  Memorize
//
//  Created by Jhonatan David Chaparro Alvarez on 10/06/25.
//

import SwiftUI

struct MemoryGame<BalonesContent>{
    private(set)var balones: Array<Balones>
    
    func choose(_ balones: Balones ){
        
    }
    
    init(numberOfPairsOfBalones: Int, createBalonContent: (Int) -> BalonesContent){
        balones = Array<Balones>()
        for pairIndex in 0..<numberOfPairsOfBalones {
            let Content = createBalonContent(pairIndex)
            balones.append(Balones(content: <#T##BalonesContent#>))
            balones.append(Balones(content: <#T##BalonesContent#>))
        }
    }
    struct Balones{
        var isFaceup: Bool = false
        var isMatched: Bool = false
        var content: BalonesContent
    }
}
