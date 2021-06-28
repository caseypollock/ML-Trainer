//
//  SFSymbolView.swift
//  ML Trainer
//
//  Created by Casey Pollock on 6/22/21.
//

import SwiftUI

struct SFSymbolButton: View {
    var symbol : String
    var fontSize : CGFloat
    var shadow : CGFloat
    var color : Color = .white
    
    var body: some View {
        Image(systemName: symbol)
            .font(.system(size: fontSize))
            .foregroundColor(.white)
            .shadow(radius: 3)
    }
}

struct SFSymbolButton_Previews: PreviewProvider {
    static var previews: some View {
        SFSymbolButton(symbol: "gearshape.fill", fontSize: 25, shadow: 3)
    }
}
