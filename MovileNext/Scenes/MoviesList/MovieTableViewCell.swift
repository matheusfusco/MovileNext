//
//  MovieTableViewCell.swift
//  MovileNext
//
//  Created by Matheus on 22/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSummary: UILabel!
    @IBOutlet weak var lbRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        ivPoster.image = nil
    }
    
    func configure(_ movie: Movie) {
        lbRating.text = "\(movie.rating)"
        lbTitle.text = movie.title
        lbSummary.text = movie.summary
        if let image = movie.poster as? UIImage {
            ivPoster.image = image
        } else {
            ivPoster.image = UIImage(named: "movies")
        }
    }

}
