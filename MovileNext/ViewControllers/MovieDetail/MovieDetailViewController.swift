//
//  MovieDetailViewController.swift
//  MovileNext
//
//  Created by Matheus on 22/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class MovieDetailViewController: UIViewController {

    //MARK: - Variables
    var movie: Movie!
    var moviePlayer: AVPlayer!
    var moviePlayerController: AVPlayerViewController!
    
    // MARK: - IBOutlets
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbGenre: UILabel!
    @IBOutlet weak var lbDuration: UILabel!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var tvSinopsis: UITextView!
    @IBOutlet weak var lcButtonX: NSLayoutConstraint!
    @IBOutlet weak var viTrailer: UIView!
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbTitle.text = movie.title
        lbDuration.text = movie.duration
        lbScore.text = "⭐️ \(movie.rating)/5"
        tvSinopsis.text = movie.summary
        if let categories = movie.categories {
            lbGenre.text = categories.map({($0 as! Category).name!}).joined(separator: " | ")
        }
        if let image = movie.poster as? UIImage {
            ivPoster.image = image
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        prepareVideo()
        if UserDefaults.standard.bool(forKey: "autoplay") {
            changeMovieStatus(play: true)
        }
        else {
            let oldHeight = ivPoster.frame.size.height
            ivPoster.frame.size.height = 0
            UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseInOut, animations: {
                self.ivPoster.frame.size.height = oldHeight
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddEditMovieViewController {
            vc.movie = movie
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Custom Methods
    func prepareVideo() {
        if let _ = movie.trailerURL {
            moviePlayer = AVPlayer(url: URL(string: "\((movie.trailerURL)!)")!)

            let moviePlayerController = AVPlayerViewController()
            moviePlayerController.delegate = self
            moviePlayerController.player = moviePlayer
            moviePlayerController.showsPlaybackControls = true
            moviePlayerController.view.frame = viTrailer.bounds
            viTrailer.addSubview(moviePlayerController.view)
        }
    }
    
    func changeMovieStatus(play: Bool) {
        viTrailer.isHidden = false
        if play {
            moviePlayer.play()
        }
        else {
            moviePlayer.pause()
        }
    }

    // MARK: - IBActions
    @IBAction func playVideo(_ sender: UIButton) {
        sender.isHidden = true
        changeMovieStatus(play: true)
    }
}

extension MovieDetailViewController: AVPlayerViewControllerDelegate {}
