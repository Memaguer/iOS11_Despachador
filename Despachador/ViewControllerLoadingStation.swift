//
//  ViewControllerLoadingStation.swift
//  Despachador
//
//  Created by MBG on 11/19/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit

class ViewControllerLoadingStation: UIViewController {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var name: UILabel!
    
    var stationId: Int!
    var buses : [Bus] = []
    var nextBuses: [Bus] = []
    var actualBuses: [Bus] = []
    var onRouteBuses : [Bus] = []
    var station: Station!
    var flag = false
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let urlSession: URLSession = URLSession(configuration: .default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stationId = self.station.id
        self.name.text = self.station.name!
        self.image.image = self.station.image!
        
        if flag == false{
            getBusesFromApi()
        }
        else{
            sleep(1)
            performSegue(withIdentifier: "ViewTabSegue", sender: self)
            appDelegate.actualBuses = self.actualBuses
            appDelegate.nextBuses = self.nextBuses
            appDelegate.onRouteBuses = self.onRouteBuses
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func getBusesFromApi(){
        let urlRequest = URLRequest(url: URL(string: "https://kuhni-fb8ab.firebaseio.com/buses.json")!)
        
        let task = urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            
            DispatchQueue.main.sync {
                do{
                    let decoder = JSONDecoder()
                    let buses = try decoder.decode(BusStruct.self, from: data)
                    for bus in buses.result {
                        let newBus = Bus(licensePlate: bus.licensePlate, driver: bus.driver, distance: bus.distance, capacity: bus.capacity, time: bus.time)
                        if bus.station == self.stationId - 1{
                            // ==== save next buses ====
                            self.nextBuses.append(newBus)
                        } else if bus.station == self.stationId + 1 {
                            // ==== save previous buses ====
                            self.onRouteBuses.append(newBus)
                        } else if bus.station == self.stationId {
                            // ==== save current buses ====
                            self.actualBuses.append(newBus)
                        }
                    }
                    self.flag = true
                    self.viewDidLoad()
                    
                } catch{
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
}

