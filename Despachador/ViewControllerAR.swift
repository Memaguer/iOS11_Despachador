//
//  ViewController.swift
//  ARKitTemplate
//
//  Created by MBG on 11/22/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit
import CoreLocation
import GameplayKit

class ViewControllerAR: UIViewController, ARSKViewDelegate, CLLocationManagerDelegate {
    
    //@IBOutlet var sceneView: ARSKView!
    @IBOutlet var sceneView: ARSKView!
    
    let locationManager = CLLocationManager()
    var userLocation = CLLocation()
    var sitesJSON : JSON!
    var sites = [UUID: String]()
    var userHeading  = 0.0
    var headingStep = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        // Load the SKScene from 'Scene.sks'
        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        let labelNode = SKLabelNode(text: sites[anchor.identifier])
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        
        let newSize = labelNode.frame.size.applying(CGAffineTransform(scaleX: 1.1, y: 1.5))
        
        let backgroundNode = SKShapeNode(rectOf: newSize, cornerRadius: 10)
        
        let randomColor = UIColor(hue: CGFloat(GKRandomSource.sharedRandom().nextUniform()), saturation: 0.5, brightness: 0.4, alpha: 0.9)
        backgroundNode.fillColor = randomColor
        
        backgroundNode.strokeColor = randomColor.withAlphaComponent(1.0)
        backgroundNode.lineWidth = 2
        
        backgroundNode.addChild(labelNode)
        
        return backgroundNode
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
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        userLocation = location
        
        DispatchQueue.global().async {
            self.updateSite()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        DispatchQueue.global().async {
            self.headingStep += 1
            
            if self.headingStep < 2 { return }
            
            self.userHeading = newHeading.magneticHeading
            self.locationManager.stopUpdatingHeading()
            self.createSites()
        }
    }
    
    func updateSite() {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(userLocation.coordinate.latitude)%7C\(userLocation.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        guard let url = URL(string: urlString) else { return }
        
        if let data = try? Data(contentsOf: url){
            sitesJSON = JSON(data)
            locationManager.startUpdatingHeading()
        }
    }
    
    func createSites() {
        // Get items for JSON
        for page in sitesJSON["query"]["pages"].dictionaryValue.values {
            // Get longitude and latitude for sites
            let lat = page["coordinates"][0]["lat"].doubleValue
            let lon = page["coordinates"][0]["lon"].doubleValue
            let location = CLLocation(latitude: lat, longitude: lon)
            // Get distances and direction between user and sites
            let distance = Float(userLocation.distance(from: location))
            let azimut = direction(from: userLocation, to: location)
            // Get angle between user and site
            let angle = azimut - userHeading
            let angleRad = degreesToRadians(angle)
            // Create matrix for horizontal rotation (anchor)
            let horizontalRotation = simd_float4x4(SCNMatrix4MakeRotation(Float(angleRad), 1, 0, 0))
            // Create matrix for vertical rotation (distance)
            let verticalRotation = simd_float4x4(SCNMatrix4MakeRotation(-0.3 + Float(distance/500), 0, 1, 0))
            // Multiply matrices and ARKit
            let rotation = simd_mul(horizontalRotation, verticalRotation)
            // Create a new matrix
            guard let sceneView = self.view as? ARSKView else{ return }
            guard let currentFrame = sceneView.session.currentFrame else { return }
            let rotation2 = simd_mul(currentFrame.camera.transform, rotation)
            // Put anchor on scene and give it an id
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -(distance / 1000)
            let transform = simd_mul(rotation2, translation)
            let anchor = ARAnchor(transform: transform)
            sceneView.session.add(anchor: anchor)
            sites[anchor.identifier] = "\(page["title"].string!) - \(Int(distance)) metros"
        }
    }
    
    func degreesToRadians(_ degrees: Double) -> Double {
        return degrees * Double.pi / 180.0
    }
    
    func radiansToDegrees(_ radians: Double) -> Double {
        return radians * 180.0 / Double.pi
    }
    
    func direction(from p1: CLLocation, to p2: CLLocation) -> Double {
        let dif_long = p2.coordinate.longitude - p1.coordinate.longitude
        
        let y = sin(dif_long) * cos(p2.coordinate.longitude)
        let x = cos(p1.coordinate.latitude) * sin(p2.coordinate.latitude) - sin(p1.coordinate.latitude) * cos(p2.coordinate.latitude) * cos (dif_long)
        
        let atan_rad = atan2(x, y)
        
        return radiansToDegrees(atan_rad)
    }
}
