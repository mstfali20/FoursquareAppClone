//
//  TableViewVC.swift
//  FoursquareAppClone
//
//  Created by Mustafa Ali KILCI on 1.12.2022.
//

import UIKit

class TableViewVC: UIViewController, UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButton))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem=UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(profilButton))
        
        tableview.delegate = self
        tableview.dataSource = self
        // 

        // Do any additional setup after loading the view.
    }
    
    @objc func addButton(){
        
        performSegue(withIdentifier: "AddVc", sender: nil)
     
    }
    
    @objc func profilButton(){
        
       
        
        performSegue(withIdentifier: "settingVC", sender: nil)
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
           cell.textLabel?.text = "test"
           return cell
    }
    

  

}
