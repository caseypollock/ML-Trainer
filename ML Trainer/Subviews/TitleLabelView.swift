//
//  TitleLabelView.swift
//  Hologarden
//
//  Created by Casey Pollock on 2/21/21.
//

import SwiftUI

struct TitleLabelView: View {
    var titleText : String
    var iconSystemName : String
    var color : Color
    
    var body: some View {
        Label {
            Text(titleText)
                .bold()
        } icon: {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(color)
                    .frame(width: 34, height: 28, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Image(systemName: iconSystemName)
                    .foregroundColor(.white)
            }
            .padding(4)
        }
    }
}

struct TitleLabelView_Previews: PreviewProvider {
    static var previews: some View {
        TitleLabelView(titleText: "Hello World", iconSystemName: "calendar", color: Color.red)
            .previewLayout(.sizeThatFits)
    }
}
