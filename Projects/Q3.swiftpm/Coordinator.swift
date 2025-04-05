//
//  Coordinator.swift
//  Q1
//
//  Created by Suyash on 18/11/24.
//

import Foundation
import RealityKit
import Combine
import SwiftUI
import ARKit

extension UIColor {
    static func random() -> UIColor{
        return UIColor(displayP3Red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1),alpha: 1.0)
    }
}

class Coordinator: NSObject {
    weak var arView: ARView?
    
    var showOverlay: Binding<Bool>? // Binding for overlay visibility
    var overlayMessage: Binding<String>? // Binding for overlay message
    var engreenSphere: ModelEntity!
    var enblueSphere: ModelEntity!
    var quantumComputerModel: ModelEntity? = nil
    var isModelLoaded = false
    var cancellables: [AnyCancellable] = []
    var collisionSub = [Cancellable]()
   
    //unload model efficently to avoid crash
    func unloadScene() {
        arView?.scene.anchors.removeAll()
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        print("Scene unloaded successfully")
    }

    //Home page or First Page after opening the app
    func HomeScene() {
        guard let arView = arView else { return }
        
        arView.scene.anchors.removeAll()
        
        let anchor = AnchorEntity(plane: .horizontal, minimumBounds: [0.2, 0.2])
        let homeScreen1 = ModelEntity(mesh: .generateBox(size: [2.2, 1.5, 0.02] , cornerRadius: 20), materials: [SimpleMaterial(color: .lightText, isMetallic: false)])
        homeScreen1.position = [0.2, 0.3, -1]
        
        let Intro = ModelEntity(mesh: .generateText("Welcome!!", extrusionDepth: 0.01, font: .boldSystemFont(ofSize: 0.09)), materials: [SimpleMaterial(color: .darkText, isMetallic: true)])
        Intro.position = [-0.1, 0.7, -0.5]
        
        let Intro1 = ModelEntity(mesh: .generateText("Are you ready", extrusionDepth: 0.01, font: .boldSystemFont(ofSize: 0.09)), materials: [SimpleMaterial(color: .darkText, isMetallic: true)])
        Intro1.position = [-0.2, 0.5, -0.5]
        
        let Intro2 = ModelEntity(mesh: .generateText("To begin your AR journey!!", extrusionDepth: 0.01, font: .boldSystemFont(ofSize: 0.09)), materials: [SimpleMaterial(color: .darkText, isMetallic: true)])
        Intro2.position = [-0.35, 0.3, -0.5]
        
        let next = createButton(label: "NEXT", position: [0.1, 0.1, -0.5])
        next.name = "next"
        
        anchor.addChild(homeScreen1)
        anchor.addChild(Intro)
        anchor.addChild(Intro1)
        anchor.addChild(Intro2)
        anchor.addChild(next)
        
        arView.scene.addAnchor(anchor)
        
        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    // Topic Selectiion Page
    func TopicScene() {
        guard let arView = arView else { return }
        
        arView.scene.anchors.removeAll()
        
        // Anchor for the home screen
        let anchor = AnchorEntity(plane: .horizontal, minimumBounds: [0.2, 0.2])
        
        let Info = ModelEntity(mesh: .generateText("Select a topic!!", extrusionDepth: 0.01, font: .boldSystemFont(ofSize: 0.09)), materials: [SimpleMaterial(color: .darkText, isMetallic: true)])
        Info.position = [-0.2, 0.7, -0.5]
        
        // Create buttons
        let button1 = createButton(label: "Qubits", position: [0.1, 0.5, -0.5])
        button1.name = "Qubits"
        let button2 = createButton1(label: "Quantum Gates", position: [0.1, 0.3, -0.5])
        button2.name = "Quantum Gates"
        let button3 = createButton4(label: "Quantum Computer", position: [0.1, 0.1, -0.5])
        button3.name = "Quantum Computer"
        let button4 = createButton4(label: "Quantum Circuits", position: [0.1, -0.1, -0.5])
        button4.name = "Quantum Circuits"
        
        let backGround = ModelEntity(mesh: .generateBox(size: [1.5, 1.5, 0.02] , cornerRadius: 20), materials: [SimpleMaterial(color: .lightText, isMetallic: false)])
        backGround.position = [0.18, 0.3, -0.6]
        
        
        // Add buttons to anchor
        anchor.addChild(button1)
        anchor.addChild(button2)
        anchor.addChild(button3)
        anchor.addChild(button4)
        anchor.addChild(Info)
        anchor.addChild(backGround)
        
        
        arView.scene.addAnchor(anchor)
        
        // Add gesture recognizer for button tap
        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
        
    // Load the Qubits Scene
    func basicQubitsScene() {
        guard let arView = arView else { return }

        arView.scene.anchors.removeAll()  // Remove existing content
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        // Add Heading
        let heading = ModelEntity(mesh: .generateText("QUBITS", extrusionDepth: 0.01, font: .systemFont(ofSize: 0.15)), materials: [SimpleMaterial(color: .black, isMetallic: false)])
        heading.position = [0, 1, -0.5]  // Raised position
        anchor.addChild(heading)
        
        // Create spheres for |0>, |1>, and Superposition
        let greenSphere = ModelEntity(mesh: .generateSphere(radius: 0.1), materials: [SimpleMaterial(color: .green, isMetallic: true)])
        greenSphere.generateCollisionShapes(recursive: true)
        greenSphere.collision = CollisionComponent(shapes: [.generateSphere(radius: 0.1)], mode: .default, filter: .sensor)
        greenSphere.position = [0.5, 0.7, -0.5]  // Raised position
        let blueSphere = ModelEntity(mesh: .generateSphere(radius: 0.1), materials: [SimpleMaterial(color: .blue, isMetallic: true)])
        blueSphere.generateCollisionShapes(recursive: true)
        blueSphere.collision = CollisionComponent(shapes: [.generateSphere(radius: 0.1)], mode: .default, filter: .sensor)
        blueSphere.position = [0.2, 0.7, -0.5]  // Raised position
        
        let backGround1 = ModelEntity(mesh: .generateBox(size: [1.7, 0.35, 0.02] , cornerRadius: 20), materials: [SimpleMaterial(color: .lightText, isMetallic: false)])
        backGround1.position = [0.35, 0.26, -0.7]
        
        let basicQubit = createButton(label: "Basic", position: [-0.25, -0.2, -0.5])
        basicQubit.name = "basicQubit"
        let superPositionQubit = createButton2(label: "Superposition", position: [0.25, -0.2, -0.5])
        superPositionQubit.name = "superPositionQubit"
        let entangledQubit = createButton3(label: "Entangled", position: [0.83, -0.2, -0.5])
        entangledQubit.name = "entangledQubit"

        // Labels for each sphere
        let label0 = createText(text: "|0>", position: [0.18, 0.5, -0.5])
        let label1 = createText(text: "|1>", position: [0.47, 0.5, -0.5])
        let qubitInfo = createText(text: "A qubit is the fundamental unit of ", position: [0, 0.35, -0.5])
        let qubitInfo1 = createText(text: "quantum information, analogous to a classical bit", position: [-0.28, 0.3, -0.5])
        let qubitInfo2 = createText(text: "but capable of existing in states |0⟩, |1⟩ or", position: [-0.25, 0.25, -0.5])
        let qubitInfo3 = createText(text: "a combination (superposition) of both.", position: [-0.19, 0.2, -0.5])

        anchor.addChild(blueSphere)
        anchor.addChild(greenSphere)
        anchor.addChild(label0)
        anchor.addChild(label1)
        anchor.addChild(backGround1)
        anchor.addChild(basicQubit)
        anchor.addChild(qubitInfo)
        anchor.addChild(qubitInfo1)
        anchor.addChild(qubitInfo2)
        anchor.addChild(qubitInfo3)
        anchor.addChild(superPositionQubit)
        anchor.addChild(entangledQubit)

        
        // Add the back button
        let backButton = createButton(label: "Back", position: [-0.48, 1, -0.5])
        backButton.name = "backButton"
        anchor.addChild(backButton)

        arView.scene.addAnchor(anchor)
        arView.installGestures([.all] ,for: blueSphere)
        arView.installGestures([.all] ,for: greenSphere)
        
        // Add tap gesture recognizer to handle back button press
        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
    }
    
    //Superposition qubit scene
    func superQubitsScene() {
        guard let arView = arView else { return }

        arView.scene.anchors.removeAll()  // Remove existing content
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        // Add Heading
        let heading = ModelEntity(mesh: .generateText("QUBITS", extrusionDepth: 0.01, font: .systemFont(ofSize: 0.15)), materials: [SimpleMaterial(color: .black, isMetallic: false)])
        heading.position = [0, 1, -0.5]  // Raised position
        anchor.addChild(heading)
        
        let redSphere = ModelEntity(mesh: .generateSphere(radius: 0.1), materials: [SimpleMaterial(color: .red, isMetallic: true)])
        redSphere.generateCollisionShapes(recursive: true)
        redSphere.collision = CollisionComponent(shapes: [.generateSphere(radius: 0.1)], mode: .default, filter: .sensor)
        redSphere.position = [0.35, 0.7, -0.5]  // Raised position
        
        let backGround1 = ModelEntity(mesh: .generateBox(size: [1.7, 0.35, 0.02] , cornerRadius: 20), materials: [SimpleMaterial(color: .lightText, isMetallic: false)])
        backGround1.position = [0.35, 0.26, -0.7]
        
        let basicQubit = createButton(label: "Basic", position: [-0.25, -0.2, -0.5])
        basicQubit.name = "basicQubit"
        let superPositionQubit = createButton2(label: "Superposition", position: [0.25, -0.2, -0.5])
        superPositionQubit.name = "superPositionQubit"
        let entangledQubit = createButton3(label: "Entangled", position: [0.83, -0.2, -0.5])
        entangledQubit.name = "entangledQubit"
        
        let qubitInfo = createText(text: "A quantum property where a", position: [0, 0.35, -0.5])
        let qubitInfo1 = createText(text: "qubit exists simultaneously in multiple states,", position: [-0.28, 0.3, -0.5])
        let qubitInfo2 = createText(text: "represented as a weighted sum of |0⟩ and |1⟩,", position: [-0.25, 0.25, -0.5])
        let qubitInfo3 = createText(text: "until measured.", position: [0.2, 0.2, -0.5])
        
        let labelSuperposition = createText(text: "Superposition", position: [0.18, 0.5, -0.5])


        anchor.addChild(redSphere)

        anchor.addChild(labelSuperposition)
        anchor.addChild(backGround1)
        anchor.addChild(basicQubit)
        anchor.addChild(qubitInfo)
        anchor.addChild(qubitInfo1)
        anchor.addChild(qubitInfo2)
        anchor.addChild(qubitInfo3)
        anchor.addChild(superPositionQubit)
        anchor.addChild(entangledQubit)
        
        // Add the back button
        let backButton = createButton(label: "Back", position: [-0.48, 1, -0.5])
        backButton.name = "backButton"
        anchor.addChild(backButton)

        arView.scene.addAnchor(anchor)
        arView.installGestures([.all] ,for: redSphere)
        
        // Add tap gesture recognizer to handle back button press
        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
    }
    
    //Entangled qubit scene
    func entangledQubitsScene() {
        guard let arView = arView else { return }

        arView.scene.anchors.removeAll()  // Remove existing content
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        // Add Heading
        let heading = ModelEntity(mesh: .generateText("QUBITS", extrusionDepth: 0.01, font: .systemFont(ofSize: 0.15)), materials: [SimpleMaterial(color: .black, isMetallic: false)])
        heading.position = [0, 1, -0.5]  // Raised position
        anchor.addChild(heading)
        
        // Create spheres for |0>, |1>, and Superposition
        engreenSphere = ModelEntity(mesh: .generateSphere(radius: 0.1), materials: [SimpleMaterial(color: .green, isMetallic: true)])
        engreenSphere.generateCollisionShapes(recursive: true)
        engreenSphere.collision = CollisionComponent(shapes: [.generateSphere(radius: 0.1)], mode: .default, filter: .sensor)
        engreenSphere.position = [0.7, 0.7, -0.5]
        engreenSphere.name = "engreenSphere"
        enblueSphere = ModelEntity(mesh: .generateSphere(radius: 0.1), materials: [SimpleMaterial(color: .blue, isMetallic: true)])
        enblueSphere.generateCollisionShapes(recursive: true)
        enblueSphere.collision = CollisionComponent(shapes: [.generateSphere(radius: 0.1)], mode: .default, filter: .sensor)
        enblueSphere.position = [0.1, 0.7, -0.5]
        enblueSphere.name = "enblueSphere"
        
        let backGround1 = ModelEntity(mesh: .generateBox(size: [1.9, 0.38, 0.02] , cornerRadius: 20), materials: [SimpleMaterial(color: .lightText, isMetallic: false)])
        backGround1.position = [0.37, 0.26, -0.7]
        
        let basicQubit = createButton(label: "Basic", position: [-0.25, -0.2, -0.5])
        basicQubit.name = "basicQubit"
        let superPositionQubit = createButton2(label: "Superposition", position: [0.25, -0.2, -0.5])
        superPositionQubit.name = "superPositionQubit"
        let entangledQubit = createButton3(label: "Entangled", position: [0.83, -0.2, -0.5])
        entangledQubit.name = "entangledQubit"

        // Labels for each sphere
        let label0 = createText(text: "Qubit 1", position: [0.1, 0.5, -0.5])
        let label1 = createText(text: "Qubit 2", position: [0.7, 0.5, -0.5])
        //
        let qubitInfo = createText(text: "A quantum state where two or more", position: [0, 0.35, -0.5])
        let qubitInfo1 = createText(text: "qubits become linked, such that the state of one", position: [-0.28, 0.3, -0.5])
        let qubitInfo2 = createText(text: "directly affects the others,regardless", position: [0, 0.25, -0.5])
        let qubitInfo3 = createText(text: "of the distance between them.", position: [0, 0.2, -0.5])

        anchor.addChild(enblueSphere)
        anchor.addChild(engreenSphere)
        anchor.addChild(label0)
        anchor.addChild(label1)
        anchor.addChild(backGround1)
        anchor.addChild(basicQubit)
        anchor.addChild(qubitInfo)
        anchor.addChild(qubitInfo1)
        anchor.addChild(qubitInfo2)
        anchor.addChild(qubitInfo3)
        anchor.addChild(superPositionQubit)
        anchor.addChild(entangledQubit)

        // Add the back button
        let backButton = createButton(label: "Back", position: [-0.48, 1, -0.5])
        backButton.name = "backButton"
        anchor.addChild(backButton)

        arView.scene.addAnchor(anchor)
        arView.installGestures([.all] ,for: enblueSphere)
        arView.installGestures([.all] ,for: engreenSphere)
        
        
        // Add tap gesture recognizer to handle back button press
        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
    }
    
    //Change in colour for entangled qubits
    func syncColors(from source: ModelEntity, to target: ModelEntity) {
        guard let sourceMaterial = source.model?.materials.first as? SimpleMaterial else { return }
        target.model?.materials = [sourceMaterial]
    }
    
    // Load Quantum Gates Scene
    func loadQuantumGatesScene() {
            
            guard let arView = arView else { return }

            // Remove previous scene content
            arView.scene.anchors.removeAll()

            // Create anchor for the Quantum Gates scene
            let anchor = AnchorEntity(plane: .horizontal)

            // Create buttons for Hadamard Gate and Pauli-X Gate
            let button1 = createButton1(label: "Hadamard Gate", position: [0.1, 0.7, -0.5])
            button1.name = "HadamardGate"
            let button2 = createButton1(label: "Pauli-X Gate", position: [0.1, 0.5, -0.5])
            button2.name = "PauliXGate"
            let button3 = createButton1(label: "CNOT Gate", position: [0.1, 0.3, -0.5])
            button3.name = "CNOTGate"
            let button4 = createButton1(label: "Swap Gate", position: [0.1, 0.1, -0.5])
            button4.name = "SwapGate"
            
            let backButton = createButton(label: "Back", position: [-0.5, 1, -0.5])
            backButton.name = "backButton"
        
            let backGround = ModelEntity(mesh: .generateBox(size: [1, 1, 0.02] , cornerRadius: 20), materials: [SimpleMaterial(color: .lightText, isMetallic: false)])
            backGround.position = [0.12, 0.35, -0.6]
            

            // Add buttons to anchor
            anchor.addChild(button1)
            anchor.addChild(button2)
            anchor.addChild(button3)
            anchor.addChild(button4)
            anchor.addChild(backButton)
            anchor.addChild(backGround)

            // Add anchor to the AR scene
            arView.scene.addAnchor(anchor)

            // Add gesture recognizer for button tap
            arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))}
    
    // Load Hadamard Gate scene
    func loadHadamardGateScene() {
        
        guard let arView = arView else { return }

        arView.scene.anchors.removeAll()  // Remove existing content
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        
        let qubit = ModelEntity(mesh: .generateSphere(radius: 0.1), materials: [SimpleMaterial(color: .blue, isMetallic: true)])
        qubit.generateCollisionShapes(recursive: true)
        qubit.collision = CollisionComponent(shapes: [.generateSphere(radius: 0.1)], mode: .default, filter: .sensor)
        qubit.position = [0.1, 0.7, -0.3]
        
        let hadamardGate = ModelEntity(mesh: .generateBox(size: [0.15 , 0.15 , 0.15]), materials: [SimpleMaterial(color: .red, isMetallic: false)])
        hadamardGate.generateCollisionShapes(recursive: true)
        hadamardGate.collision = CollisionComponent(shapes: [.generateBox(size: [0.1 , 0.1 , 0.1])], mode: .default, filter: .sensor)
        hadamardGate.position = [0.7, 0.7, -0.3]
        
        let backGround1 = ModelEntity(mesh: .generateBox(size: [1.9, 0.38, 0.02] , cornerRadius: 20), materials: [SimpleMaterial(color: .lightText, isMetallic: false)])
        backGround1.position = [0.37, 0.26, -0.7]
        
        
        let sceneInfo = createText(text: "The Hadamard Gate (H-Gate) is one", position: [0, 0.35, -0.5])
        let sceneInfo1 = createText(text: "of the most fundamental quantum gates.", position: [-0.28, 0.3, -0.5])
        let sceneInfo2 = createText(text: "It is a single-qubit gate that creates", position: [0, 0.25, -0.5])
        let sceneInfo3 = createText(text: "a superposition state from a basis state.", position: [0, 0.2, -0.5])
        
        let backButtonGS = createButton(label: "Back", position: [-0.5, 1, -0.5])
        backButtonGS.name = "backButtonGS"
            
        anchor.addChild(qubit)
        anchor.addChild(hadamardGate)
        anchor.addChild(backButtonGS)
        anchor.addChild(backGround1)
        anchor.addChild(sceneInfo)
        anchor.addChild(sceneInfo1)
        anchor.addChild(sceneInfo2)
        anchor.addChild(sceneInfo3)
            
        arView.scene.addAnchor(anchor)
        
        DispatchQueue.main.async {
                    self.overlayMessage?.wrappedValue = "Drag the qubit onto the Hadamard Gate to see its effect!"
                    self.showOverlay?.wrappedValue = true
                }
        
        arView.installGestures([.all] ,for: qubit)
        
        collisionSub.append(arView.scene.subscribe(to: CollisionEvents.Began.self){event in
                    guard let entityA = event.entityA as? ModelEntity,
                          let entityB = event.entityB as? ModelEntity else { return }
            entityA.model?.materials = [SimpleMaterial(color: .red , isMetallic: false)]
            entityB.model?.materials = [SimpleMaterial(color: .red, isMetallic: false)]
                    
                })
        }

    // Load Pauli-X Gate scene
    func loadPauliXGateScene() {
        guard let arView = arView else { return }

        arView.scene.anchors.removeAll()  // Remove existing content
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        
        let qubit = ModelEntity(mesh: .generateSphere(radius: 0.1), materials: [SimpleMaterial(color: .blue, isMetallic: true)])
        qubit.generateCollisionShapes(recursive: true)
        qubit.collision = CollisionComponent(shapes: [.generateSphere(radius: 0.1)], mode: .default, filter: .sensor)
        qubit.position = [0.1, 0.7, -0.3]
        
        let pauliXgate = ModelEntity(mesh: .generateBox(size: [0.15 , 0.15 , 0.15]), materials: [SimpleMaterial(color: .yellow, isMetallic: false)])
        pauliXgate.generateCollisionShapes(recursive: true)
        pauliXgate.collision = CollisionComponent(shapes: [.generateBox(size: [0.1 , 0.1 , 0.1])], mode: .default, filter: .sensor)
        pauliXgate.position = [0.8, 0.7, -0.3]
        
        let backGround1 = ModelEntity(mesh: .generateBox(size: [1.9, 0.38, 0.02] , cornerRadius: 20), materials: [SimpleMaterial(color: .lightText, isMetallic: false)])
        backGround1.position = [0.37, 0.212, -0.7]
        
        //
        let sceneInfo = createText(text: "The Pauli-X gate is a quantum gate that", position: [0, 0.35, -0.5])
        let sceneInfo1 = createText(text: "performs a bit-flip operation on a single qubit.", position: [-0.28, 0.3, -0.5])
        let sceneInfo2 = createText(text: "It is equivalent to the classical NOT gate", position: [0, 0.25, -0.5])
        let sceneInfo3 = createText(text: "in traditional computing, as it flips", position: [0, 0.2, -0.5])
        let sceneInfo4 = createText(text: "the state of the qubit.", position: [0, 0.15, -0.5])
        
        let backButtonGS = createButton(label: "Back", position: [-0.5, 1, -0.5])
        backButtonGS.name = "backButtonGS"
            
        anchor.addChild(qubit)
        anchor.addChild(pauliXgate)
        anchor.addChild(backButtonGS)
        anchor.addChild(backGround1)
        anchor.addChild(sceneInfo)
        anchor.addChild(sceneInfo1)
        anchor.addChild(sceneInfo2)
        anchor.addChild(sceneInfo3)
        anchor.addChild(sceneInfo4)
            
        arView.scene.addAnchor(anchor)
        
        DispatchQueue.main.async {
                    self.overlayMessage?.wrappedValue = "Drag the qubit onto the Pauli X-Gate to see its effect!"
                    self.showOverlay?.wrappedValue = true
                }
        
        arView.installGestures([.all] ,for: qubit)
        
        collisionSub.append(arView.scene.subscribe(to: CollisionEvents.Began.self){event in
                    guard let entityA = event.entityA as? ModelEntity,
                          let entityB = event.entityB as? ModelEntity else { return }
            entityA.model?.materials = [SimpleMaterial(color: .green , isMetallic: false)]
            entityB.model?.materials = [SimpleMaterial(color: .yellow, isMetallic: false)]
                    
                })
        }
       
    //Load CNOT gate scene
    func loadCNOTGateScene() {
        quantCompScene()
        
        print("CNOT Gate Scene Loaded")
    }
    
    //Load SWAP gate scene
    func loadSwapGateScene() {
        quantCompScene()
        
        print("Swap Gate Scene Loaded")
    }
       
    // Load Quantum Computer scene
    func quantCompScene() {
            guard let arView = arView else { return }
            
            // Remove previous scene content
            arView.scene.anchors.removeAll()
            
            // Create a new anchor
            let newAnchor = AnchorEntity(plane: .horizontal)
            
            //Heading
            let heading = ModelEntity(mesh: .generateText("QUANTUM COMPUTER", extrusionDepth: 0.01, font: .systemFont(ofSize: 0.18)), materials: [SimpleMaterial(color: .black, isMetallic: true)])
            heading.position = [0.5, 1, -1.5]
            
            // Add the back button
            let backButton = createButton(label: "Back", position: [-0.5, 1, -1.5])
            backButton.name = "backButton1"
            
            let backGround = ModelEntity(mesh: .generateBox(size: [4.9, 1.75, 0.02] , cornerRadius: 20), materials: [SimpleMaterial(color: .lightText, isMetallic: false)])
            backGround.position = [2.11, 0.24, -3]
            
            //Info of quantum computer
            
            let quantCompInfo = createText1(text: "A quantum computer is an advanced", position: [-0.2, 0.8, -2.7])
            let quantCompInfo1 = createText1(text: "computational device that uses the principles", position: [-0.2, 0.6, -2.7])
            let quantCompInfo2 = createText1(text: "of quantum mechanics, such as superposition", position: [-0.2, 0.4, -2.7])
            let quantCompInfo3 = createText1(text: "and entanglement,to process information.", position: [-0.2, 0.2, -2.7])
            let quantCompInfo4 = createText1(text: "Unlike classical computers, it operates on", position: [-0.2, 0, -2.7])
            let quantCompInfo5 = createText1(text: "qubits, enabling it to solve complex", position: [-0.2, -0.2, -2.7])
            let quantCompInfo6 = createText1(text: "problems faster and more efficiently. ", position: [-0.2, -0.4, -2.7])
            
            newAnchor.addChild(heading)
            newAnchor.addChild(backButton)
            newAnchor.addChild(backGround)
            newAnchor.addChild(quantCompInfo)
            newAnchor.addChild(quantCompInfo1)
            newAnchor.addChild(quantCompInfo2)
            newAnchor.addChild(quantCompInfo3)
            newAnchor.addChild(quantCompInfo4)
            newAnchor.addChild(quantCompInfo5)
            newAnchor.addChild(quantCompInfo6)
            
            // Add anchor to the ARView
            arView.scene.addAnchor(newAnchor)
            arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
            
            
            // Load the model asynchronously
            Task {
                do {
                    // Use the new `ModelEntity.init(named:in:)` method
                    let quantumComputerModel = try await ModelEntity(named: "QuantCompModel")
                    
                    // Ensure changes to `position` and `scale` are performed on the main actor
                    await MainActor.run {
                        quantumComputerModel.position = SIMD3<Float>(-0.7, -0.56, -3)
                        quantumComputerModel.generateCollisionShapes(recursive: true)
                        
                        // Add the model to the anchor
                        newAnchor.addChild(quantumComputerModel)
                        arView.installGestures([.all], for: quantumComputerModel)
                    }
                } catch {
                    print("Failed to load model: \(error)")
                }
            }
        }
    
    // Create labels for each sphere
    func createText(text: String, position: SIMD3<Float>) -> ModelEntity {
        let label = ModelEntity(mesh: .generateText(text, extrusionDepth: 0.01, font: .boldSystemFont(ofSize: 0.05)), materials: [SimpleMaterial(color: .black, isMetallic: true)])
        label.position = position
        return label
    }
    
    //Quantum computer text
    func createText1(text: String, position: SIMD3<Float>) -> ModelEntity {
        let label = ModelEntity(mesh: .generateText(text, extrusionDepth: 0.01, font: .boldSystemFont(ofSize: 0.18)), materials: [SimpleMaterial(color: .black, isMetallic: true)])
        label.position = position
        return label
    }
    
    // Standard Button
    func createButton(label: String, position: SIMD3<Float>) -> ModelEntity {
        let button = ModelEntity(mesh: .generateBox(size: [0.3, 0.1, 0.02], cornerRadius: 10), materials: [SimpleMaterial(color: .placeholderText, isMetallic: true)])
    //        button.components[OpacityComponent.self] = .init(opacity: 0.7)
        button.generateCollisionShapes(recursive: true)
        button.position = position
        
        // Create the text outline
            let outlineText = ModelEntity(
                mesh: .generateText(label, extrusionDepth: 0.007, font: .systemFont(ofSize: 0.052))
            )
        outlineText.model?.materials = [SimpleMaterial(color: .cyan, isMetallic: true)]
            outlineText.position = [-0.07, -0.02, 0.008] // Slightly behind the main text

        // Add text on top of the button
        let buttonText = ModelEntity(mesh: .generateText(label, extrusionDepth: 0.005, font: .boldSystemFont(ofSize: 0.05)))
        buttonText.model?.materials = [SimpleMaterial(color: .black, isMetallic: true)]
        
        buttonText.position = [-0.07, -0.02, 0.01]
        button.addChild(outlineText)
        button.addChild(buttonText)
        
        return button
    }

    // Bigger buttons for length labels
    func createButton1(label: String, position: SIMD3<Float>) -> ModelEntity {
        let button = ModelEntity(mesh: .generateBox(size: [0.7, 0.1, 0.02], cornerRadius: 10), materials: [SimpleMaterial(color: .placeholderText, isMetallic: true)])
    //        button.components[OpacityComponent.self] = .init(opacity: 0.7)
        button.generateCollisionShapes(recursive: true)
        button.position = position
        
        // Create the text outline
            let outlineText = ModelEntity(
                mesh: .generateText(label, extrusionDepth: 0.007, font: .systemFont(ofSize: 0.052))
            )
        outlineText.model?.materials = [SimpleMaterial(color: .cyan, isMetallic: true)]
            outlineText.position = [-0.13, -0.02, 0.008] // Slightly behind the main text
        
        
        // Add text on top of the button
        let buttonText = ModelEntity(mesh: .generateText(label, extrusionDepth: 0.005, font: .boldSystemFont(ofSize: 0.05)))
        buttonText.model?.materials = [SimpleMaterial(color: .black, isMetallic: true)]
        buttonText.position = [-0.13, -0.02, 0.01]
        button.addChild(outlineText)
        button.addChild(buttonText)
        
        return button
    }
    
    //Superposition button
    func createButton2(label: String, position: SIMD3<Float>) -> ModelEntity {
        let button = ModelEntity(mesh: .generateBox(size: [0.5, 0.1, 0.02], cornerRadius: 10), materials: [SimpleMaterial(color: .placeholderText, isMetallic: true)])
    //        button.components[OpacityComponent.self] = .init(opacity: 0.7)
        button.generateCollisionShapes(recursive: true)
        button.position = position
        
        // Create the text outline
            let outlineText = ModelEntity(
                mesh: .generateText(label, extrusionDepth: 0.007, font: .systemFont(ofSize: 0.052))
            )
        outlineText.model?.materials = [SimpleMaterial(color: .cyan, isMetallic: true)]
            outlineText.position = [-0.138, -0.02, 0.008] // Slightly behind the main text
        
        
        // Add text on top of the button
        let buttonText = ModelEntity(mesh: .generateText(label, extrusionDepth: 0.005, font: .boldSystemFont(ofSize: 0.05)))
        buttonText.model?.materials = [SimpleMaterial(color: .black, isMetallic: true)]
        buttonText.position = [-0.138, -0.02, 0.01]
        button.addChild(buttonText)
        button.addChild(outlineText)
        
        return button
    }
    
    //Entangled button
    func createButton3(label: String, position: SIMD3<Float>) -> ModelEntity {
        let button = ModelEntity(mesh: .generateBox(size: [0.4, 0.1, 0.02], cornerRadius: 10), materials: [SimpleMaterial(color: .placeholderText, isMetallic: true)])
    //        button.components[OpacityComponent.self] = .init(opacity: 0.7)
        button.generateCollisionShapes(recursive: true)
        button.position = position
        
        // Create the text outline
            let outlineText = ModelEntity(
                mesh: .generateText(label, extrusionDepth: 0.007, font: .systemFont(ofSize: 0.052))
            )
        outlineText.model?.materials = [SimpleMaterial(color: .cyan, isMetallic: true)]
            outlineText.position = [-0.125, -0.02, 0.008] // Slightly behind the main text
        
        
        // Add text on top of the button
        let buttonText = ModelEntity(mesh: .generateText(label, extrusionDepth: 0.005, font: .boldSystemFont(ofSize: 0.05)))
        buttonText.model?.materials = [SimpleMaterial(color: .black, isMetallic: true)]
        buttonText.position = [-0.125, -0.02, 0.01]
        button.addChild(buttonText)
        button.addChild(outlineText)
        
        return button
    }
    
    //Quantum computer button
    func createButton4(label: String, position: SIMD3<Float>) -> ModelEntity {
        let button = ModelEntity(mesh: .generateBox(size: [0.7, 0.1, 0.02], cornerRadius: 10), materials: [SimpleMaterial(color: .placeholderText, isMetallic: true)])
    //        button.components[OpacityComponent.self] = .init(opacity: 0.7)
        button.generateCollisionShapes(recursive: true)
        button.position = position
        
        // Create the text outline
            let outlineText = ModelEntity(
                mesh: .generateText(label, extrusionDepth: 0.007, font: .systemFont(ofSize: 0.052))
            )
        outlineText.model?.materials = [SimpleMaterial(color: .cyan, isMetallic: true)]
            outlineText.position = [-0.25, -0.02, 0.008] // Slightly behind the main text
        
        
        // Add text on top of the button
        let buttonText = ModelEntity(mesh: .generateText(label, extrusionDepth: 0.005, font: .boldSystemFont(ofSize: 0.05)))
        buttonText.model?.materials = [SimpleMaterial(color: .black, isMetallic: true)]
        buttonText.position = [-0.25, -0.02, 0.01]
        button.addChild(outlineText)
        button.addChild(buttonText)
        
        return button
    }
    
    // Handle button tap for scene change
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        guard let arView = arView else { return }
        let tapLocation = recognizer.location(in: arView)
        
        if let tappedEntity = arView.entity(at: tapLocation) as? ModelEntity {
            if tappedEntity.name == "Qubits" {
                basicQubitsScene()
            } else if tappedEntity.name == "Quantum Gates" {
                loadQuantumGatesScene()
            } else if tappedEntity.name == "Quantum Computer" {
                quantCompScene()
            }else if tappedEntity.name == "Quantum Circuits" {
                quantCompScene()
            }else if tappedEntity.name == "next" {
                TopicScene()
                print("home screen tapped")
            }else if tappedEntity.name == "backButton" {
                TopicScene()  // Load home screen when tapped
            }else if tappedEntity.name == "HadamardGate" {
                loadHadamardGateScene()
            }else if tappedEntity.name == "backButtonGS" {
                loadQuantumGatesScene() // Load home screen when tapped
            } else if tappedEntity.name == "PauliXGate" {
                loadPauliXGateScene()
            }else if tappedEntity.name == "SwapGate" {
                loadSwapGateScene()
            }else if tappedEntity.name == "CNOTGate" {
                loadCNOTGateScene()
            }else if tappedEntity.name == "backButton" {
                unloadScene()
                TopicScene()
            }else if tappedEntity.name == "backButton1" {
                unloadScene()
                loadQuantumGatesScene()  // Load home screen when tapped
            }else if tappedEntity.name == "basicQubit" {
                basicQubitsScene()  // Load home screen when tapped
            }else if tappedEntity.name == "superPositionQubit" {
                superQubitsScene()  // Load home screen when tapped
            }else if tappedEntity.name == "entangledQubit" {
                entangledQubitsScene()  // Load home screen when tapped
            }else if tappedEntity.name == "engreenSphere" {
                tappedEntity.model?.materials = [SimpleMaterial(color: UIColor.random(), isMetallic: false)]
                syncColors(from: engreenSphere, to: enblueSphere)
            }else if tappedEntity.name == "enblueSphere" {
                tappedEntity.model?.materials = [SimpleMaterial(color: UIColor.random(), isMetallic: false)]
                syncColors(from: enblueSphere, to: engreenSphere)
            }
        }
    }
}

