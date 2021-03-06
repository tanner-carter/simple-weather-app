//
//  InitialViewController.swift
//  weather-app
//
//  Created by Tanner Carter on 10/2/18.
//  Copyright © 2018 Tanner Carter. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class InitialViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public var locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        determineAppropriateSegue()
    }
    
    func determineAppropriateSegue() {
        //TODO: Check if the user already entered their ZIP
        
        // Determine whether the user has authorized us to use their location
        // If they have, move straight to WeatherController which will request location
        // If they havent, display a controller which will ask the user for their zip code
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            performSegue(withIdentifier: "initialToWeather", sender: self)
            
        case .denied, .notDetermined, .restricted:
            performSegue(withIdentifier: "initialToZip", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "initialToWeather" {
            let controller = segue.destination as! WeatherViewController
            controller.locationManager = locationManager
        }
    }
    
}

