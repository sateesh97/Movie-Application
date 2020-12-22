//
//  HomeVC.swift
//  project
//
//  Created by Vallivedu Sudhakar, Mohan on 10/26/20.
//  Copyright © 2020 UHCL. All rights reserved.
//

import UIKit
protocol AddedDelegate: class {
    func popUpAlert(title:String,msg:String)
}

class HomeVC: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource, AddedDelegate {
    
    func popUpAlert(title:String, msg:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
             })
             alert.addAction(ok)
             DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
        })
    }
    
    var idval = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        search.placeholder = "Movie name"
    
        table.register(MovieCell.nib(), forCellReuseIdentifier: MovieCell.identifier)
        self.search.delegate = self
        table.delegate = self
        table.dataSource = self
        
    }
    
    var moviesList = [Movie]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        cell.configure(with: moviesList[indexPath.row])
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
        
        idval = indexPath.row
        performSegue(withIdentifier: "movie2Detail", sender: self)
        
       }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movie2Detail" {
            if let DetailVC = segue.destination as? MovieDetailVC {
                DetailVC.id = moviesList[idval].imdbID
                
            }
        }
    }

    @IBOutlet weak var search: UITextField!
    @IBOutlet weak var table: UITableView!
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovie()
        return true
    }
    
    func searchMovie()
    {
        search.resignFirstResponder()
        guard let movie = search.text, !movie.isEmpty else {
            return
        }
        
        let query = movie.replacingOccurrences(of: " ", with: "%20")
        moviesList.removeAll()
        //print(query)
        URLSession.shared.dataTask(with: URL(string: "https://www.omdbapi.com/?apikey=a8593396&s=\(query)&type=movie")!, completionHandler: {data, response,error in
            //Refreshing table
            DispatchQueue.main.async {

            guard let data = data, error == nil else {
                return
            }
                
            var flag = false
            //Convert data to Movie array
            var result: MovieResult?
            do{
                result = try JSONDecoder().decode(MovieResult.self, from: data )
            }
            catch{
                print("Error, Null data")
                flag = true
            }
            if flag{
                self.moviesList.removeAll()
                self.table.reloadData()
                self.popUpAlert(title: "No Data found", msg: "Empty")
                flag = false
            }
            guard let finalRes = result else{
                return
            }
            //print("\(String(describing: finalRes.Search.first?.Title))")
            
            //Updating movies array
            let movies = finalRes.Search
            self.moviesList.append(contentsOf: movies)
            
            
                self.table.reloadData()
            }
            
            
        }).resume()  //resume() is to start the request
        
    }
    
    
}

struct MovieResult: Codable{
    let Search: [Movie]
}
struct Movie: Codable
{
    let Title: String
    let Year: String
    let imdbID: String
    let _Type: String
    let Poster: String
    private enum CodingKeys: String, CodingKey{
        case Title, Year, imdbID, _Type = "Type", Poster
    }
}
