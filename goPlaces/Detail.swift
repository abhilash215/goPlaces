//
//  Detail.swift
//  goPlaces
//
//  Created by abhilash uday on 12/11/16.
//  Copyright © 2016 AbhilashSU. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import FirebaseDatabase
import FirebaseAuth
import CoreLocation

class Detail: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var distancelabel: UILabel!
    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var address: UILabel!
    var locationManager = CLLocationManager()

    var place: Places?
     var ref: FIRDatabaseReference!
    @IBOutlet weak var namelabel: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        ref =  FIRDatabase.database().reference()
        print(ref)
        determineMyCurrentLocation()
        
        if let place = self.place {
             let locality = CLLocationCoordinate2DMake(Double(place.latitude)!, Double(place.longitude)!)
            let annotation = MKPointAnnotation()
            annotation.coordinate = locality
            annotation.title = place.address
            mapview.selectAnnotation(annotation, animated: true)
            mapview.addAnnotation(annotation)
            // Display a small region around the annotation
            let span = MKCoordinateSpanMake(0.006, 0.006)
            let region = MKCoordinateRegionMake(locality, span)
            mapview.setRegion(region, animated: true)
            namelabel.text =  place.name
            address.text =  "Address: "+place.address
            category.text =  "Website: "+place.website
            
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Please try again",preferredStyle: UIAlertControllerStyle.Alert )
                let action = UIAlertAction(title: "OK",style: .Default,handler: nil)
                alert.addAction(action)

        }
    }
    
    
    ////////////////////////////
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
       let  currentlat = (String)(userLocation.coordinate.latitude)
      let   currentlon = (String)(userLocation.coordinate.longitude)
  //      print("user latitude = \(userLocation.coordinate.latitude)")
    //    print("user longitude = \(userLocation.coordinate.longitude)")
        
        
        if let place=self.place{
            let mylat = Double(currentlat)
            let mylon = Double(currentlon)
            
        let myLocation = CLLocation(latitude: mylat!, longitude: mylon!)
        let lat = Double(place.latitude)
        let lon = Double(place.longitude)
        //My buddy's location
        let myBuddysLocation = CLLocation(latitude: lat!, longitude: lon!)
        //Measuring my distance to my buddy's (in km)
        let distance = myLocation.distanceFromLocation(myBuddysLocation) / 1600
            let y = Double(round(10*distance)/10)
        //Display the result in km
     //   print(String(format: "The distance to my buddy is %.01fmiles", distance))
            let dis = String(y)
            distancelabel.text = (format: "You are "+dis+" miles from "+namelabel.text!)
            
        }
        
        
    }

    
    ////////////////////////////
    
    
    
    
    
//    
//    @IBAction func backbutton(sender: AnyObject) {
//        
//        self.performSegueWithIdentifier("backidentifier", sender: self)
//    }
//    

      /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
