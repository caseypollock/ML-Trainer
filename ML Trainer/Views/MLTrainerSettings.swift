//
//  MLTrainerSettings.swift
//  ML Trainer
//
//  Created by Casey Pollock on 6/21/21.
//

import SwiftUI
import AVFoundation

struct MLTrainerSettings: View {
    @StateObject var datedEvent = DatedEvent()
    
    @State var userSettings : UserSettings
    @State var showPrivacyPolicy = false
    @State var showTutorials = false
    
    
    
    
    
    var body: some View {
        Form {
            Section {
                TitleLabelView(titleText: "Settings", iconSystemName: "gearshape.fill", color: .blue)
                    .padding()
            }
            
            Section {
                TitleLabelView(titleText: "Frame Count", iconSystemName: "camera.viewfinder", color: .green)
                    .padding()
                
                VStack {
//                    if userSettings.loopTab == 4 {
//                        //If Custom is selected
//                        TextField("Custom", text: $datedEvent.title)
//                            .keyboardType(.decimalPad)
//                        Button("Save") {
//                            userSettings.loopSetting = datedEvent.loopSetting
//                            datedEvent.title = "" // Clear text
//                            UIApplication.shared.endEditing() // Call to dismiss keyboard
//                        }
//                    }
                    
                    Picker(selection: $userSettings.loopTab, label: Text("")) {
                        Text("5").tag(0)
                        Text("10").tag(1)
                        Text("20").tag(2)
                        Text("25").tag(3)
//                        Text("Custom").tag(4)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Text("The amount of frames in each scan.")
                        .padding()
                }
                
                //                VStack {
                //                    if userSettings.loopTab == 4 {
                //                        TextField("Custom", text: $datedEvent.title)
                //                            .keyboardType(.numberPad)
                //                            .autocapitalization(.words)
                //                            .frame(height: 40)
                //                    }
                //
                //                    Picker(selection: $userSettings.loopTab, label: Text("")) {
                //                        Text("5").tag(0)
                //                        Text("10").tag(1)
                //                        Text("20").tag(2)
                //                        Text("25").tag(3)
                //                        Text("Custom").tag(4)
                //                    }
                //                    .pickerStyle(SegmentedPickerStyle())
                //
                //                    Text("The amount of frames in each scan.")
                //                        .padding()
                //                }//End of VStack
                
            }
            
            Section {
                TitleLabelView(titleText: "Appearance", iconSystemName: "lasso.sparkles", color: .orange)
                    .padding()
                
                Toggle(isOn: $userSettings.showGuides, label: {
                    Text("Show Guides")
                })
                
                Toggle(isOn: $userSettings.showCrosshairs, label: {
                    Text("Show Crosshairs")
                })
                
                Toggle(isOn: $userSettings.hideStatusBar, label: {
                    Text("Hide Status Bar")
                })
            }//End of Section
            
            
            //Tutorials
            Section {
                Button(action: {
                    showTutorials = true
                }) {
                    LazyHStack {
                        TitleLabelView(titleText: "", iconSystemName: "hand.draw.fill", color: .pink)
                        Text("Tutorials")
                            .bold()
                            .font(.title3)
                            .multilineTextAlignment(.trailing)
                    }
                    .frame(height: 10)
                    .padding()
                }
                .sheet(isPresented: $showTutorials) {
                    TutorialsView()
                }
            }
            
            
            Section {
                TitleLabelView(titleText: "Credits", iconSystemName: "film.fill", color: .gray)
                    .padding()
                
                LazyVStack {
                    
                    Spacer(minLength: 30)
                    
                    Text("ML Trainer")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(    .center)
                        .shadow(radius: 1)
                    
                    RoundedCubeImage(name: "Test", size: 300, curve: 0)
                    
                    Text("Data collection made easy!")
                        .italic()
                        .bold()
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    
                    Spacer(minLength: 20)
                }//End of VStack
            }//End of Section
            
            Section {
                LazyVStack {
                    Text("Our Mission")
                        .font(.title)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .shadow(radius: 1)
                        .frame(height: 50)
                    
                    Spacer(minLength: 20)
                    
                    Text("An easy to use, open source developer tool that records training data for machine learning models!")
                        .multilineTextAlignment(.center)
                    
                    Spacer(minLength: 20)
                }//End of VStack
            }
            
            Section {
                LazyVStack {
                    Text("Design Team")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .shadow(radius: 1)
                        .frame(height: 50)
                    
                    Spacer()
                    
                    Text("Casey Pollock - Lead UI/UX Designer")
                        .italic()
                        .multilineTextAlignment(.trailing)
                    Spacer()
                }//End of VStack
            }
            
            Section {
                LazyVStack {
                    Text("Development Team")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .shadow(radius: 1)
                        .frame(height: 50)
                    
                    Text("Casey Pollock - Lead Software Engineer")
                        .italic()
                        .multilineTextAlignment(.trailing)
                    
                    Spacer()
                }//End of VStack
            }
            
            
            Section {
                LazyVStack {
                    Spacer(minLength: 24)
                    Text("Thank you for using ML Trainer!")
                        .bold()
                        .multilineTextAlignment(.center)
                    
                    RoundedCubeImage(name: "NFM Logo (clear)", size: 300, curve: 0)
                }//End of VStack
                
                Text("Near Future Marketing Inc. (2021)")
                    .bold()
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            
            Section {
                //Privacy Policy
                Button(action: {
                    showPrivacyPolicy = true
                }) {
                    LazyHStack {
                        TitleLabelView(titleText: "", iconSystemName: "lock.fill", color: .blue)
                        Text("Privacy Policy")
                            .bold()
                            .font(.title3)
                            .multilineTextAlignment(.trailing)
                    }
                    .frame(height: 10)
                    .padding()
                }
                .sheet(isPresented: $showPrivacyPolicy) {
                    PrivacyPolicyView()
                }
            }
            
            
        }//End of Form
        .onDisappear() {
            UserDefaults.standard.set(userSettings.showGuides, forKey: "showGuides")
            UserDefaults.standard.set(userSettings.showCrosshairs, forKey: "showCrosshairs")
            UserDefaults.standard.set(userSettings.hideStatusBar, forKey: "hideStatusBar")
            UserDefaults.standard.set(userSettings.loopTab, forKey: "loopTab")
            switch userSettings.loopTab {
            case 1: userSettings.loopSetting = 10
            case 2: userSettings.loopSetting = 20
            case 3: userSettings.loopSetting = 25
            case 4: userSettings.loopSetting = datedEvent.loopSetting
            default: userSettings.loopSetting = 5
            }
            UserDefaults.standard.set(userSettings.loopSetting, forKey: "loopSetting")
            userSettings.scansRemaining = userSettings.loopSetting
            UserDefaults.standard.synchronize()
        }
    }//End of Body
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct MLTrainerSettings_Previews: PreviewProvider {
    static var previews: some View {
        MLTrainerSettings(userSettings: UserSettings())
    }
}
