//
//  ML Trainer
//
//  Created by Casey Pollock on 6/20/21.
//  Copyright © 2021 Near Future Marketing Inc.

import SwiftUI
import ARKit
import SceneKit
import UIKit
import AVFoundation
import WebKit

struct MLTrainerApp: View {
    let sceneView = ARSCNView()
    var mainButtonY : CGFloat = 335
    var topButtonY : CGFloat = -335
    var sideButtonX : CGFloat = 115
    
    @ObservedObject var userSettings : UserSettings
    @State var statusLabel : String = "Free Version"
    @State var confirmationMessage : String = ""
    @State var scannedTrainingData = [UIImage]()
    @State var recordingScans = false
    @State var invalidateTimer = false
    @State var showTrashcan = false
    @State var presentSettingsApp = false
    @State var presentNFMWebsite = false
    @State var flashLightIcon = "flashlight.off.fill"
    @State var freeVersion = true
    @State var totalScansSaved = 0


    var body: some View {
        let augmaOS = ARKitViewController(sceneView: sceneView)
                
        ZStack {
            AugmaOSView(sceneView: sceneView)
                .ignoresSafeArea()
            
            if userSettings.showGuides == true {
                GuidesView()
            }
            
            if userSettings.showCrosshairs == true {
                CrosshairsView()
            }
            
            Text(confirmationMessage)
                .foregroundColor(.white)
                .italic()
                .bold()
                .font(.title2)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .shadow(radius: 5)
                .offset(x: 0, y: mainButtonY - 50)
            
            
                Button(action: {
                    presentNFMWebsite = true
                    augmaOS.hapticTap()
                }, label: {
                    TextButton(text: statusLabel)
                })
            .offset(x: -100, y: topButtonY)
//                .sheet(isPresented: $presentNFMWebsite) {
//                    WebView(url: "https://www.nearfuture.marketing")
//                }
            
            ZStack {
                if showTrashcan == true {
                    Button(action: {
                        Timer.scheduledTimer(withTimeInterval: 1.7, repeats: false) { [self] timer in
                            if scannedTrainingData.isEmpty == true {
                                statusLabel = "Free Version"
                            }
                        }
                        scannedTrainingData.removeAll()
                        statusLabel = "Erased All Data!"
                        showTrashcan = false
                        augmaOS.hapticTap()
                    }, label: {
                        SFSymbolButton(symbol: "trash.fill", fontSize: 27, shadow: 3)
                    })
                    .frame(width: 40, height: 40)
                    .offset(x: -60, y: 0)
                }
                
                Button(action: {
                    if flashLightIcon == "flashlight.off.fill" {
                        flashLightIcon = "flashlight.on.fill"
                        augmaOS.playUISound(named: "UISound - Flash On")
                    } else if flashLightIcon == "flashlight.on.fill" {
                        flashLightIcon = "flashlight.off.fill"
                        augmaOS.playUISound(named: "UISound - Flash Off")
                    }
                    augmaOS.toggleFlash()
                    augmaOS.hapticTap()
                }, label: {
                    SFSymbolButton(symbol: flashLightIcon, fontSize: 27, shadow: 3)

                })
                .frame(width: 40, height: 40)
                .offset(x: 0, y: 0)

                Button(action: {
                    presentSettingsApp = true
                    augmaOS.hapticTap()
                }, label: {
                    SFSymbolButton(symbol: "gearshape.fill", fontSize: 27, shadow: 3)
                })
                .frame(width: 40, height: 40)
                .offset(x: 60, y: 0)
                .sheet(isPresented: $presentSettingsApp) {
                    MLTrainerSettings(userSettings: userSettings)
                }
                
            }//End of ZStack
            .offset(x: 100, y: topButtonY)

            

            
            
            if scannedTrainingData.isEmpty == true && recordingScans == false {
                //Shows Scan Button in Middle
                ZStack {
                    Button(action: {
                            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) {_ in
                                augmaOS.hapticTap()
                            }
                            let newScan = self.sceneView.snapshot()
                            scannedTrainingData.append(newScan)
                        if scannedTrainingData.count == 1 {
                            statusLabel = "\(scannedTrainingData.count) New Scan!"
                        } else {
                            statusLabel = "\(scannedTrainingData.count) New Scans!"
                        }
                        showTrashcan = true
                        augmaOS.hapticTap()
                    }, label: {
                        SFSymbolCircleButton()
                    })
                    
                    Button(action: {
                        if userSettings.scansRemaining == 0 {
                            // Fixes default user settings after launch.
                            userSettings.scansRemaining = 5
                        }
                        recordingScans = true
                        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { [self] timer in
                            userSettings.scansRemaining -= 1
                            let newScan = self.sceneView.snapshot()
                            scannedTrainingData.append(newScan)
                            if scannedTrainingData.count == 1 {
                                statusLabel = "\(scannedTrainingData.count) New Scan!"
                            } else {
                                statusLabel = "\(scannedTrainingData.count) New Scans!"
                            }
                            
                            if userSettings.scansRemaining <= 0 {
                                timer.invalidate()
                                recordingScans = false
                                showTrashcan = true
                                userSettings.scansRemaining = userSettings.loopSetting
                                augmaOS.hapticTap()
                            } else if invalidateTimer == true {
                                timer.invalidate()
                                recordingScans = false
                                invalidateTimer = false
                                showTrashcan = true
                                augmaOS.hapticTap()
                            }
                        }
                        augmaOS.hapticTap()
                    }, label: {
                        ActionButton(firstColor: .blue, textColor: .white, cellWidth: 130, cellHeight: 50, cellText: "Scan", cellIcon: "camera.fill", systemSymbol: true, curve: 100, reversed: false, gradient: false)
                    })
                    .shadow(radius: 4)
                    .offset(x: sideButtonX, y: 0)
                }//End of ZStack
                .offset(x: 0, y: mainButtonY)

                


            } else if scannedTrainingData.isEmpty == false && recordingScans == true {
                //Shows the Pause Button while scanning!
                Button(action: {
                    invalidateTimer = true
                    augmaOS.hapticTap()
                }, label: {
                    ActionButton(firstColor: .red, textColor: .white, cellWidth: 160, cellHeight: 50, cellText: "Pause", cellIcon: "pause.circle.fill", systemSymbol: true, curve: 100, reversed: false, gradient: false)
                })
                .shadow(radius: 4)
                .offset(x: 0, y: mainButtonY)

            } else if scannedTrainingData.isEmpty == true && recordingScans == true {
                //Shows the Pause Button when scanning first begins!
                Button(action: {
                    invalidateTimer = true
                    augmaOS.hapticTap()
                }, label: {
                    ActionButton(firstColor: .red, textColor: .white, cellWidth: 160, cellHeight: 50, cellText: "Pause", cellIcon: "pause.circle.fill", systemSymbol: true, curve: 100, reversed: false, gradient: false)
                })
                .shadow(radius: 4)
                .offset(x: 0, y: mainButtonY)

                //Shows the Manager buttons!
            } else if scannedTrainingData.isEmpty == false && recordingScans == false {
                Button(action: {
                    //The Save Button Logic
                    if scannedTrainingData.isEmpty == false {
                        for selectedFrame in scannedTrainingData
                        {
                            UIImageWriteToSavedPhotosAlbum(selectedFrame, self, nil, nil)
                        }
                        statusLabel = "Success!"
                        augmaOS.playUISound(named: "UISound - Confirmed")
                        confirmationMessage = "Saved \(scannedTrainingData.count) scans to your Photos!"
                        Timer.scheduledTimer(withTimeInterval: 1.7, repeats: false) {_ in
                            statusLabel = "Free Version"
                        }
                        Timer.scheduledTimer(withTimeInterval: 2.4, repeats: false) {_ in
                            confirmationMessage = ""
                        }
                        if freeVersion == true {
                            totalScansSaved += scannedTrainingData.count
                            if totalScansSaved >= 100 {
                                totalScansSaved = 0
                                presentNFMWebsite = true
                            }
                        }
                        scannedTrainingData.removeAll()
                        showTrashcan = false

                    } else if scannedTrainingData.isEmpty == true {
                        statusLabel = "No Data to Save!"
                    }
                    augmaOS.hapticTap()
                }, label: {
                    ActionButton(firstColor: .purple, textColor: .white, cellWidth: 130, cellHeight: 50, cellText: "Save", cellIcon: "checkmark.circle.fill", systemSymbol: true, curve: 100, reversed: true, gradient: false)
                })
                .shadow(radius: 4)
                .offset(x: -sideButtonX, y: mainButtonY)

                Button(action: {
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) {_ in
                        augmaOS.hapticTap()
                    }
                    let newScan = self.sceneView.snapshot()
                    scannedTrainingData.append(newScan)
                    if scannedTrainingData.count == 1 {
                        statusLabel = "\(scannedTrainingData.count) New Scan!"
                    } else {
                        statusLabel = "\(scannedTrainingData.count) New Scans!"
                    }
                    showTrashcan = true
                    augmaOS.hapticTap()
                }, label: {
                    SFSymbolCircleButton()
                })
                .offset(x: 0, y: mainButtonY)

                Button(action: {
                    recordingScans = true
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { [self] timer in
                        userSettings.scansRemaining -= 1
                        let newScan = self.sceneView.snapshot()
                        scannedTrainingData.append(newScan)
                        if scannedTrainingData.count == 1 {
                            statusLabel = "\(scannedTrainingData.count) New Scan!"
                        } else {
                            statusLabel = "\(scannedTrainingData.count) New Scans!"
                        }
                        if userSettings.scansRemaining <= 0 {
                            timer.invalidate()
                            recordingScans = false
                            showTrashcan = true
                            userSettings.scansRemaining = userSettings.loopSetting
                            augmaOS.hapticTap()
                        } else if invalidateTimer == true {
                            timer.invalidate()
                            recordingScans = false
                            invalidateTimer = false
                            showTrashcan = true
                            augmaOS.hapticTap()
                        }
                    }

                    augmaOS.hapticTap()
                }, label: {
                    ActionButton(firstColor: .blue, textColor: .white, cellWidth: 130, cellHeight: 50, cellText: "Scan", cellIcon: "camera.fill", systemSymbol: true, curve: 100, reversed: false, gradient: false)
                })
                .shadow(radius: 4)
                .offset(x: sideButtonX, y: mainButtonY)

            }//End of If/Else Statement
            
        }//End of ZStack
        .statusBar(hidden: userSettings.hideStatusBar)
        .onAppear() {
            if userSettings.loopSetting == 0 {
                userSettings.hideStatusBar = true
                userSettings.loopSetting = 5
                userSettings.scansRemaining = 5
                UserDefaults.standard.set(userSettings.hideStatusBar, forKey: "hideStatusBar")
                UserDefaults.standard.set(userSettings.loopSetting, forKey: "loopSetting")
                UserDefaults.standard.synchronize()
            }
        }
    }//End of Body
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MLTrainerApp(userSettings: UserSettings())
    }
}
