//
//  ViewController.swift
//  FoursquareAppClone
//
//  Created by Mustafa Ali KILCI on 1.12.2022.
//

import UIKit
import Parse

class ViewController: UIViewController {
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
     /*   let parseObject = PFObject(className: "Fruts")
        parseObject["name"] = "ss"
        parseObject["caories"] = 130
        parseObject["namsade"] = "asda"
        parseObject.saveInBackground{
            (succes, error) in
            if error != nil{
                print(error?.localizedDescription)
            }else{print("basarili ")}
        }*/
      
        
    
    }
    
    func makealert (titleInput:String , MesageInput:String){
        
        let alert = UIAlertController(title: titleInput, message: MesageInput, preferredStyle: UIAlertController.Style.alert)
        let okbuton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default ,handler: nil)
        alert.addAction(okbuton)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func siginbtn(_ sender: Any) {
        if usernameText.text != "" && passwordText.text != "" {
          
            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!){(user , error)in
                if error != nil {
                    self.makealert(titleInput: "Error", MesageInput: error?.localizedDescription ?? "Error")}
                else{
                    print("OK!!")
                    print(user?.username)
                    
                    self.performSegue(withIdentifier: "sigininVc", sender: nil)
                
                    
                }
            }
            
        
            
        }else {
           
            makealert(titleInput: "Error", MesageInput: "Username / Password ?")
        }
    }
    
}

