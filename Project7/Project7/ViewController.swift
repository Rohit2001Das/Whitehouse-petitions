//
//  ViewController.swift
//  Project7
//
//  Created by ROHIT DAS on 22/08/22.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString: String
         urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    
                    parse(json: data)
                }
                    else{
                        showError()
                    
                }
        } else {
                showError()
            }
            
    }
        func showError() {
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed, please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return petitions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            var cellConfigurator = cell.defaultContentConfiguration()
            
            let petition = petitions[indexPath.row]
            cellConfigurator.text = petition.title
            cellConfigurator.textProperties.numberOfLines = 1
            
            cellConfigurator.secondaryText = petition.body
            cellConfigurator.secondaryTextProperties.numberOfLines = 1
            
            cell.contentConfiguration = cellConfigurator
            
            return cell
        }
}

