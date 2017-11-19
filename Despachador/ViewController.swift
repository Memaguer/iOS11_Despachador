//
//  ViewController.swift
//  Despachador
//
//  Created by MBG on 10/28/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var rutePickerView: UIPickerView!
    @IBOutlet var stationPickerView: UIPickerView!
    
    let rutes = ["Selecciona tu ruta", "Izazaga - Xochimilco", "Xochimilco - Izazaga"];
    let stations = ["Selecciona tu estación", "Izazaga", "Xola", "Gnrl. Anaya", "Estadio Azteca", "Xochimilco"];
    var routeId: Int = 0;
    var stationId: Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == rutePickerView){
            return rutes[row]
        }
        else{
            return stations[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == rutePickerView){
            return rutes.count
        }
        else{
            return stations.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == rutePickerView){
            print(rutes[row])
            self.routeId = row
        }
        else{
            print(stations[row])
            self.stationId = row
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if(pickerView == rutePickerView){
            let route = rutes[row]
            let routeName = NSAttributedString(string: route, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 15.0)!,NSAttributedStringKey.foregroundColor:UIColor.white])
            return routeName
        }
        else{
            let station = stations[row]
            let stationName = NSAttributedString(string: station, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 15.0)!,NSAttributedStringKey.foregroundColor:UIColor.white])
            return stationName
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stationSegue"{
            let table = segue.destination as! TabBarController
            table.routeId = self.routeId;
            table.stationId = self.stationId
        }
    }
    

}

