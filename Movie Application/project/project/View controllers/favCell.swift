//
//  favCell.swift
//  project
//
//  Created by Vallivedu Sudhakar, Mohan on 12/2/20.
//  Copyright © 2020 UHCL. All rights reserved.
//

import UIKit

class favCell: UITableViewCell {
   
    var delegate: ReloadDelegate?
    
    @IBOutlet weak var lblfavYear: UILabel!
    @IBOutlet weak var lblFavTitle: UILabel!
    
    @IBOutlet weak var lblfavPoster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func btnDelFav(_ sender: Any) {
        FavoritesCRUD.delete(title: lblFavTitle.text!)
        delegate?.DeleteButtonPressed()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
