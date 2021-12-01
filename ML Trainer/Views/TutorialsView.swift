//
//  TutorialsView.swift
//  ML Trainer
//
//  Created by Casey Pollock on 6/23/21.
//

import SwiftUI

struct TutorialsView: View {
    var body: some View {
        
        Form {
            Section {
                LazyHStack {
                    TitleLabelView(titleText: "", iconSystemName: "hand.draw.fill", color: .purple)
                    Text("How to use ML Trainer")
                        .foregroundColor(Color.black)
                        .bold()
                        .font(.title3)
                        .multilineTextAlignment(.trailing)
                }
            }
            
            Section {
                LazyVStack {
                    Spacer(minLength: 24)
                    Text("Capturing Data for Machine Learning")
                        .bold()
                        .italic()
                    
                    Spacer(minLength: 24)
                    //GIF #1
                    RoundedCubeImage(name: "Step 1", size: 380, curve: 0)
                    Spacer(minLength: 24)
                    Text("Press the Scan button to capture a preset amount of images as you move closer to or pivot around your subject, or Tap the Camera button to capture a single picture.")
                    
                    Spacer(minLength: 50)
                    //GIF #2
                    RoundedCubeImage(name: "Step 2", size: 380, curve: 0)
                    Spacer(minLength: 24)
                    Text("Toggle the Flashlight to improve results in low light conditions, and tap the Save button to export any captured images to the Photos app.")
                        .padding()
                }
            }
            
            Section {
                LazyVStack {
                    Spacer(minLength: 24)
                    Text("Improving Performance & Accuracy")
                        .bold()
                        .italic()
                    
                    Spacer(minLength: 24)
                    //GIF #3
                    RoundedCubeImage(name: "Step 3", size: 380, curve: 0)
                    Spacer(minLength: 24)
                    Text("While each image is always captured at a speed of 3 Frames Per Second, you can adjust the Frame Count of each Scan in the Settings Menu. A larger Frame Count will save you time, while a lower Frame Count will help improve accuracy across different angles.")
                    Spacer(minLength: 50)
                    //GIF #4
                    RoundedCubeImage(name: "Step 4", size: 380, curve: 0)
                    Spacer(minLength: 24)
                    Text("Enabling Crosshairs and Guides in the Settings Menu can also help improve accuracy.")
                        .padding()
                }
            }
            
            Section {
                LazyVStack {
                    Spacer(minLength: 24)
                    Text("Using Exported Data as Training Data")
                        .bold()
                        .italic()
                    Spacer(minLength: 24)
                    
                    //GIF #5
                    RoundedCubeImage(name: "Step 5", size: 380, curve: 0)
                    Spacer(minLength: 24)
                    Text("This app was specifically designed to speed up the process of importing data into the Xcode Developer Tool named CreateML. Exported images should also be compatible with other platforms like TensorFlow and Azure Machine Learning. \n\n A wired connection to a macOS device with the Image Capture app open will always be the fastest way to import your data to desktop.")
                        .padding()
                }
            }
        }//End of Form
    }
}

struct TutorialsView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialsView()
    }
}
