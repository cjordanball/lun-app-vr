//
//  ViewController.swift
//  LunApp
//
//  Created by C. Jordan Ball III on 7/4/21.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var time: Float = 0.0;
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Create a new sphere object
        let sphere = SCNSphere(radius: 1.0);
        
        // Put a texture map of the moon on it
        
        let material = SCNMaterial();
        material.diffuse.contents = UIImage(named: "art.scnassets/8k_moon.jpg");
        sphere.materials = [material];
        
        //create and position our node
        let node = SCNNode();
        node.geometry = sphere;
        node.position = SCNVector3(x: 0, y: 0, z: -5.0);
        
        let _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { Timer in
            time += 0.1;
            let rotation: Float = time * 0.314;
            node.eulerAngles = SCNVector3(x: 0.0, y: rotation, z: 0.0);
        }
        
        node.geometry = sphere;
        
        // Attach the node to the view
        sceneView.scene.rootNode.addChildNode(node);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration.isSupported ? ARWorldTrackingConfiguration() :
            ARImageTrackingConfiguration();
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
}
