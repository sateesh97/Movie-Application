//
//  FavoritesVC.swift
//  project
//
//  Created by Vallivedu Sudhakar, Mohan on 11/20/20.
//  Copyright © 2020 UHCL. All rights reserved.
//

import UIKit

protocol ReloadDelegate: class {
    func DeleteButtonPressed()
}
class FavoritesVC: UITableViewController, ReloadDelegate {
    
    func DeleteButtonPressed() {
        favYear = FavoritesCRUD.readYear()
        favTitle = FavoritesCRUD.readData(attribute: "title")
         favID = FavoritesCRUD.readData(attribute: "id")
         favPosters = FavoritesCRUD.readData(attribute: "poster")
        tableView?.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

//        favTitle = FavoritesCRUD.readData(attribute: "title")
//        for i in 0..<favTitle.count
//        {
//            FavoritesCRUD.delete(title: favTitle[i])
//        }
    }
    
    var favTitle = [String]()
    var favYear = [Int]()
    var favID = [String]()
    var favPosters = [String]()
    
    override func viewDidAppear(_ animated: Bool) {
        self.title = "Favorites"
        favYear = FavoritesCRUD.readYear()
        favTitle = FavoritesCRUD.readData(attribute: "title")
         favID = FavoritesCRUD.readData(attribute: "id")
         favPosters = FavoritesCRUD.readData(attribute: "poster")
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favTitle.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! favCell

       // cell.textLabel?.text = "\(favTitle[indexPath.row])  Year: \(favYear[indexPath.row])"
        cell.delegate = self
        cell.lblFavTitle.text = "\(favTitle[indexPath.row])"
        cell.lblfavYear.text = "\(favYear[indexPath.row])"
        let url = favPosters[indexPath.row]
        if let data = try? Data(contentsOf: URL(string: url)!){
            cell.lblfavPoster.image = UIImage(data: data)
        }
        cell.textLabel?.font = UIFont.init(name: "Helvetica", size: 18)

        cell.textLabel?.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "fav2Detail" {
                if let DetailVC = segue.destination as? MovieDetailVC {
                    let i = tableView.indexPathForSelectedRow?.row
                    DetailVC.id = favID[i!]
                    
                }
            }
        }
    
   

}
