    //
    //  MovieCell.swift
    //  project
    //
    //  Created by Vallivedu Sudhakar, Mohan on 10/26/20.
    //  Copyright © 2020 UHCL. All rights reserved.
    //
    
    import UIKit
    
    class MovieCell: UITableViewCell {
        
        @IBOutlet var movieTitle: UILabel!
        @IBOutlet var movieYear: UILabel!
        @IBOutlet var moviePoster: UIImageView!
        
        var delegate:AddedDelegate?
        
        var favTitle = [String]()
        var id = ""
        var url = ""
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
        
        static let identifier = "MovieCell"
        static func nib() -> UINib{
            return UINib(nibName: "MovieCell", bundle: nil)
        }
        
        func configure(with model: Movie)
        {
            favTitle = FavoritesCRUD.readData(attribute: "title")
            self.movieTitle.text = model.Title
            self.movieYear.text = model.Year
            url = model.Poster
            id = model.imdbID
            if let data = try? Data(contentsOf: URL(string: url)!){
                self.moviePoster.image = UIImage(data: data)
            }
            
        }
        var flag = false;
        @IBAction func btnSave(_ sender: Any) {
            favTitle = FavoritesCRUD.readData(attribute: "title")
            for ele in favTitle
            {
                if ele == movieTitle.text!
                {
                    flag = true
                    break
                }
            }
            
            if flag == false
            {
                //create new record
                FavoritesCRUD.create(title: movieTitle.text!, year: Int(movieYear.text!)!, id: id, poster: url)
                delegate?.popUpAlert(title: "Added to Favorites", msg: "")
            }
            else
            {
                delegate?.popUpAlert(title: "Previously added", msg: "to Favorites")
            }
            
        }
        
    }
    
