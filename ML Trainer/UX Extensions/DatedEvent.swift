//
//  DatedEvent.swift
//  Hologarden
//
//  Created by Casey Pollock on 2/21/21.
//

import Foundation
import SwiftUI

class DatedEvent: ObservableObject {
    var date = Date()
    var title = ""
    var loopSetting = 0
    var url = ""
    var color = Color.clear
    @Published var imageData : Data?
    
    func image() -> Image? {
        if let data = imageData {
            if let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
        }
        return nil
    }
    
}



