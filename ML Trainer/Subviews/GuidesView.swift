//
//  ViewFinderGuide.swift
//  Hologarden
//
//  Created by Casey Pollock on 5/10/21.
//

import SwiftUI

struct GuidesView: View {
    var color : Color = .white
    var shortEnd : CGFloat = 15
    var longEnd : CGFloat = 85
    var width : CGFloat = 120
    var height : CGFloat = 250
    
    var body: some View {
        ZStack {
            ZStack {
                //Top Right Corner
                RoundedRectangle(cornerRadius: shortEnd)
                    .foregroundColor(color)
                    .frame(width: longEnd, height: shortEnd, alignment: .trailing)
                
                RoundedRectangle(cornerRadius: shortEnd)
                    .foregroundColor(color)
                    .frame(width: shortEnd, height: longEnd, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .offset(x: 35, y: 35)
            }//End of ZStack
            .offset(x: width, y: -height)
            
            ZStack {
                //Top Left Corner
                RoundedRectangle(cornerRadius: shortEnd)
                    .foregroundColor(color)
                    .frame(width: longEnd, height: shortEnd, alignment: .leading)
                
                RoundedRectangle(cornerRadius: shortEnd)
                    .foregroundColor(color)
                    .frame(width: shortEnd, height: longEnd, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .offset(x: -35, y: 35)
            }//End of ZStack
            .offset(x: -width, y: -height)
            
            ZStack {
                //Bottom Left Corner
                RoundedRectangle(cornerRadius: shortEnd)
                    .foregroundColor(color)
                    .frame(width: longEnd, height: shortEnd, alignment: .leading)
                
                RoundedRectangle(cornerRadius: shortEnd)
                    .foregroundColor(color)
                    .frame(width: shortEnd, height: longEnd, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .offset(x: -35, y: -35)
            }//End of ZStack
            .offset(x: -width, y: height)
            
            ZStack {
                //Bottom Right Corner
                RoundedRectangle(cornerRadius: shortEnd)
                    .foregroundColor(color)
                    .frame(width: longEnd, height: shortEnd, alignment: .leading)
                
                RoundedRectangle(cornerRadius: shortEnd)
                    .foregroundColor(color)
                    .frame(width: shortEnd, height: longEnd, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .offset(x: 35, y: -35)
            }//End of ZStack
            .offset(x: width, y: height)
        }//End of ZStack
    }
}

struct ViewFinderGuide_Previews: PreviewProvider {
    static var previews: some View {
        GuidesView(color: .green)
    }
}
