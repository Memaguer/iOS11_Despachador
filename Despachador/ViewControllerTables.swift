
//
//  ViewControllerTables.swift
//  Despachador
//
//  Created by MBG on 10/28/17.
//  Copyright © 2017 MBG. All rights reserved.
//
import UIKit
import FirebaseDatabase

class ViewControllerTables: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    var segmentSelected: Int!
    var buses : [Bus] = []
    var nextBuses: [Bus] = []
    var actualBuses: [Bus] = []
    var onRouteBuses : [Bus] = []
    
    var postData = [String] ()
    
    var routeId: Int?
    var stationId: Int?
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    let urlSession: URLSession = URLSession(configuration: .default)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getBusesFromFirebase()
        
        getBusesFromApi()
        
        buses = nextBuses
        
        for bus in buses {
            print("==> \(bus.licensePlate)")
        }
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getBusesFromApi(){
        let urlRequest = URLRequest(url: URL(string: "https://kuhni-fb8ab.firebaseio.com/buses.json")!)
        
        let task = urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            
            DispatchQueue.main.sync {
                do{
                    let decoder = JSONDecoder()
                    let buses = try decoder.decode(BusStruct.self, from: data)
                    print(buses.result)
                    for bus in buses.result {
                        print(bus.licensePlate)
                        let newBus = Bus(licensePlate: bus.licensePlate, driver: bus.driver, distance: bus.distance, capacity: bus.capacity, time: bus.time)
                        if bus.station < 4 {
                            self.nextBuses.append(newBus)
                        } else if bus.station > 4 {
                            self.onRouteBuses.append(newBus)
                        }
                        else{
                            self.actualBuses.append(newBus)
                        }
                    }
                } catch{
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
    
    func getBusesFromFirebase(){
        ref = Database.database().reference()
        databaseHandle = ref?.child("buses").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject]{
                print(dictionary)
                print(dictionary.count)
                let licensePlate = dictionary["licensePlate"] as? String
                let driver = dictionary["driver"] as? String
                let distance = dictionary["distance"] as? Int
                let capacity = dictionary["capacity"] as? Int
                let time = dictionary["time"] as? Int
                let station = dictionary["station"] as? Int
                let bus = Bus(licensePlate: licensePlate!, driver: driver!, distance: distance!, capacity: capacity!, time: time!)
                if station! < 4 {
                    self.nextBuses.append(bus)
                } else if station! > 4 {
                    self.onRouteBuses.append(bus)
                }
                else{
                    self.actualBuses.append(bus)
                }
            }
        })
    }
    
    @IBAction func switchTableAction(_ sender: UISegmentedControl) {
        segmentSelected = sender.selectedSegmentIndex
        
        switch segmentSelected {
        case 0:
            buses = nextBuses
        case 1:
            buses = actualBuses
        case 2:
            buses = onRouteBuses
        default:
            print("Nada")
        }
        
        tableView.reloadData()
    }
}






extension ViewControllerTables : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.buses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "BusCell"
        let bus = buses[indexPath.row]
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCellBus
        cell.plateImage.image = bus.plateImage
        cell.distanceLabel.text = "A \(bus.distance!) metros"
        cell.timeLabel.text = "a \(bus.time!) minutos aprox."
        cell.capacityLabel.text = "capacidad del \(bus.capacity!)%"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBusDetail"{
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let selectedBus = self.buses[indexPath.row]
                let newViewController = segue.destination as! ViewControllerBusDetail
                newViewController.bus = selectedBus
            }
        }
    }
}
