//
//  profilVC.swift
//  FoursquareAppClone
//
//  Created by Mustafa Ali KILCI on 1.12.2022.
//

import UIKit
import Parse

class profilVC: UIViewController {

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

    @IBAction func exitbtn(_ sender: Any) {
        
        PFUser.logOutInBackground{(error) in
            
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okbtn = UIAlertAction(title: "OK !", style: UIAlertAction.Style.default , handler: nil)
                alert.addAction(okbtn)
                self.present(alert, animated: true , completion: nil)
                
            }
            else{
                self.performSegue(withIdentifier: "exitVC", sender: nil)

            }
        }
        
        
    }
}
