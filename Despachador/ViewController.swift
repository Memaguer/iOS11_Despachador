//
//  ViewController.swift
//  Despachador
//
//  Created by MBG on 10/28/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var startButton: UIButton!
    @IBOutlet var stationPickerView: UIPickerView!
    let stations = ["Selecciona tu estación", "Izazaga", "Xola", "General Anaya", "Huipulco", "Nicolas Bravo", "Xochimilco", "La Noria", "Periférico", "Estadio Azteca", "Viaducto"];
    var stationId: Int = 0;
    var station: Station!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 15
        startButton.clipsToBounds = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stations[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        station = Station(id: row, name: stations[row])
        self.stationId = row
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let station = stations[row]
        let stationName = NSAttributedString(string: station, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 20.0)!,NSAttributedStringKey.foregroundColor:UIColor.white])
        return stationName
    }
    
    @IBAction func startAction(_ sender: Any) {
        if self.stationId != 0 {
            performSegue(withIdentifier: "stationSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stationSegue" {
            let loadingView = segue.destination as! ViewControllerLoadingStation
            loadingView.station = self.station
        }
    }
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue) {
        print("====salir")
    }
    

}

