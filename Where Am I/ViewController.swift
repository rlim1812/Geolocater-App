//
//  ViewController.swift
//  Where Am I
//
//  Created by Ryan Lim on 7/16/16.
//  Copyright © 2016 Ryan Lim. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {


    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var address: UILabel!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        let userLocation: CLLocation = locations[0]
        self.latitude.text = "\(userLocation.coordinate.latitude)"
        self.longitude.text = "\(userLocation.coordinate.longitude)"
        self.course.text = "\(userLocation.course)"
        self.speed.text = "\(userLocation.speed)"
        self.altitude.text = "\(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            if error != nil {
                print(error)
            } else {
                if let p = placemarks!.first {
                    var subThoroughFare:String = ""
                    if p.subThoroughfare != nil {
                        subThoroughFare = p.subThoroughfare!
                    }
                    self.address.text = "\(subThoroughFare) \(p.thoroughfare!) \n \(p.subLocality!) \(p.subAdministrativeArea!) \n \(p.postalCode!) \n \(p.country!)"
                }
            }
        })
    }
}

