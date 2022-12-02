//
//  AddPlaceVC.swift
//  FoursquareAppClone
//
//  Created by Mustafa Ali KILCI on 1.12.2022.
//

import UIKit
import Parse

class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    @IBOutlet weak var placenametext: UITextField!
    @IBOutlet weak var placetypetext: UITextField!
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var placepropertistext: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageview.isUserInteractionEnabled = true
        let gesturRecocgnizer = UITapGestureRecognizer(target: self, action: #selector(choseImages))
        imageview.addGestureRecognizer(gesturRecocgnizer)
    }
    
    @objc func choseImages(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        // pickerController.sourceType = .camera
        present(pickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageview.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true , completion: nil)
    }
    

   
    @IBAction func nextbtn(_ sender: Any) {
        
        
       
        
        
        if( placenametext.text != "" && placetypetext.text != "" && placepropertistext.text != "" ){
            
            if let chosenImages = imageview.image{
                let placeModel = PlaceModel.sharadInstance
                
                placeModel.placeName = placenametext.text!
                placeModel.placeType = placetypetext.text!
                placeModel.placepropertis = placepropertistext.text!
                placeModel.placeImages = chosenImages
                
                
                
            }
            
          
            self.performSegue(withIdentifier: "AddVc2", sender: nil)
            
            
        }
        else{
            makealert(titleInput: "Error", MesageInput: "PlaceName / PlaceType / PlacePropertis / PlaceImages  ???")
        }
        
    }
    
    func makealert (titleInput:String , MesageInput:String){
        
        let alert = UIAlertController(title: titleInput, message: MesageInput, preferredStyle: UIAlertController.Style.alert)
        let okbuton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default ,handler: nil)
        alert.addAction(okbuton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
