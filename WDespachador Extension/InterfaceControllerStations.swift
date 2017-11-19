//
//  InterfaceControllerStations.swift
//  WDespachador Extension
//
//  Created by MBG on 11/18/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import WatchKit
import UIKit

class InterfaceControllerStations: WKInterfaceController {
    
    
    @IBOutlet var loandingLabel: WKInterfaceLabel!
    @IBOutlet var stationTable: WKInterfaceTable!
    var stations: [Station] =  []
    var station1: [Bus] =  []
    var station2: [Bus] =  []
    var station3: [Bus] =  []
    var station4: [Bus] =  []
    var station5: [Bus] =  []
    var station6: [Bus] =  []
    var station7: [Bus] =  []
    var station8: [Bus] =  []
    var station9: [Bus] =  []
    var station10: [Bus] =  []
    var flag = false
    let urlSession: URLSession = URLSession(configuration: .default)
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        /*var station = Station(name:"Izazaga")
        stations.append(station)
        station = Station(name:"Xola")
        stations.append(station)
        station = Station(name:"General Anaya")
        stations.append(station)*/
        
        getStationFromApi()
        getBusesFromApi()
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        //=============== Loading ================
        if flag {
           loandingLabel.setHidden(true)
        }
        flag = true
        
        //========================================
        self.stationTable.setNumberOfRows(stations.count, withRowType: "StationRow")
        for index in 0 ..< stations.count {
            let rowStation = stationTable.rowController(at: index) as! StationCellWatch
            rowStation.image.setImage(self.stations[index].image)
            rowStation.name.setText(self.stations[index].name)
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func getStationFromApi(){
        let urlRequest = URLRequest(url: URL(string: "https://kuhni-fb8ab.firebaseio.com/stations.json")!)
        
        let task = urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            
            DispatchQueue.main.sync {
                do{
                    let decoder = JSONDecoder()
                    let stations = try decoder.decode(StationWStruct.self, from: data)
                    print(stations.result)
                    for station in stations.result {
                        let newStation = Station(name: station.name, id: station.id, passenger: station.passenger)
                        self.stations.append(newStation)
                    }
                    self.willActivate()
                } catch{
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
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
                        switch bus.station {
                        case 1:
                            self.station1.append(newBus)
                            break
                        case 2:
                            self.station2.append(newBus)
                            break
                        case 3:
                            self.station3.append(newBus)
                            break
                        case 4:
                            self.station4.append(newBus)
                            break
                        case 5:
                            self.station5.append(newBus)
                            break
                        case 6:
                            self.station6.append(newBus)
                            break
                        case 7:
                            self.station7.append(newBus)
                            break
                        case 8:
                            self.station8.append(newBus)
                            break
                        case 9:
                            self.station9.append(newBus)
                            break
                        case 10:
                            self.station10.append(newBus)
                            break
                        default:
                            self.station1.append(newBus)
                            break
                        }
                    }
                    self.willActivate()
                } catch{
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        let buses: [Bus]
        switch rowIndex {
        case 0:
            buses = self.station1
            self.stations[0].insertBuses(buses: buses)
            break
        case 1:
            buses = self.station2
            self.stations[1].insertBuses(buses: buses)
            break
        case 2:
            buses = self.station3
            self.stations[2].insertBuses(buses: buses)
            break
        case 3:
            buses = self.station4
            self.stations[3].insertBuses(buses: buses)
            break
        case 4:
            buses = self.station5
            self.stations[4].insertBuses(buses: buses)
            break
        case 5:
            buses = self.station6
            self.stations[5].insertBuses(buses: buses)
            break
        case 6:
            buses = self.station7
            self.stations[6].insertBuses(buses: buses)
            break
        case 7:
            buses = self.station8
            self.stations[7].insertBuses(buses: buses)
            break
        case 8:
            buses = self.station9
            self.stations[8].insertBuses(buses: buses)
            break
        case 9:
            buses = self.station10
            self.stations[9].insertBuses(buses: buses)
            break
        default:
            buses = self.station1
            self.stations[0].insertBuses(buses: buses)
            break
        }
        let station = stations[rowIndex]
        return station
    }
    
}

