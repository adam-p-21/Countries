//
//  ViewController.swift
//  Countries
//
//  Created by Adam Paluszewski on 27/06/2022.
//

import UIKit

class ViewController: UITableViewController, UITabBarControllerDelegate {

    var countries = [Country]()
    var searchedCountry = [Country]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //niezalezne ustawienie title navigationBara i tabBara
        self.navigationItem.title = "List of all countries"
        self.tabBarItem.title = "Countries"

        navigationController?.navigationBar.prefersLargeTitles = true

        updateBarButtons(searchVisible: true, clearVisible: false)

        
        
        
        
        let backgroundImage = UIImage(named: "globe1.jpg")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView







        
        tableView.separatorStyle = .none
        

        getData(apiSuffix: "all")

        
    }

    
    func updateBarButtons(searchVisible: Bool, clearVisible: Bool) {
        let searchBarButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
        let clearBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(clearTapped))
        
        navigationItem.rightBarButtonItem = searchBarButton
        navigationItem.leftBarButtonItem = clearBarButton
        
        if searchVisible {
            searchBarButton.tintColor = .tintColor
            searchBarButton.isEnabled = true
        } else {
            searchBarButton.tintColor = .clear
            searchBarButton.isEnabled = false
        }
        
        if clearVisible {
            clearBarButton.tintColor = .tintColor
            clearBarButton.isEnabled = true
        } else {
            clearBarButton.tintColor = .clear
            clearBarButton.isEnabled = false
        }
        
    }
    
    
    
    
    

    @objc func searchTapped() {
        let ac = UIAlertController(title: "Search for country", message: "Type name of country", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Search", style: .default, handler: { UIAlertAction in
            if let searchedText = ac.textFields?[0].text?.lowercased() {
                
                for i in 0...(self.countries.count-1) {
                    if self.countries[i].name.official.lowercased().contains(searchedText)  || self.countries[i].name.common.lowercased().contains(searchedText) {
                        self.searchedCountry.append(self.countries[i])
                    }
                }
            }
            self.countries = self.searchedCountry
            self.tableView.reloadData()
            self.title = "Search results"
            self.updateBarButtons(searchVisible: false, clearVisible: true)
        }))
        
        present(ac, animated: true)
    }
    
    
    
    @objc func clearTapped() {
        searchedCountry.removeAll()
        getData(apiSuffix: "all")
        updateBarButtons(searchVisible: true, clearVisible: false)
        title = "List of all countries"
    }
    
    
    
    func getData(apiSuffix: String) {
        
//        let urlString = "https://restcountries.com/v3.1/\(apiSuffix)"
        
//        if let url = URL(string: urlString) {
//            if let data = try? Data(contentsOf: url) {
//                parse(json: data)
//            } else {
//                print("blad1")
//            }
//        } else {
//            print("blad2")
//        }
//
        let url = URL(string: "https://restcountries.com/v3.1/\(apiSuffix)")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            self.parse(json: data)
        }

        task.resume()
        
    }
    
    
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonCountries = try? decoder.decode([Country].self, from: json) {
            countries = jsonCountries
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

            print(countries)
        } else {
            print("blad3")
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountryTableViewCell
        
        cell.backgroundColor = .clear
        cell.countryNameLabel.text = countries[indexPath.row].name.official
      
        DispatchQueue.global(qos: .userInteractive).async {
            if let url = URL(string: self.countries[indexPath.row].flags.png) {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.countryFlagImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "countryDetails") as? CountryDetailsViewController {
                
                    vc.country = self.countries[indexPath.row]
                
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }

}

