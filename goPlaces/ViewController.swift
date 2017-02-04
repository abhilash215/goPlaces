//
//  ViewController.swift
//  goPlaces
//
//  Created by abhilash uday on 12/10/16.
//  Copyright © 2016 AbhilashSU. All rights reserved.
//

import UIKit

class ViewController:  UIViewController, UITableViewDelegate,UITextFieldDelegate,UITableViewDataSource{
 var cityName: String!
    var city1: String = ""
    @IBOutlet weak var searchfield: UITextField!
     var places = [Places]()
    
    @IBOutlet weak var placesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bgColor = UIColor(red:0.15, green:0.14, blue:0.22, alpha:1.0)
        self.placesTableView.backgroundColor = bgColor
        self.placesTableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        self.placesTableView.delegate = self
        self.placesTableView.tableFooterView = UIView()
        self.searchfield.delegate = self
    }
    
     func viewDidAppear() {
        super.viewDidAppear(true)
        searchfield.text = cityName
        
    }
    
    
    @IBAction func search(sender: AnyObject) {
        searchfield.resignFirstResponder()
        places.removeAll()
        self.placesTableView.reloadData()
        
        
        //API
        
        // factual api and key
        let apiBegining = "http://api.v3.factual.com/t/places?KEY=BXlykcLo11hzxSISFp92ZIfLceXLyEDy0Ir51VA9&filters={\"locality\":{\"$eq\":\""
        let apiEnding = "\"}}"
        cityName = searchfield.text
        cityName = cityName.lowercaseString
      //  print(cityName)
        let apiEndPoint = apiBegining + cityName + apiEnding
        
         city1 = cityName
        let encodedString = apiEndPoint.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        guard let url = NSURL(string: encodedString!)
            else {
                return
        }
        
        let urlRequest = NSURLRequest(URL: url)
        // Create NSURL session to send the request
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let task = session.dataTaskWithRequest(urlRequest, completionHandler: parsedata)
        task.resume()

        
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    
    //func animations
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(1,0.1,1)
        UIView.animateWithDuration(0.50, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,2)
        })
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = placesTableView.dequeueReusableCellWithIdentifier("placescell", forIndexPath: indexPath) as! PlacesTableviewCell
        let place = places[indexPath.row]
        cell.namelabel.text  =  place.name
        cell.addresslabel.text = place.address
        cell.backgroundColor = UIColor(red:0.82, green:0.29, blue:0.35, alpha:1)
        
        return cell
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        searchfield.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailrestaurantview" {
            let detailViewController = segue.destinationViewController as! Detail
            
            // Get the cell that generated this segue.
            if let selectedRestaurantCell = sender as? PlacesTableviewCell {
                let indexPath = placesTableView.indexPathForCell(selectedRestaurantCell)!
                let selectedRestaurant = places[indexPath.row]
                detailViewController.place = selectedRestaurant
            }
        } else {
            print("This should not be happening")
        }
    }

    
    
    
     func parsedata(data:NSData?, response: NSURLResponse?, error: NSError?){
        // Ensure proper data is received.
        guard let reply = data else {
            return
        }
        
        guard error == nil else {
            print(error)
            return
        }
        
        let jsonData: [String:AnyObject]
        do {
            
            jsonData = try NSJSONSerialization.JSONObjectWithData(reply, options: []) as! [String:AnyObject]
        } catch {
            print("error trying to convert data to JSON")
            return
        }
        
        let status = jsonData["status"] as! String
        if(status == "error") {
            print("Error Type: \(jsonData["error_type"])")
            print("Message from server: \(jsonData["message"])")
        } else {
            
            if let response = jsonData["response"] as? [String: AnyObject] {
                let count:Int = response["included_rows"] as! Int
        //        print (response)
                
                if count == 0 {
                    let alertController = UIAlertController(title: "Error", message: "No places found for given city", preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                    alertController.addAction(okAction)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in self.presentViewController(alertController, animated: true, completion: nil)})
                    return
                }
                
                let places_anyobject = response["data"]
                let hotel_array = (places_anyobject as! NSArray) as Array
                for hotel_data in hotel_array {
                    let hotel = hotel_data as! [String:AnyObject]
                    let name:String = hotel["name"] as! String
                    if(hotel["address"] != nil){
                        if(hotel["website"] != nil){
                             if(hotel["latitude"] != nil){
                                if(hotel["longitude"] != nil){
                            let address:String = hotel["address"] as! String
                            let website:String =  hotel["website"] as! String
                                    let latitude:Double = hotel["latitude"] as! Double
                                    let longitude:Double = hotel["longitude"] as! Double
                                    let place = Places (name: name,address: address, website: website,longitude: String(longitude) ,latitude: String(latitude)  )
                    self.places += [place]
                                }
                            }
                        }
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.placesTableView.reloadData()})
            } else {
                print("Response is not in the expected JSON format")
            }
                
        }
        
    }
    
}



