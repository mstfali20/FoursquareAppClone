//
//  DetailVc.swift
//  FoursquareAppClone
//
//  Created by Mustafa Ali KILCI on 1.12.2022.
//

import UIKit
import MapKit
import Parse

class DetailVc: UIViewController, MKMapViewDelegate{
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var propretistext: UILabel!
    @IBOutlet weak var typtext: UILabel!
    @IBOutlet weak var nametext: UILabel!
    
    @IBOutlet weak var mapview: MKMapView!
    
    var chosenPlaceID = ""
    
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        mapview.delegate = self
      
        // Do any additional setup after loading the view.
    }
    
    func getData (){
        
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", contains: chosenPlaceID)
        query.findObjectsInBackground{(object, error)in
            if error != nil{
                self.makealert(titleInput: "Error", MesageInput: error?.localizedDescription ?? "Error")
            }else{
                
                if object != nil {
                    if object!.count > 0 {
                        let myobject = object![0]
                        
                        
                        
                        if let placeName = myobject.object(forKey: "name") as? String{
                            self.nametext.text = placeName
                        }
                        if let placeType = myobject.object(forKey: "Type") as? String{
                            self.typtext.text = placeType
                        }
                        if let placePropertis = myobject.object(forKey: "Propertis") as? String{
                            self.propretistext.text = placePropertis
                        }
                       
                        if let placeName = myobject.object(forKey: "name") as? String{
                            self.nametext.text = placeName
                        }
                        if let placeLatitude = myobject.object(forKey: "Latitude") as? String{
                            if let placeLatitudeDouble = Double(placeLatitude){
                                self.chosenLatitude = placeLatitudeDouble
                            }
                        }
                        if let placeLongitude = myobject.object(forKey: "Longitude") as? String{
                            if let placeLongitudeDouble = Double(placeLongitude){
                                self.chosenLongitude = placeLongitudeDouble
                            }
                        }
                        
                        if let imgeData = myobject.object(forKey: "Images") as? PFFileObject
                        {
                            imgeData.getDataInBackground{(data , error)in
                                if error == nil {
                                    if data != nil {
                                        self.imageview.image = UIImage(data: data!)
                                    }
                            
                                }
                               
                            }
                        }
                        
                        
                        let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
                        let spam = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                        let region = MKCoordinateRegion(center: location, span: spam)
                        self.mapview.setRegion(region, animated: true)
                        
                        let annatation = MKPointAnnotation()
                        annatation.coordinate = location
                        annatation.title = self.nametext.text
                        annatation.subtitle = self.typtext.text
                        self.mapview.addAnnotation(annatation)
                        
                        print(self.chosenLongitude)
                        print(self.chosenLatitude)
                        
                      
                    }
                    
                }
            }
        }

    }
    

    func makealert (titleInput:String , MesageInput:String){
        
        let alert = UIAlertController(title: titleInput, message: MesageInput, preferredStyle: UIAlertController.Style.alert)
        let okbuton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default ,handler: nil)
        alert.addAction(okbuton)
        self.present(alert, animated: true, completion: nil)
    }

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let resulId = "Pin "
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: resulId)
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: resulId)
            pinView?.canShowCallout = true
            pinView?.tintColor = UIColor.black
            
            let button  = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
            
            
            
        }
        else{
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.chosenLatitude != 0.0 && self.chosenLongitude != 0.0 {
            let requestLocation = CLLocation(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
            CLGeocoder().reverseGeocodeLocation(requestLocation ){(placemarks , error)in
              
                
                
            
                
                
                if let placemark = placemarks {
                    if placemark.count > 0 {
                        let newPlacemark = MKPlacemark(placemark: placemark[0])
                        
                        let item = MKMapItem(placemark: newPlacemark)
                        item.name = self.nametext.text
                        let launcOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving] // araba seectik
                        item.openInMaps()
                        item.openInMaps(launchOptions: launcOptions)
                        
                        
                    }}
                
            }
        }
    }
}
