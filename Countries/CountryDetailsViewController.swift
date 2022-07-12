//
//  CountryDetailsViewController.swift
//  Countries
//
//  Created by Adam Paluszewski on 29/06/2022.
//

import UIKit

class CountryDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var bottomTableView: UITableView!

    var country: Country!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomTableView.delegate = self
        bottomTableView.dataSource = self
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = country.name.official
    
        let flagIcon = UIBarButtonItem(title: country.flag, style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = flagIcon
        flagIcon.isEnabled = false

        bottomTableView.separatorStyle = .singleLine


        let backgroundImage = UIImage(named: "globe.jpg")
        let imageView = UIImageView(image: backgroundImage)
        self.bottomTableView.backgroundView = imageView
        bottomTableView.backgroundView?.layer.opacity = 0.40

    }
    
    
    
//MARK: - TableView methods
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
//        header.textLabel?.textAlignment = NSTextAlignment.right
        header.textLabel?.textColor = .black
        
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 11
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
        

    
        
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let sectionName: String

            switch section {
                case 0: sectionName = "Common name"
                case 1: sectionName = "Official name"
                case 2: sectionName = "Capital"
                case 3: sectionName = "Population"
                case 4: sectionName = "Region"
                case 5: sectionName = "Landlocked"
                case 6: sectionName = "Phone prefix"
                case 7: sectionName = "Web adress"
                case 8: sectionName = "Side of road for car riding"
                case 9: sectionName = "Timezone"
                case 10: sectionName = "Link to GoogleMaps"
                
                default: sectionName = "aaa"
            }
            
            return sectionName
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    
        if section == 0 {
            return 30
        } else {
            return 20
        }
        
    }

    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        cell.backgroundColor = .white
    
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        
            
        switch indexPath.section {
            case 0: cell.textLabel?.text = country.name.common
            case 1: cell.textLabel?.text = country.name.official
            case 2: cell.textLabel?.text = country.capital?[0]
            case 3: cell.textLabel?.text = String(country.population)
            case 4: cell.textLabel?.text = country.region
            case 5: cell.textLabel?.text = String(country.landlocked)
            case 6: cell.textLabel?.text = (country.idd?.root ?? "Error") + (country.idd?.suffixes?[0] ?? "Error")
            case 7: cell.textLabel?.text = country.tld?[0]
            case 8: cell.textLabel?.text = country.car.side
            case 9: cell.textLabel?.text = country.timezones[0]
            case 10: cell.textLabel?.text = country.maps.googleMaps
            default: "a"
            }
            
        
        if indexPath.section == 10 {
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    
      
    }
    
    
    
}
