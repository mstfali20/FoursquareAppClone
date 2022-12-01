//
//  SiginUpVC.swift
//  FoursquareAppClone
//
//  Created by Mustafa Ali KILCI on 1.12.2022.
//

import UIKit
import Parse

class SiginUpVC: UIViewController {

    
    @IBOutlet weak var passwordtext: UITextField!
    
    @IBOutlet weak var usernameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func siginUpBtn(_ sender: Any) {
        if usernameText.text != "" && passwordtext.text != "" {
          
               let user = PFUser()
            user.username = usernameText.text!
            user.password = passwordtext.text!
            
            user.signUpInBackground{(succes , error) in
                if error != nil {self.makealert(titleInput: "Error", MesageInput: error?.localizedDescription ?? "Error")}else{print("OK!!")}
                self.performSegue(withIdentifier: "oneVC", sender: nil)
            }
            
        }else {
           
            makealert(titleInput: "Error", MesageInput: "Username / Password ?")
        }
        
    }
    func makealert (titleInput:String , MesageInput:String){
        
        let alert = UIAlertController(title: titleInput, message: MesageInput, preferredStyle: UIAlertController.Style.alert)
        let okbuton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default ,handler: nil)
        alert.addAction(okbuton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
