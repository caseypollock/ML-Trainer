//
//  ToolsViewButton.swift
//  Hologarden
//
//  Created by Casey Pollock on 5/23/21.
//

import SwiftUI

struct ActionButton: View {
    
    var firstColor : Color = .green
    var textColor : Color = .white
    var cellWidth : CGFloat
    var cellHeight : CGFloat = 58
    var cellText : String
    var cellIcon : String
    var systemSymbol : Bool = true
    var fontSize : CGFloat = 15
    var curve : CGFloat = 100
    var reversed : Bool = false
    var gradient : Bool = false
    var secondColor : Color = .white


    
    var body: some View {
        ZStack {
            if gradient == true {
                RoundedRectangle(cornerRadius: curve)
                    .fill(RadialGradient(gradient: Gradient(colors: [firstColor, secondColor]), center: .center, startRadius: 0, endRadius: 270))
                    .frame(width: cellWidth, height: cellHeight)
            } else if gradient == false {
                RoundedRectangle(cornerRadius: curve)
                    .fill(firstColor)
                    .frame(width: cellWidth, height: cellHeight)
            }

            
            if reversed == true {
                LazyHStack {
                    if systemSymbol == true {
                        Image(systemName: cellIcon)
                            .foregroundColor(textColor)
                            .shadow(radius: 2)
                            .padding(2)
                            .offset(x: 2)
                    } else if systemSymbol == false {
                        Image(cellIcon)
                            .frame(width: 1, height: 1)
                            .foregroundColor(textColor)
                            .shadow(radius: 2)
                            .padding(2)
                            .offset(x: 2)
                    }
                    
                    Text(cellText)
                    .bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(textColor)
                    .shadow(radius: 2)
                    .offset(x: -4)
                }//End of HStack
            
            } else if reversed == false {
                LazyHStack {
                    Text(cellText)
                    .bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(textColor)
                    .shadow(radius: 2)
                    .offset(x: 4)
                    
                    if systemSymbol == true {
                        Image(systemName: cellIcon)
                            .foregroundColor(textColor)
                            .shadow(radius: 2)
                            .padding(2)
                            .offset(x: -2)
                    } else if systemSymbol == false {
                        Image(cellIcon)
                            .frame(width: 1, height: 1)
                            .foregroundColor(textColor)
                            .shadow(radius: 2)
                            .padding(2)
                            .offset(x: -2)
                    }
                }//End of HStack
            }
        }//End of ZStack
        .frame(width: cellWidth, height: cellHeight)
    }
}

struct ToolsViewButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(cellWidth: 105, cellText: "PlantID", cellIcon: "ruler.fill")
    }
}
