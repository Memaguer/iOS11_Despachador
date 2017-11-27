
//
//  ViewControllerTables.swift
//  Despachador
//
//  Created by MBG on 10/28/17.
//  Copyright © 2017 MBG. All rights reserved.
//
import UIKit

class ViewControllerTables: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var actualButton: UIButton!
    @IBOutlet var onRouteButton: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var segmentSelected: Int!
    var segmentSelectedPrevious: Int!
    var cellCount = 0
    var stationId = Int()
    var buses: [Bus] = []
    var nextBuses: [Bus] = []
    var actualBuses: [Bus] = []
    var onRouteBuses: [Bus] = []
    
    var postData = [String] ()
    
    let urlSession: URLSession = URLSession(configuration: .default)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("segue control: nextBuses :\(nextBuses.count)")
        nextBuses = appDelegate.nextBuses
        actualBuses = appDelegate.actualBuses
        onRouteBuses = appDelegate.onRouteBuses
        self.segmentSelected = 0
        //getBusesFromApi()
        navigationSettings()
        createButtons()
        resetButtons()
        
        tableSettings()
        self.showActualBuses(self.actualBuses)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getBusesFromApi(){
        let urlRequest = URLRequest(url: URL(string: "https://kuhni-fb8ab.firebaseio.com/buses.json")!)
        
        let task = urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            
            //DispatchQueue.main.sync {
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
            //}
        })
        task.resume()
    }
    
    func navigationSettings() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func tableSettings() {
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        let backgroundTable = UIImageView(image: #imageLiteral(resourceName: "bluePolygon"))
        backgroundTable.contentMode = .scaleAspectFill
        self.tableView.backgroundView = backgroundTable
    }
    
    func createButtons() {
        //  ==== First button ====
        let firstLabel = UILabel()
        firstLabel.text = "\(nextBuses.count)"
        firstLabel.textColor = UIColor.white
        firstLabel.font = UIFont(name: "Arial", size: 40)
        firstLabel.textAlignment = NSTextAlignment.center
        firstLabel.frame = CGRect.init(x: 0, y: nextButton.frame.height * 0.5, width: nextButton.frame.width, height: nextButton.frame.height * 0.2)
        nextButton.addSubview(firstLabel)
        //  ==== Second button ====
        let secondLabel = UILabel()
        secondLabel.textColor = UIColor.white
        secondLabel.font = UIFont(name: "Arial", size: 40)
        secondLabel.text = "\(actualBuses.count)"
        secondLabel.textAlignment = NSTextAlignment.center
        secondLabel.frame = CGRect.init(x: 0, y: actualButton.frame.height * 0.5, width: actualButton.frame.width, height: actualButton.frame.height * 0.2)
        actualButton.addSubview(secondLabel)
        //  ==== Third button ====
        let thirdLabel = UILabel()
        thirdLabel.textColor = UIColor.white
        thirdLabel.font = UIFont(name: "Arial", size: 40)
        thirdLabel.text = "\(actualBuses.count)"
        thirdLabel.textAlignment = NSTextAlignment.center
        thirdLabel.frame = CGRect.init(x: 0, y: onRouteButton.frame.height * 0.5, width: onRouteButton.frame.width, height: onRouteButton.frame.height * 0.2)
        onRouteButton.addSubview(thirdLabel)
    }
    
    func resetButtons() {
        //  ==== First button ====
        self.nextButton.backgroundColor = UIColor.clear
        let borderNextButton = UILabel()
        borderNextButton.backgroundColor = UIColor.init(red: 34/255, green: 209/255, blue: 169/255, alpha: 1)
        borderNextButton.text = ""
        borderNextButton.frame = CGRect.init(x: 0, y: self.nextButton.frame.height * 0.85, width: self.nextButton.frame.width, height: self.nextButton.frame.height * 0.15)
        self.nextButton.addSubview(borderNextButton)
        //  ==== Second button ====
        self.actualButton.backgroundColor = UIColor.clear
        let borderActualButton = UILabel()
        borderActualButton.backgroundColor = UIColor.init(red: 253/255, green: 185/255, blue: 44/255, alpha: 1)
        borderActualButton.text = ""
        borderActualButton.frame = CGRect.init(x: 0, y: self.actualButton.frame.height * 0.85, width: self.actualButton.frame.width, height: self.actualButton.frame.height * 0.15)
        self.actualButton.addSubview(borderActualButton)
        //  ==== Third button ====
        self.onRouteButton.backgroundColor = UIColor.clear
        let borderOnRouteButton = UILabel()
        borderOnRouteButton.backgroundColor = UIColor.init(red: 242/255, green: 95/255, blue: 116/255, alpha: 1)
        borderOnRouteButton.text = ""
        borderOnRouteButton.frame = CGRect.init(x: 0, y: self.onRouteButton.frame.height * 0.85, width: self.onRouteButton.frame.width, height: self.nextButton.frame.height * 0.15)
        self.onRouteButton.addSubview(borderOnRouteButton)
    }
    
    func buttonSelected() {
        switch segmentSelected {
        case 0:
            self.nextButton.backgroundColor = UIColor.init(red: 34/255, green: 209/255, blue: 169/255, alpha: 1)
        case 1:
            self.actualButton.backgroundColor = UIColor.init(red: 253/255, green: 185/255, blue: 44/255, alpha: 1)
        case 2:
            self.onRouteButton.backgroundColor = UIColor.init(red: 242/255, green: 95/255, blue: 116/255, alpha: 1)
        default: break
        }
    }
    
    @IBAction func showNextBuses(_ sender: Any) {
        self.segmentSelectedPrevious = self.segmentSelected
        self.segmentSelected = 0
        buses = nextBuses
        resetButtons()
        buttonSelected()
        tableView.reloadData()
    }
    
    @IBAction func showActualBuses(_ sender: Any) {
        self.segmentSelectedPrevious = self.segmentSelected
        self.segmentSelected = 1
        buses = actualBuses
        resetButtons()
        buttonSelected()
        tableView.reloadData()
    }
    
    
    @IBAction func showOnRouteBuses(_ sender: Any) {
        self.segmentSelectedPrevious = self.segmentSelected
        self.segmentSelected = 2
        buses = onRouteBuses
        resetButtons()
        buttonSelected()
        tableView.reloadData()
    }
    
    @IBAction func swipeRightTable(_ sender: Any) {
        if self.segmentSelected == 1 {
            self.showNextBuses(self.nextButton)
        } else if self.segmentSelected == 2 {
            self.showActualBuses(self.actualBuses)
        }
    }
    
    @IBAction func swipeLeftTable(_ sender: Any) {
        if segmentSelected == 0 {
            self.showActualBuses(self.actualBuses)
        } else if self.segmentSelected == 1 {
            self.showOnRouteBuses(self.onRouteButton)
        }
    }
    
    
}

extension ViewControllerTables : UITableViewDataSource, UITableViewDelegate{
    
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
        cell.distanceLabel.text = "\(bus.distance!) m."
        cell.timeLabel.text = "\(bus.time!) min."
        cell.capacityLabel.text = "\(bus.capacity!)% de capacidad"
        
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        let bgColorView = UIView()
        switch segmentSelected {
        case 0:
            bgColorView.backgroundColor = UIColor.init(red: 34/255, green: 209/255, blue: 169/255, alpha: 1)
        case 1:
            bgColorView.backgroundColor = UIColor.init(red: 253/255, green: 185/255, blue: 44/255, alpha: 1)
        case 2:
            bgColorView.backgroundColor = UIColor.init(red: 242/255, green: 95/255, blue: 116/255, alpha: 1)
        default: break
        }
        cell.selectedBackgroundView = bgColorView
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let margin: CGFloat
        if self.segmentSelected == 0 || self.segmentSelectedPrevious == 2 {
            margin = -550
        }
        else {
            margin = 550
        }
        let transform = CATransform3DTranslate(CATransform3DIdentity, margin, 0, 0)
        cell.layer.transform = transform
        UIView.animate(withDuration: 0.3) {
            cell.layer.transform = CATransform3DIdentity
        }
        
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
