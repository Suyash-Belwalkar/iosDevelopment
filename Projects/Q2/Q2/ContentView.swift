//
//  ContentView.swift
//  Q2
//
//  Created by Suyash on 24/12/24.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView: View {
    var body: some View {
        ARViewContainer()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        // Configure AR session for vertical plane detection
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.vertical]
        arView.session.run(configuration)

        // Define the container frame (e.g., for UI alignment)
        let containerFrame = CGRect(x: 50, y: 100, width: 200, height: 200)

        // Add a vertical anchor
        let anchor = AnchorEntity(plane: .vertical, minimumBounds: [0.2, 0.2])

        // Add a box entity and map to containerFrame
        let box = ModelEntity(
            mesh: .generateBox(size: [0.1, 0.1, 0.1]),
            materials: [SimpleMaterial(color: .blue, isMetallic: false)]
        )

        // Map container frame to AR position
        if let frameSize = arView.window?.frame.size {
            box.position = [
                Float(containerFrame.midX / frameSize.width - 0.5) * 2,
                Float(containerFrame.midY / frameSize.height - 0.5) * -2,
                0.1
            ]
        }

        anchor.addChild(box)

        // Add the anchor to the AR view
        arView.scene.addAnchor(anchor)

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}
