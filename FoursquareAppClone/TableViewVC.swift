//
//  TableViewVC.swift
//  FoursquareAppClone
//
//  Created by Mustafa Ali KILCI on 1.12.2022.
//

import UIKit
import Parse

class TableViewVC: UIViewController, UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableview: UITableView!
    
    var placeNameArry = [String]()
    var placeNameIdArry = [String]()
    
    var selectID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButton))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem=UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(profilButton))
        getData()
        tableview.delegate = self
        tableview.dataSource = self
        // 

        // Do any additional setup after loading the view.
    }
    
    func getData () {
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground{(objects , error)in
            if error != nil {
                self.makealert(titleInput: "Error", MesageInput: error?.localizedDescription ?? "Error")
                
            }else{
                if objects != nil
                {
                    self.placeNameArry.removeAll(keepingCapacity: false)
                    self.placeNameIdArry.removeAll(keepingCapacity: false)
                    for object in objects!{
                        if let placeName = object.object(forKey: "name") as? String{
                            if let placeId = object.objectId {
                                self.placeNameArry.append(placeName)
                                self.placeNameIdArry.append(placeId)
                            }
                            
                            
                        }
                    }
                    
                    self.tableview.reloadData()
                }
                
            }
            
        }
        
        
    }
    
    @objc func addButton(){
        
        performSegue(withIdentifier: "AddVc", sender: nil)
     
    }
    
    @objc func profilButton(){
        
       
        
        performSegue(withIdentifier: "settingVC", sender: nil)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailVC" {
            let destinationVC = segue.destination as! DetailVc
            destinationVC.chosenPlaceID = selectID
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectID = placeNameIdArry[indexPath.row]
        self.performSegue(withIdentifier: "DetailVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNameArry[indexPath.row]
           return cell
    }
    
    func makealert (titleInput:String , MesageInput:String){
        
        let alert = UIAlertController(title: titleInput, message: MesageInput, preferredStyle: UIAlertController.Style.alert)
        let okbuton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default ,handler: nil)
        alert.addAction(okbuton)
        self.present(alert, animated: true, completion: nil)
    }
    
  

}
