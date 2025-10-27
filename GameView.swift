import UIKit
import SceneKit

class GameView: SCNView {

    private let sceneRoot = SCNScene()
    private let planetNode = SCNNode()

    override init(frame: CGRect, options: [String : Any]? = nil) {
        super.init(frame: frame, options: options)
        setupScene()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupScene()
    }

    private func setupScene() {
        scene = sceneRoot
        allowsCameraControl = true
        backgroundColor = .black

        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(0, 0, 15)
        sceneRoot.rootNode.addChildNode(cameraNode)

        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(10, 10, 10)
        sceneRoot.rootNode.addChildNode(lightNode)

        let sphere = SCNSphere(radius: 2.0)
        sphere.firstMaterial?.diffuse.contents = UIImage(named: "earth_texture.jpg")
        planetNode.geometry = sphere
        sceneRoot.rootNode.addChildNode(planetNode)

        let spin = CABasicAnimation(keyPath: "rotation")
        spin.fromValue = SCNVector4(0, 1, 0, 0)
        spin.toValue = SCNVector4(0, 1, 0, Float.pi * 2)
        spin.duration = 10
        spin.repeatCount = .infinity
        planetNode.addAnimation(spin, forKey: "planet-spin")
    }
}
