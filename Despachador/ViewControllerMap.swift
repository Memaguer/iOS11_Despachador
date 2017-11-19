//
//  ViewControllerMap.swift
//  Despachador
//
//  Created by MBG on 10/31/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase

class ViewControllerMap: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var mapCentered = false
    var geoFire: GeoFire!
    var geoFireRef: DatabaseReference!
    
    let locationManager = CLLocationManager()   // Configuración de la posición del usuario
    let urlSession: URLSession = URLSession(configuration: .default)

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.geoFireRef = Database.database().reference()
        self.geoFire = GeoFire(firebaseRef: self.geoFireRef)
        
        self.mapView.delegate = self
        self.mapView.userTrackingMode = .follow
        self.locationManager.delegate = self
        locationAuthStatus()
        
        getStations()
        //getBuses()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            self.mapView.showsUserLocation = true
        }
        else{
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func centerMap(on location: CLLocation){
        
        // Centrarse en la ubucación y ver 1000 metros a la redonda
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000)
        
        // Activar una animación en la posición marcada
        self.mapView.setRegion(region, animated: true)
        
    }
    
    // Se activa cuando se actualiza la información de la localización del usuario
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        // Centrar gps en el celular y permitir el scroll
        if !mapCentered{
            if let location = userLocation.location{
                centerMap(on: location)
                mapCentered = true
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: MKAnnotationView?
        let annotationIdentifier = "Bus"
        
        if annotation.isKind(of: MKUserLocation.self){
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
            annotationView?.image = #imageLiteral(resourceName: "people (1)")
        } else if let dequedaAnnotation = self.mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier){
            annotationView = dequedaAnnotation
            annotationView?.annotation = annotation
        } else{
             annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView, let busAnnotation = annotation as? BusAnnotation {
            annotationView.canShowCallout = true
            annotationView.image = #imageLiteral(resourceName: "minbusA")
            
            let button = UIButton()
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            button.setImage(#imageLiteral(resourceName: "interface"), for: .normal)
            annotationView.rightCalloutAccessoryView = button
        }
        
        if let annotationView = annotationView, let stationAnnotation = annotation as? StationAnnotation {
            annotationView.canShowCallout = true
            annotationView.image = #imageLiteral(resourceName: "mini_flag")
            
            let button = UIButton()
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            button.setImage(#imageLiteral(resourceName: "interface"), for: .normal)
            annotationView.rightCalloutAccessoryView = button
        }
        return annotationView
    }
    
    func createSighting(forLocation location: CLLocation, with busId:Int){
        // Coloca el camión en su posición y le pone un identificador
        self.geoFire.setLocation(location, forKey: "\(busId)")
    }
    
    func getStations(){
        let urlRequest = URLRequest(url: URL(string: "https://kuhni-fb8ab.firebaseio.com/stations.json")!)
        let task = urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.sync {
                do{
                    let decoder = JSONDecoder()
                    let stations = try decoder.decode(StationStruct.self, from: data)
                    //print(stations.result)
                    for station in stations.result {
                        let distanceSpan: CLLocationDegrees = 200
                        let stationLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(station.latitude, station.longitude)
                        self.mapView.setRegion(MKCoordinateRegionMakeWithDistance(stationLocation, distanceSpan, distanceSpan), animated: true)
                        let stationPin = StationAnnotation(coordinate: stationLocation, name: station.name, subtitle: station.route)
                        self.mapView.addAnnotation(stationPin)
                    }
                } catch{
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
    
    func getBuses(){
        let urlRequest = URLRequest(url: URL(string: "https://kuhni-fb8ab.firebaseio.com/buses.json")!)
        let task = urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.sync {
                do{
                    let decoder = JSONDecoder()
                    let buses = try decoder.decode(BusStruct.self, from: data)
                    //print(buses.result)
                    for bus in buses.result {
                        let distanceSpan: CLLocationDegrees = 200
                        let bsuCSCampusLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(bus.latitude, bus.longitude)
                        self.mapView.setRegion(MKCoordinateRegionMakeWithDistance(bsuCSCampusLocation, distanceSpan, distanceSpan), animated: true)
                        let bsuCSClasPin = BusAnnotation(coordinate: bsuCSCampusLocation, licensePlate: bus.licensePlate, subtitle: "capacidad: \(bus.capacity)%")
                        self.mapView.addAnnotation(bsuCSClasPin)
                    }
                } catch{
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }

}
