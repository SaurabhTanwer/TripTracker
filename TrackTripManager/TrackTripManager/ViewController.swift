//
//  ViewController.swift
//  TrackTripManager
//
//  Created by Saurabh Tanwer on 15/06/21.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager?
    var TrackTimer: Timer?
    var arrJsonObject:[String:Any]?
    var intTripId:Int = 0
    var startTime:Date?
    var endTime:Date?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        
        

    }
    
    @objc func updatelocationCode(){
        locationManager?.startUpdatingLocation()
        
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            // you're good to go!
        }
        else if status == .authorizedWhenInUse{
            
        }else if status == .denied{
            locationManager?.requestAlwaysAuthorization()
        }else if status == .restricted{
            locationManager?.requestAlwaysAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            intTripId = intTripId + 1
            let Locationtime = Date()
            print("New location is \(location)")
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
            print(location.horizontalAccuracy)
            let locationJson = ["trip_id":intTripId,"start_time":startTime,"end_time":endTime] as [String : Any]
            sleep(5)
//            : "1",
//            "start_time":"2021-04-06T10:10:10Z",
//            "end_time": "2021-04-06T11:11:11Z",
//            "locations":[
//            {
//            "latitude": 1.235,
//            "longitide": 8.984,
//            "timestamp": "2021-04-06T10:10:10Z",
//            "accuracy": 10.9
        }
        locationManager?.stopUpdatingLocation()
    }
    @IBAction func acnBtnStart(_ sender: UIButton) {
        TrackTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updatelocationCode), userInfo: nil, repeats: true)
        
        RunLoop.current.add(self.TrackTimer!, forMode: RunLoop.Mode.default)
        RunLoop.current.run()
        startTime = Date()
    }
    
    @IBAction func acnBtnStop(_ sender: UIButton) {
        TrackTimer?.invalidate()
        endTime = Date()
    }
   
}

