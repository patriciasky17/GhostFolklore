//
//  ContentView.swift
//  GhostFolklore
//
//  Created by Patricia Ho on 22/05/23.
//

import SwiftUI
import RealityKit
import ARKit
import AVFoundation

var audioPlayer: AVAudioPlayer?

func setupAudioPlayer() {
    if let audioFilePath = Bundle.main.path(forResource: "horrorambiance3", ofType: "mp3") {
        let audioFileUrl = URL(fileURLWithPath: audioFilePath)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFileUrl)
        } catch {
            // Handle error initializing audio player
            print("Error initializing audio player: \(error.localizedDescription)")
        }
    }
}


struct ContentView : View {
    @State private var showOnboarding = true
    
    var body: some View {
        ARViewContainer()
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                setupAudioPlayer()
                audioPlayer?.play()
            }
            .overlay(
                Group {
                    if showOnboarding {
                        Color.black.opacity(0.8)
                            .edgesIgnoringSafeArea(.all)
                            .overlay(
                                VStack {
                                    Text("Welcome to the Ghost Folklore")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding()

                                    Text("There will be 5 ghost stories in this")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding()
                                    
                                    Text("Good Luck! ^^")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding()

                                    Button("Start") {
                                        showOnboarding = false
                                    }
                                    .padding([.top, .bottom], 10)
                                    .padding([.leading, .trailing], 30)
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                }
                            )
                    }
                }
            )
    }
}
    
struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView()
        let configuration = ARImageTrackingConfiguration()
        
        if let trackingImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) {
            configuration.trackingImages = trackingImages
        }
        
        let worldConfiguration = ARWorldTrackingConfiguration()
        worldConfiguration.detectionImages = configuration.trackingImages
        arView.session.run(worldConfiguration)
        arView.delegate = context.coordinator
        
        return arView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
        if ARImageTrackingConfiguration.isSupported {
            if let trackingImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) {
                let imageTrackingConfiguration = ARImageTrackingConfiguration()
                imageTrackingConfiguration.trackingImages = trackingImages
                uiView.session.run(imageTrackingConfiguration)
            }
        }
    }

    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, ARSCNViewDelegate {
        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
            guard let imageAnchor = anchor as? ARImageAnchor else { return }

            let imageName = imageAnchor.referenceImage.name

            if imageName == "TheStairs" {
                // Create a scene from the "TheStairs" file in the AR Resources folder
                guard let fountainScene = SCNScene(named: "TheStairStoryImage.usdz") else { return }
                
                // Create a node from the root node of the stairs scene
                let fountainNode = SCNNode()
                for childNode in fountainScene.rootNode.childNodes {
                    fountainNode.addChildNode(childNode)
                }
                
                // Position and scale the fountain node as desired
                fountainNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: 4.75)
                fountainNode.position = SCNVector3(0, 0, 0) // Adjust the position
                fountainNode.scale = SCNVector3(0.1, 0.1, 0.1) // Adjust the scale
                
                // Add the fountain node to the scene
                node.addChildNode(fountainNode)
                
            }
            
            if imageName == "TheElevator"{
                guard let fountainScene = SCNScene(named: "TheElevatorStory.usdz") else { return }
                
                let fountainNode = SCNNode()
                for childNode in fountainScene.rootNode.childNodes {
                    fountainNode.addChildNode(childNode)
                }
                
                fountainNode.position = SCNVector3(0, 0, 0)
                fountainNode.scale = SCNVector3(0.1, 0.1, 0.1)
                
                node.addChildNode(fountainNode)
                
            }
            
            if imageName == "TheRoad"{
                guard let fountainScene = SCNScene(named: "TheRoadStory1.usdz") else { return }
                
                let fountainNode = SCNNode()
                for childNode in fountainScene.rootNode.childNodes {
                    fountainNode.addChildNode(childNode)
                }
                
                fountainNode.position = SCNVector3(0, 0, 0)
                fountainNode.scale = SCNVector3(0.1, 0.1, 0.1)
                node.addChildNode(fountainNode)
                
            }
            
            if imageName == "TheFountain"{
                guard let fountainScene = SCNScene(named: "TheFountainStory.usdz") else { return }
                
                let fountainNode = SCNNode()
                for childNode in fountainScene.rootNode.childNodes {
                    fountainNode.addChildNode(childNode)
                }
                
                fountainNode.position = SCNVector3(0, 0, 0)
                fountainNode.scale = SCNVector3(0.1, 0.1, 0.1)
                
                node.addChildNode(fountainNode)
                
            }
            
            if imageName == "TheToilet" {
                guard let fountainScene = SCNScene(named: "TheToiletStory.usdz") else { return }
                
                let fountainNode = SCNNode()
                for childNode in fountainScene.rootNode.childNodes {
                    fountainNode.addChildNode(childNode)
                }
                
                fountainNode.position = SCNVector3(0, 0, 0)
                fountainNode.scale = SCNVector3(0.1, 0.1, 0.1)
                
                
                node.addChildNode(fountainNode)
            }
            

        }
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
