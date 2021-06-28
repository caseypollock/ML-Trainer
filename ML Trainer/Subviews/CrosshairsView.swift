//
//  SwiftUIView.swift
//  ML Trainer
//
//  Created by Casey Pollock on 6/22/21.
//

import SwiftUI

struct CrosshairsView: View {
    var color : Color = .white
    var shortEnd : CGFloat = 15
    var longEnd : CGFloat = 85
    var width : CGFloat = 120
    var height : CGFloat = 250
    
    var body: some View {
        RoundedRectangle(cornerRadius: shortEnd)
            .foregroundColor(color)
            .frame(width: longEnd, height: shortEnd, alignment: .center)
        
        RoundedRectangle(cornerRadius: shortEnd)
            .foregroundColor(color)
            .frame(width: shortEnd, height: longEnd, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        
    }
}

struct CrosshairsView_Previews: PreviewProvider {
    static var previews: some View {
        CrosshairsView()
    }
}
