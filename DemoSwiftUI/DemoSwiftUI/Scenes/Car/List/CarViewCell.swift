//
//  CarViewCell.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 17/07/25.
//

import SwiftUI

struct CarViewCell: View {
    var car: Car
    
    var body: some View {
        self.contentView {
            self.imageCar
            self.carInfoView {
                self.titleLabel
                self.engineLabel
            }
            Spacer()
        }
    }
    
    private func contentView(@ViewBuilder view: @escaping () -> some View) -> some View {
        HStack(alignment: .top, spacing: Spacing._sm) { view() }
            .padding(Spacing._md)
            .background(.neutral50)
            .cornerRadius(15)
    }
    
    private func carInfoView(@ViewBuilder view: @escaping () -> some View) -> some View {
        VStack(alignment: .leading, spacing: Spacing._xs) {
            self.titleLabel
            self.engineLabel
        }
    }
    
    private var imageCar: some View {
        HStack {
            
        }
        .frame(width: 100, height: 100)
        .background(.purple)
        .cornerRadius(8)
    }
    
    private var titleLabel: some View {
        TextTitle(text: self.car.nameFormat, type: .small)
    }
    
    private var engineLabel: some View {
        TextCaption(text: self.car.engine.description)
    }
}

#Preview {
    CarViewCell(car: Car(dto: .mock))
}
