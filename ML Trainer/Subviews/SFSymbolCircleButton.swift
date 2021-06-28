//
//  SFSymbolCircleButton.swift
//  ML Trainer
//
//  Created by Casey Pollock on 6/22/21.
//

import SwiftUI

struct SFSymbolCircleButton: View {
    var symbol : String = "camera.viewfinder"
    var symbolColor : Color = .green
    var fontSize : CGFloat = 33
    var buttonColor : Color = .white
    var shadow : CGFloat = 4
    var size : CGFloat = 62
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(buttonColor)
                .shadow(radius: shadow)
                .frame(width: size, height: size)

            Image(systemName: symbol)
                .font(.system(size: fontSize))
                .foregroundColor(.green)
        }    }
}

struct SFSymbolCircleButton_Previews: PreviewProvider {
    static var previews: some View {
        SFSymbolCircleButton()
    }
}
