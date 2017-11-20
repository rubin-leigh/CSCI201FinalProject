//
//  FilterVC.swift
//  FinalProject
//
//  Created by Leigh Rubin on 11/7/17.
//  Copyright © 2017 Leigh Rubin. All rights reserved.
//

import UIKit

class FilterVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let userActual = User.currentUser
    let filters = Array(User.currentUser.filters.keys)
    @IBOutlet weak var filterTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.filterTable.delegate = self
        self.filterTable.dataSource = self
        self.navigationItem.title = "Select Filters"
        self.navigationItem.setHidesBackButton(true, animated: false)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userActual.filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let filterName:String = self.filters[indexPath.row]
        
        cell.textLabel?.text = "\(filterName)"
        
        if(self.userActual.filters[self.filters[indexPath.row]])!{
            cell.accessoryType = .checkmark
            cell.tintColor = UIColor.white
            cell.backgroundColor = UIColor.green
            cell.textLabel?.textColor = UIColor.white
        }
        else {
            cell.accessoryType = .none
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.black
        }
        
        cell.textLabel?.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.userActual.filters[self.filters[indexPath.row]])!{
            self.userActual.filters[self.filters[indexPath.row]] = false
        }
        else {
            self.userActual.filters[self.filters[indexPath.row]] = true
        }
        filterTable.deselectRow(at: indexPath, animated: true)
        self.filterTable.reloadData()
    }

    @IBAction func applyFilters(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
