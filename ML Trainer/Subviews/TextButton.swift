//
//  StatusButton.swift
//  ML Trainer
//
//  Created by Casey Pollock on 6/22/21.
//

import SwiftUI

struct TextButton: View {
    var text : String
    var textColor : Color = .white
    var textShadow : CGFloat = 5
    var buttonColor : Color = .green
    var width : CGFloat = 150
    var height : CGFloat = 50
    var opacity : CGFloat = 0.9
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 100, height: 100))
                .foregroundColor(buttonColor)
                .shadow(radius: 5)
                .frame(width: width, height: height, alignment: .leading)
                .opacity(Double(opacity))
            
            Text(text)
                .foregroundColor(textColor)
                .bold()
                .multilineTextAlignment(.center)
                .shadow(radius: textShadow)
                .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }//End of Zstack
    }
}

struct StatusButton_Previews: PreviewProvider {
    static var previews: some View {
        TextButton(text: "Free Version")
    }
}
