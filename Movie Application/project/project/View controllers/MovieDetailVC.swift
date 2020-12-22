//
//  MovieDetailVC.swift
//  project
//
//  Created by Vallivedu Sudhakar, Mohan on 11/20/20.
//  Copyright © 2020 UHCL. All rights reserved.
//

import UIKit

class MovieDetailVC: UIViewController {

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleasedDate: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblDirector: UILabel!
    @IBOutlet weak var lblActor: UILabel!
    @IBOutlet weak var lblPlot: UILabel!
    
    @IBOutlet weak var lblLanCoun: UILabel!
    @IBOutlet weak var lblAwards: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblRuntime: UILabel!
    var id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.textAlignment = .center
        lblReleasedDate.textAlignment = .center
        lblGenre.textAlignment = .center
        lblActor.textAlignment = .center
        lblDirector.textAlignment = .center
        lblPlot.textAlignment = .center
        lblAwards.textAlignment = .center
        lblRuntime.textAlignment = .center
        lblRating.textAlignment = .center
        lblLanCoun.textAlignment = .center
        getData(id: id)
    }
    
    
    func getData(id: String)
    {
        let stringUrl = "https://omdbapi.com/?apikey=a8593396&i=\(id)&r=json"
        //print(stringUrl)
        let session = URLSession.shared
        
        let url = URL(string: stringUrl)!
        
        let task = session.dataTask(with: url,completionHandler: {data,response,error in
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            DispatchQueue.main.async {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    //print(json)
                    
                    if let results = json as? [String: Any] {
                        if let url = results["Poster"] as? String{
                            if let data = try? Data(contentsOf: URL(string: url)!){
                                self.imgPoster.image = UIImage(data: data)
                            }
                        }
                        if let arr = results["Title"] as? String{
                            self.lblTitle.text = "\(arr)"
                        }
                        if let arr = results["Released"] as? String{
                            self.lblReleasedDate.text = "Release Date: \(arr)"
                        }
                        if let arr = results["Genre"] as? String{
                            self.lblGenre.text = "Genre: \(arr)"
                        }
                        if let arr = results["Director"] as? String{
                            self.lblDirector.text = "Directors: \(arr)"
                        }
                        if let arr = results["Actors"] as? String{
                            self.lblActor.text = "Actors: \(arr)"
                        }
                        if let arr = results["Plot"] as? String{
                            self.lblPlot.text = "Plot: \(arr)"
                        }
                        if let arr = results["imdbRating"] as? String{
                            self.lblRating.text = "imdbRating: \(arr)"
                        }
                        if let arr = results["Runtime"] as? String{
                            self.lblRuntime.text = "Runtime: \(arr)"
                        }
                        if let arr = results["Awards"] as? String{
                            self.lblAwards.text = "Awards: \(arr)"
                        }
                        if let arr = results["Language"] as? String{
                            self.lblLanCoun.text = "Country:  \(arr)"
                        }
                        if let arr = results["Country"] as? String{
                            self.lblLanCoun.text = self.lblLanCoun.text! + " , \(arr)"
                        }
                    }
                    
                }
                catch{
                    print("Error : \(error.localizedDescription)")
                }
            }
            
        })
        task.resume()
        
    }
    
    
}
