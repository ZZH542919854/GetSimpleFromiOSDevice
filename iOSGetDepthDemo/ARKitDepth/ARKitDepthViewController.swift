//
//  ViewController.swift
//  swiftTableController
//
//  Created by 张增辉 on 2021/2/2.
//

import UIKit
import ARKit
import MetalKit

class ARKitDepthViewController: UIViewController {
    lazy var depthImageView:UIImageView = {
        var image:UIImageView = UIImageView.init(frame: CGRect.init(x: 30, y: 30, width: 192, height: 256))
        return image
    }()
    lazy var sceneView: ARSCNView = {
        var sce = ARSCNView.init(frame: view.frame)
        return sce
    }()
    private let faceNode = SCNNode()

    private var depthImage: CIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard ARFaceTrackingConfiguration.isSupported else { fatalError() }

        sceneView.delegate = self
        sceneView.automaticallyUpdatesLighting = true
        sceneView.scene = SCNScene()
        
        view.addSubview(sceneView)
        
        view.addSubview(depthImageView)



    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        
        let config = ARWorldTrackingConfiguration()
        if #available(iOS 14.0, *) {
            if(ARWorldTrackingConfiguration.supportsFrameSemantics(.smoothedSceneDepth)){
                config.frameSemantics = .smoothedSceneDepth
                sceneView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
            }else{
                sceneView.session.run(configuration, options: [.resetTracking,.removeExistingAnchors])
            }
        } else {
            
            sceneView.session.run(configuration, options: [.resetTracking,.removeExistingAnchors])
            // Fallback on earlier versions
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        sceneView.session.pause()
        super.viewWillDisappear(animated)
    }
}

extension ARKitDepthViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.global(qos: .default).async {
            guard let frame = self.sceneView.session.currentFrame else { return }
            if let depthImage = frame.transformedSceneDepthMap() {
                DispatchQueue.main.sync {
                    self.depthImageView.image = UIImage.init(ciImage: depthImage)
                }
                
            }
        }
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        print("trackingState: \(camera.trackingState)")
    }
    
}



extension ARFrame {
    func transformedDepthImage(targetSize: CGSize) -> CIImage? {
        guard let depthData = capturedDepthData else { return nil }
        return depthData.depthDataMap.transformedImage(targetSize: CGSize(width: targetSize.height, height: targetSize.width), rotationAngle: -CGFloat.pi/2)
    }
    //TODO:
    func transformedSceneDepthMap()->CIImage?{
        let pixel = self.smoothedSceneDepth?.depthMap
        return pixel?.transformToDepthMap()
    }
}
