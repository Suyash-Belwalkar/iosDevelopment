//
//  Coordinator.swift
//  Q1
//
//  Created by Suyash on 18/11/24.
//

import Foundation
import ARKit
import RealityKit
import Combine

class Coordinator: NSObject {
    weak var arView: ARView?
    
    // Set up Home Scene
    func setHomeScene() {
        guard let arView = arView else { return }
        
        // Anchor for the home screen
        let anchor = AnchorEntity(plane: .horizontal, minimumBounds: [0.2, 0.2])
        
        // Create buttons
        let button1 = createButton(label: "Qubits", position: [0, 0, 0])
        button1.name = "Qubits"
        let button2 = createButton(label: "Quantum Gates", position: [0, 0, -0.5])
        button2.name = "Quantum Gates"
        let button3 = createButton(label: "Quantum Computer", position: [0, 0, -1])
        button3.name = "Quantum Computer"
      
        
        // Add buttons to anchor
        anchor.addChild(button1)
        anchor.addChild(button2)
        anchor.addChild(button3)
       
        
        arView.scene.addAnchor(anchor)
        
        // Add gesture recognizer for button tap
        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    // Create buttons
    func createButton(label: String, position: SIMD3<Float>) -> ModelEntity {
        let button = ModelEntity(mesh: .generateBox(size: [0.3, 0.1, 0.02], cornerRadius: 10), materials: [SimpleMaterial(color: .blue, isMetallic: false)])
        button.generateCollisionShapes(recursive: true)
        button.position = position
        
        
        // Add text on top of the button
        let buttonText = ModelEntity(mesh: .generateText(label, extrusionDepth: 0.005, font: .systemFont(ofSize: 0.05)))
        buttonText.model?.materials = [SimpleMaterial(color: .white, isMetallic: true)]
        buttonText.position = [-0.07, -0.02, 0.01]
        button.addChild(buttonText)
        
        return button
    }
    
    // Handle button tap for scene change
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        guard let arView = arView else { return }
        let tapLocation = recognizer.location(in: arView)
        
        if let tappedEntity = arView.entity(at: tapLocation) {
            if tappedEntity.name == "Qubits" {
                loadQubitsScene()
            } else if tappedEntity.name == "Quantum Gates" {
                loadQuantumGatesScene()
            } else if tappedEntity.name == "Quantum Computer" {
                loadNewScene()
            }
        }
    }
    
    // Load new scene
    func loadNewScene() {
        guard let arView = arView else { return }
        
        arView.scene.anchors.removeAll()  // Remove previous scene content
        
        let newAnchor = AnchorEntity(plane: .horizontal)
        let sphere = ModelEntity(mesh: .generateSphere(radius: 0.1), materials: [SimpleMaterial(color: .yellow, isMetallic: true)])
        sphere.position = [0, 0.1, 0]
        let cube = ModelEntity(mesh: .generateBox(size: [0.1, 0.1, 0.1]), materials: [SimpleMaterial(color: .purple, isMetallic: false)])
        cube.position = [0.3, 0, 0]
        
        newAnchor.addChild(sphere)
        newAnchor.addChild(cube)
        
        arView.scene.addAnchor(newAnchor)
    }
    
    // Load the Qubits Scene
    func loadQubitsScene() {
        guard let arView = arView else { return }

        arView.scene.anchors.removeAll()  // Remove existing content
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        // Add Heading
        let heading = ModelEntity(mesh: .generateText("QUBITS", extrusionDepth: 0.01, font: .systemFont(ofSize: 0.15)), materials: [SimpleMaterial(color: .black, isMetallic: false)])
        heading.position = [0, 1, 0]  // Raised position
        anchor.addChild(heading)
        
        // Create spheres for |0>, |1>, and Superposition
        let blueSphere = ModelEntity(mesh: .generateSphere(radius: 0.1), materials: [SimpleMaterial(color: .blue, isMetallic: true)])
        blueSphere.generateCollisionShapes(recursive: true)
        blueSphere.collision = CollisionComponent(shapes: [.generateSphere(radius: 0.1)], mode: .default, filter: .sensor)
        blueSphere.position = [-0.3, 0.5, 0]  // Raised position
        let greenSphere = ModelEntity(mesh: .generateSphere(radius: 0.1), materials: [SimpleMaterial(color: .green, isMetallic: true)])
        greenSphere.generateCollisionShapes(recursive: true)
        greenSphere.collision = CollisionComponent(shapes: [.generateSphere(radius: 0.1)], mode: .default, filter: .sensor)
        greenSphere.position = [0, 0.5, 0]  // Raised position
        let redSphere = ModelEntity(mesh: .generateSphere(radius: 0.1), materials: [SimpleMaterial(color: .red, isMetallic: true)])
        redSphere.generateCollisionShapes(recursive: true)
        redSphere.collision = CollisionComponent(shapes: [.generateSphere(radius: 0.1)], mode: .default, filter: .sensor)
        redSphere.position = [0.3, 0.5, 0]  // Raised position

        // Labels for each sphere
        let label0 = createLabel(text: "|0>", position: [-0.3, 0.3, 0])
        let label1 = createLabel(text: "|1>", position: [0, 0.3, 0])
        let labelSuperposition = createLabel(text: "Superposition", position: [0.3, 0.3, 0])

        anchor.addChild(blueSphere)
        anchor.addChild(greenSphere)
        anchor.addChild(redSphere)
        anchor.addChild(label0)
        anchor.addChild(label1)
        anchor.addChild(labelSuperposition)

        // Add basic info
        let paragraphPart1 = ModelEntity(mesh: .generateText("A qubit can exist in both 0 and 1 states simultaneously due to superposition,", extrusionDepth: 0.01, font: .systemFont(ofSize: 0.08)), materials: [SimpleMaterial(color: .black, isMetallic: false)])
        paragraphPart1.position = [-0.3, 0.1, 0]

        let paragraphPart2 = ModelEntity(mesh: .generateText("and can be entangled with other qubits.", extrusionDepth: 0.01, font: .systemFont(ofSize: 0.08)), materials: [SimpleMaterial(color: .black, isMetallic: false)])
        paragraphPart2.position = [0.3, 0, 0]

        anchor.addChild(paragraphPart1)
        anchor.addChild(paragraphPart2)
        
        // Add the back button
        let backButton = createButton(label: "Back", position: [-0.5, 1, 0])
        backButton.name = "backButton"
        anchor.addChild(backButton)

        arView.scene.addAnchor(anchor)
        arView.installGestures([.all] ,for: blueSphere)
        arView.installGestures([.all] ,for: greenSphere)
        arView.installGestures([.all] ,for: redSphere)
        
        // Add tap gesture recognizer to handle back button press
        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBackButtonTap(_:))))
        
    }

    // Handle tap on the back button
    @objc func handleBackButtonTap(_ recognizer: UITapGestureRecognizer) {
        guard let arView = arView else { return }
        let tapLocation = recognizer.location(in: arView)

        if let tappedEntity = arView.entity(at: tapLocation), tappedEntity.name == "backButton" {
            loadHomeScreen()  // Load home screen when tapped
        }
    }
    
    // Load Home Screen
    func loadHomeScreen() {
        guard let arView = arView else { return }
        
        arView.scene.anchors.removeAll()  // Clear current scene
        setHomeScene()  // Set home screen again
    }
    
    // Create labels for each sphere
    func createLabel(text: String, position: SIMD3<Float>) -> ModelEntity {
        let label = ModelEntity(mesh: .generateText(text, extrusionDepth: 0.01, font: .systemFont(ofSize: 0.05)), materials: [SimpleMaterial(color: .black, isMetallic: false)])
        label.position = position
        return label
    }
    
    // Load Quantum Gates Scene
        func loadQuantumGatesScene() {
            guard let arView = arView else { return }

            // Remove previous scene content
            arView.scene.anchors.removeAll()

            // Create anchor for the Quantum Gates scene
            let anchor = AnchorEntity(plane: .horizontal)

            // Create buttons for Hadamard Gate and Pauli-X Gate
            let button1 = createButton(label: "Hadamard Gate", position: [0, 0, 0])
            button1.name = "HadamardGate"
            let button2 = createButton(label: "Pauli-X Gate", position: [0, 0, -0.5])
            button2.name = "PauliXGate"
            
            let backButton = createButton(label: "Back", position: [-0.5, 1, 0])
            backButton.name = "backButton"
            

            // Add buttons to anchor
            anchor.addChild(button1)
            anchor.addChild(button2)
            anchor.addChild(backButton)

            // Add anchor to the AR scene
            arView.scene.addAnchor(anchor)

            // Add gesture recognizer for button tap
            arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleGateSelectionTap)))
        }

        // Handle tap on gate selection buttons
        @objc func handleGateSelectionTap(_ recognizer: UITapGestureRecognizer) {
            guard let arView = arView else { return }
            let tapLocation = recognizer.location(in: arView)

            if let tappedEntity = arView.entity(at: tapLocation) {
                if tappedEntity.name == "HadamardGate" {
                    loadHadamardGateScene()
                } else if tappedEntity.name == "PauliXGate" {
                    loadPauliXGateScene()
                }else if tappedEntity.name == "backButton" {
                    loadHomeScreen()
                }
            }
        }

        // Load Hadamard Gate scene
        func loadHadamardGateScene() {
            loadNewScene()
            print("Hadamard Gate Scene Loaded")
        }

        // Load Pauli-X Gate scene
        func loadPauliXGateScene() {
            loadNewScene()
            print("Pauli-X Gate Scene Loaded")
        }
}
