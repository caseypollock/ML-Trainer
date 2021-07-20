// AugmaOS - A reality engine I designed to create anything imaginable! I really hope you enjoy whatever it is you're making, don't forget to make it wonderful! - Casey Pollock//
//  Created by Casey Pollock on 2/23/21.
//

import SwiftUI
import SceneKit
import ARKit
import Vision
import CoreML
import UIKit
import AVFoundation
import QuartzCore
import StoreKit
import ReplayKit

struct AugmaOSView: UIViewControllerRepresentable {
    var sceneView: ARSCNView
    
    func makeUIViewController(context: Context) -> ARKitViewController {
        ARKitViewController(sceneView: sceneView)
    }
    
    func updateUIViewController(_ uiViewController: ARKitViewController, context: Context) {
    }
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AugmaOSView(sceneView: ARSCNView())
    }
}


class ARKitViewController: UIViewController, ARSCNViewDelegate {
    
    override var prefersStatusBarHidden: Bool { return true }
    let billboardConstraint = SCNBillboardConstraint()
    let freeConstraint = SCNBillboardConstraint()
    var uiSoundPlayer = AVPlayer()
    var pointersInScene = [SCNNode]()
    var cursorsInScene = [SCNNode]()
    var planesInScene = [SCNNode]()
    let configuration = ARWorldTrackingConfiguration()
    var backgroundMusic: SKAudioNode!
    let homepage = URL(string: "https://www.nearfuture.marketing")
    var pointerDisabled = false
    var leftyMode = false
    var requestedReview = false
    var debugView = false
    var batterySaverMode = false
    var startsWithML = true
    var augmaOSCrashLog = [String]()
    let printLog = true
    var sceneView: ARSCNView
    var statusLabel = ""
    
    init(sceneView: ARSCNView) {
        self.sceneView = sceneView
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view's delegate
        sceneView.delegate = self
        // Set the scene to the view
        sceneView.scene = SCNScene()
        helloWorld()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubview(sceneView)
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sceneView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        // Align the real world on z(North-South) x(West-East) axis
        configuration.worldAlignment = .gravityAndHeading
        sceneView.rendersCameraGrain = false
        // Run the view's session
        self.sceneView.session.run(configuration)
        //Setup the audio!
        try? AVAudioSession.sharedInstance().setActive(true)
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient, mode: AVAudioSession.Mode.default)
        //Prevent the screen from dimming!
        UIApplication.shared.isIdleTimerDisabled = true
        //        print("The view will appear!")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //        print("The view will disappear!")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = false
        sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = false
        sceneView.topAnchor.constraint(equalTo: view.topAnchor).isActive = false
        sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = false
        
        //        view.subviews.
        // Pause the view's session
        //        print("The view did disappear!")
    }
    
    
    
    //MARK: MAIN UX Functions
    
    func helloWorld() {
        print("")
        print("--- Copyright © 2021 Near Future Marketing Inc. ---")
        print("\nWelcome to AugmaOS, a reality engine created independently by Casey Pollock! 👨🏾‍💻📲 Enjoy!")
        print("")
    }
    
    func log(note: String) {
        self.augmaOSCrashLog.append(note)
        if printLog == true {
            print("\(note)")
        }
    }
    
    
    func hapticTap() {
        if batterySaverMode == false {
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
    }
    

    
    func toggleFlash() {
        //Retrieve the default camera device.
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        //Check if torch is present.
        if (device?.hasTorch)! {
            do {
                try device?.lockForConfiguration()
                //Check if torch is on.
                if (device?.torchMode == .on) {
                    //Turn flash off.
                    device?.torchMode = .off
                    //Change icon to on.
                } else {
                    //Turn flash on.
                    try device?.setTorchModeOn(level: 1.0)
                    //Change icon to off.
                }
                device?.unlockForConfiguration()
            } catch {
                print(error)
            }
        } else {
            print("No flash on device.")
        }
    }
    
    
    func playUISound(named: String) {
        //The proper way to play the sounds located in UI Sounds.
        if let selectedSound = Bundle.main.url(forResource: named, withExtension: "mp3") {
            self.uiSoundPlayer = AVPlayer(url: selectedSound)
            self.uiSoundPlayer.play()
        }
    }
    
    func resetMiniTutorials() {
        UserDefaults.standard.set(false, forKey: "introTutComplete")
        introTutComplete = false
        UserDefaults.standard.synchronize()
        log(note: "---> AugmaOS: All tutorial progress was erased successfully!\n")
    }
    
    
    func softResetAugmaOS() {
        DispatchQueue.main.async {
            //            self.glassesUI = nil
            self.sceneView.scene.rootNode.enumerateChildNodes { (garbageNode, _) in
                garbageNode.removeFromParentNode()
            }
            self.sceneView.debugOptions = []
            self.debugView = false
            self.sceneView.session.pause()
            self.pointersInScene.removeAll()
            self.cursorsInScene.removeAll()
            self.planesInScene.removeAll()
            self.playUISound(named: "UISound - Reset")
            self.hapticTap()
            self.sceneView.session.run(self.configuration, options: [.resetTracking, .removeExistingAnchors])
            self.viewDidLoad()
        }
    }
    
    func hardResetAugmaOS() {
        log(note: "-> AugmaOS: Started hard reset of AugmaOS!")
        resetMiniTutorials()
        softResetAugmaOS()
        hapticTap()
    }

    
    
    
    
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        DispatchQueue.main.async {
//            print("WILL UPDATE!")
        }
    }
    
    
    
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    class SessionController {
        
    }
    
    
    //MARK: MINI TUTORIALS
    var introTutComplete = UserDefaults.standard.bool(forKey: "introTutComplete")
    
}//END OF PAGE

//MARK: EXTENSIONS

extension SCNNode {
    
    func writeAugmaID(input: String) -> SCNNode {
        let augmaIDHolder = SCNNode()
        augmaIDHolder.name = "augmaID"
        let augmaID = SCNNode()
        augmaID.name = input
        augmaIDHolder.addChildNode(augmaID)
        self.addChildNode(augmaIDHolder)
        return augmaID
    }
    
    
    func rewriteExistingAugmaID(input: String) {
        self.childNode(withName: "augmaID", recursively: true)!.childNodes.first!.name = input
    }
    
    func readAugmaID() -> String {
        let output = self.childNode(withName: "augmaID", recursively: true)!.childNodes.first!.name
        return output!
    }
    
    func readDecoID() -> String? {
        let output = self.childNode(withName: "augmaID", recursively: true)?.name
        return output
    }

    
    func lineNode(from startPoint: SCNVector3, to endPoint: SCNVector3, radius: CGFloat, color: UIColor) -> SCNNode {
        let w = SCNVector3(x: endPoint.x-startPoint.x, y: endPoint.y-startPoint.y, z: endPoint.z-startPoint.z)
        let l = CGFloat(sqrt(w.x * w.x + w.y * w.y + w.z * w.z))
        if l == 0.0 {
            // two points together.
            let sphere = SCNSphere(radius: radius)
            sphere.firstMaterial?.diffuse.contents = UIColor.yellow
            self.geometry = sphere
            self.position = startPoint
            return self
        }
        let cyl = SCNCylinder(radius: radius, height: l)
        cyl.firstMaterial?.diffuse.contents = color
        self.geometry = cyl
        //original vector of cylinder above 0,0,0
        let ov = SCNVector3(0, l/2.0,0)
        //target vector, in new coordination
        let nv = SCNVector3((endPoint.x - startPoint.x)/2.0, (endPoint.y - startPoint.y)/2.0,
                            (endPoint.z-startPoint.z)/2.0)
        // axis between two vector
        let av = SCNVector3( (ov.x + nv.x)/2.0, (ov.y+nv.y)/2.0, (ov.z+nv.z)/2.0)
        //normalized axis vector
        let av_normalized = av.normalized()
        let q0 = Float(0.0) //cos(angel/2), angle is always 180 or M_PI
        let q1 = Float(av_normalized.x) // x' * sin(angle/2)
        let q2 = Float(av_normalized.y) // y' * sin(angle/2)
        let q3 = Float(av_normalized.z) // z' * sin(angle/2)
        //
        let r_m11 = q0 * q0 + q1 * q1 - q2 * q2 - q3 * q3
        let r_m12 = 2 * q1 * q2 + 2 * q0 * q3
        let r_m13 = 2 * q1 * q3 - 2 * q0 * q2
        let r_m21 = 2 * q1 * q2 - 2 * q0 * q3
        let r_m22 = q0 * q0 - q1 * q1 + q2 * q2 - q3 * q3
        let r_m23 = 2 * q2 * q3 + 2 * q0 * q1
        let r_m31 = 2 * q1 * q3 + 2 * q0 * q2
        let r_m32 = 2 * q2 * q3 - 2 * q0 * q1
        let r_m33 = q0 * q0 - q1 * q1 - q2 * q2 + q3 * q3
        //
        self.transform.m11 = r_m11
        self.transform.m12 = r_m12
        self.transform.m13 = r_m13
        self.transform.m14 = 0.0
        //
        self.transform.m21 = r_m21
        self.transform.m22 = r_m22
        self.transform.m23 = r_m23
        self.transform.m24 = 0.0
        //
        self.transform.m31 = r_m31
        self.transform.m32 = r_m32
        self.transform.m33 = r_m33
        self.transform.m34 = 0.0
        //
        self.transform.m41 = (startPoint.x + endPoint.x) / 2.0
        self.transform.m42 = (startPoint.y + endPoint.y) / 2.0
        self.transform.m43 = (startPoint.z + endPoint.z) / 2.0
        self.transform.m44 = 1.0
        return self
    }
}




