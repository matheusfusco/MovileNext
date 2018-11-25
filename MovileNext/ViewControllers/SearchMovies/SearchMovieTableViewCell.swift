//
//  SearchMovieTableViewCell.swift
//  MovileNext
//
//  Created by Matheus on 21/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class SearchMovieTableViewCell: UITableViewCell {

    var movie: MovieFromAPI!
    
    @IBOutlet weak var ivMoviePoster: UIImageView!
    @IBOutlet weak var lbMovieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        self.ivMoviePoster.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(movie: MovieFromAPI) {
        self.movie = movie
        self.lbMovieTitle.text = movie.trackName
        self.ivMoviePoster.imageFromURL(movie.artworkUrl100)
    }

}
