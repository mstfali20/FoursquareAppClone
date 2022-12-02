//
//  AddPlaceVC2.swift
//  FoursquareAppClone
//
//  Created by Mustafa Ali KILCI on 1.12.2022.
//

import UIKit
import MapKit
import Parse

class AddPlaceVC2: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    
    @IBOutlet weak var mapkit: MKMapView!
    var locaatıonManager = CLLocationManager()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backbtn))
        
        
      
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(savebtn))
        
        
        
        mapkit.delegate = self
        locaatıonManager.delegate = self
        locaatıonManager.desiredAccuracy = kCLLocationAccuracyBest
        locaatıonManager.requestWhenInUseAuthorization()
        locaatıonManager.startUpdatingLocation()
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(choosLocation(gesturRecognizer: )))
        recognizer.minimumPressDuration = 3
        mapkit.addGestureRecognizer(recognizer)
        
        // Do any additional setup after loading the view.
    }
    @objc func choosLocation (gesturRecognizer : UIGestureRecognizer){
        
        if gesturRecognizer.state == UIGestureRecognizer.State.began {
            
            let touches = gesturRecognizer.location(in: self.mapkit)
            let coordinate = self.mapkit.convert(touches, toCoordinateFrom: self.mapkit)
            
            let annatation = MKPointAnnotation()
            annatation.coordinate = coordinate
            annatation.title = PlaceModel.sharadInstance.placeName
            annatation.subtitle = PlaceModel.sharadInstance.placeType
            self.mapkit.addAnnotation(annatation)
            
            
            
            PlaceModel.sharadInstance.placelatitude = String(coordinate.latitude)
            PlaceModel.sharadInstance.placelongitude = String(coordinate.longitude)
            
            
            
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
        let region = MKCoordinateRegion(center: location, span: span)
        mapkit.setRegion(region, animated: true)
        
       
    }

    
    @objc func savebtn(){
        let placeModel = PlaceModel.sharadInstance
        let object = PFObject(className: "Places")
        object["name"] = placeModel.placeName
        object["Type"] = placeModel.placeType
        object["Propertis"] = placeModel.placepropertis
        object["Latitude"] = placeModel.placelatitude
        object["Longitude"] = placeModel.placelongitude
        
        if let imageData = placeModel.placeImages.jpegData(compressionQuality: 0.5)
        {
            object["Images"] = PFFileObject(name: "image.jpg", data: imageData)
        }
        object.saveInBackground{(succes , error) in
            if error != nil{
                self.makealert(titleInput: "Error", MesageInput: error?.localizedDescription ?? "Erro")
            }else{
                self.performSegue(withIdentifier: "saveVc", sender: nil)
            }
            
        }
        
        //
       
    }
    
    @objc func backbtn(){
        
        self.dismiss(animated: true, completion: nil)
       
    }
    
    func makealert (titleInput:String , MesageInput:String){
        
        let alert = UIAlertController(title: titleInput, message: MesageInput, preferredStyle: UIAlertController.Style.alert)
        let okbuton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default ,handler: nil)
        alert.addAction(okbuton)
        self.present(alert, animated: true, completion: nil)
    }

}
