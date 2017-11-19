//
//  InterfaceController.swift
//  WDespachador Extension
//
//  Created by MBG on 11/16/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import WatchKit
import UIKit


class InterfaceController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    @IBOutlet var stationName: WKInterfaceLabel!
    @IBOutlet var amountPeople: WKInterfaceLabel!
    
    var buses: [Bus] =  []
    let urlSession: URLSession = URLSession(configuration: .default)
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        /*var bus = Bus(licensePlate: "NVA-174", driver: "Jesus Molina", distance: 34, capacity: 34, time: 21)
        buses.append(bus)
        bus = Bus(licensePlate: "GBG-119", driver: "Roberto Días", distance: 21, capacity: 100, time: 9)
        buses.append(bus)
        bus = Bus(licensePlate: "HRF-332", driver: "Humberto Días", distance: 4, capacity: 4, time: 4)
        buses.append(bus)*/
        //getBusesFromApi()
        let station = context as! Station
        for bus in station.buses {
            self.buses.append(bus)
        }
        self.stationName.setText("\(station.name!)")
        self.amountPeople.setText("\(station.passenger!)")
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        print("Imprime el WiilActive ========")
        self.table.setNumberOfRows(buses.count, withRowType: "BusRow")
        for index in 0 ..< buses.count {
            let rowBus = table.rowController(at: index) as! BusCellWatch
            rowBus.image.setImage(self.buses[index].busImage)
            rowBus.plates.setText("\(self.buses[index].licensePlate!)")
            rowBus.time.setText("\(self.buses[index].time!) min.")
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        let bus = buses[rowIndex]
        return bus
    }
    
    func getBusesFromApi(){
        let urlRequest = URLRequest(url: URL(string: "https://kuhni-fb8ab.firebaseio.com/buses.json")!)
        
        let task = urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            
            DispatchQueue.main.sync {
                do{
                    let decoder = JSONDecoder()
                    let buses = try decoder.decode(BusAStruct.self, from: data)
                    print(buses.result)
                    for bus in buses.result {
                        print(bus.licensePlate)
                        let newBus = Bus(licensePlate: bus.licensePlate, driver: bus.driver, distance: bus.distance, capacity: bus.capacity, time: bus.time)
                        self.buses.append(newBus)
                    }
                    self.willActivate()
                } catch{
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }

}
