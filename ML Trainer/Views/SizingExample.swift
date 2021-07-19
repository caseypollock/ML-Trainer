//
//  GeometryReader.swift
//  ML Trainer
//
//  Created by Casey Pollock on 6/28/21.
//

import SwiftUI

struct SizingExample: View {
    var mainButtonY : CGFloat = 335
    var topButtonY : CGFloat = -335
    var sideButtonX : CGFloat = 115
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                                
                    Button(action: {
                        
                    }, label: {
                        SFSymbolCircleButton(size: geometry.size.height * 0.7)
                            .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.7)
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        ActionButton(firstColor: .blue, textColor: .white, cellWidth: geometry.size.width * 0.33, cellHeight: geometry.size.height * 0.5, cellText: "Scan", cellIcon: "camera.fill", systemSymbol: true, curve: 100, reversed: false, gradient: false)
                            .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.73)
                    })
                    .shadow(radius: 4)
            }//End of HStack
        }
        .offset(y: 400)
        .frame(height: 100, alignment: .trailing)
    }
}

struct SizingExample_Previews: PreviewProvider {
    static var previews: some View {
        SizingExample()
    }
}
