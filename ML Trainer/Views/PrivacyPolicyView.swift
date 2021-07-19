//
//  CreditsView.swift
//  Hologarden
//
//  Created by Casey Pollock on 4/10/21.
//

import SwiftUI
import WebKit

struct PrivacyPolicyView: View {
    @State var showSourceCode = false
    
    var body: some View {
        Form {
            Section {
                TitleLabelView(titleText: "Privacy Policy", iconSystemName: "lock.fill", color: .blue)
                    .padding()
                
                Text("ML Trainer presents a unique user experience allowing the camera’s to interact with the world you around you! \n\nIn order for augmented reality to be possible, this app requires access to your device's camera.")
                    .padding()
            }

            
            Section {
                TitleLabelView(titleText: "Functional Data", iconSystemName: "camera.fill", color: .blue)
                
                Text("Camera access is required to collect contextualized depth data from the API's provided by Apple. Any collected data is stored on the device only for the duration of the current session. When you take a photo or video using the 3D Camera, the resulting exported file does not include depth data and only portrays the results. \n\nOn LiDAR equipped devices, the user may choose to record depth data in the form of a 3D model.")
                    .padding()
            }
            
            Section {
                TitleLabelView(titleText: "Personal Data", iconSystemName: "person.2.fill", color: .blue)
                
                Text("Every time the application is closed, all world tracking data is deleted. \n\nYour camera data is never stored remotely, given to third parties, or used for any non-functional/entertainment purposes at any time.")
                    .padding()
            }
            
            Section {
                TitleLabelView(titleText: "Thank you for using ML Trainer!", iconSystemName: "heart", color: .blue)
            }
            
            Section {
                //Privacy Policy
                Button(action: {
                    showSourceCode = true
                }) {
                    LazyHStack {
                        TitleLabelView(titleText: "View Source Code", iconSystemName: "swift", color: .pink)
                        Text("")
                            .foregroundColor(Color.black)
                            .bold()
                            .font(.title3)
                            .multilineTextAlignment(.trailing)
                    }
                    .frame(height: 10)
                    .padding()
                }
                .sheet(isPresented: $showSourceCode) {
                    WebView(url: "https://github.com/caseypollock/ML-Trainer/blob/main/ML%20Trainer/Views/MLTrainerApp.swift")
                }
            }
            
        }
        
    }
}

struct PrivacyPolicy_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
