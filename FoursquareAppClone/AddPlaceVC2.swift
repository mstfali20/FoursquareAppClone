//
//  AddPlaceVC2.swift
//  FoursquareAppClone
//
//  Created by Mustafa Ali KILCI on 1.12.2022.
//

import UIKit
import MapKit

class AddPlaceVC2: UIViewController{

    
    @IBOutlet weak var mapkit: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backbtn))
        
        
      
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(savebtn))
        
        // Do any additional setup after loading the view.
    }
    

    
    @objc func savebtn(){
        
        
    }
    
    @objc func backbtn(){
        
        self.dismiss(animated: true, completion: nil)
       
    }

}
