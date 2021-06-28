//
//  RoundedCubeImage.swift
//  Hologarden
//
//  Created by Casey Pollock on 2/25/21.
//

import SwiftUI

struct RoundedCubeImage: View {
    
    var name : String
    var size : CGFloat = 50
    var curve : CGFloat = 10

//    var overlay : some View {
//        Circle()
//            .stroke(Color.red, lineWidth: 0)
//    }
    
    var body: some View {
        
            Image(name)
                .resizable()
                .frame(width: size, height: size)
                .aspectRatio(contentMode: .fit)
                .imageScale(.small)
    //            .overlay(overlay)
                .clipShape(RoundedRectangle(cornerRadius: curve))
    }
}

struct RoundedCubeImage_Previews: PreviewProvider {
    static var previews: some View {
        RoundedCubeImage(name: "Test Plant", size: 50, curve: 10.0)
            .previewLayout(.sizeThatFits)
    }
}
