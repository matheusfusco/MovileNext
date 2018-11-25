//
//  Movie.swift
//  MovileNext
//
//  Created by Matheus on 21/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import Foundation
import UIKit

struct MoviesResult: Codable {
    var resultCount: Int
    var results: [MovieFromAPI]
}

struct MovieFromAPI: Codable {
    var trackId: Int = 0
    var trackName: String = ""
    var longDescription: String = ""
    var primaryGenreName: String = ""
    var artworkUrl100: String = "" //poster
    var previewUrl: String = "" //trailer
    var trackTimeMillis: Int = 0
}
