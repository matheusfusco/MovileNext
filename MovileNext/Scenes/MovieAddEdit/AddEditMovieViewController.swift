//
//  AddEditMovieViewController.swift
//  MovileNext
//
//  Created by Matheus on 21/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData

class AddEditMovieViewController: UIViewController {

    //MARK: - Variables
    var movie: Movie!
    var smallImage: UIImage!
    var movieID: Int?
    var posterURL: String?
    var trailerURL: String?
    private let disposeBag = DisposeBag()
    private var movieAPI = Variable<MovieFromAPI>(MovieFromAPI())
    
    //MARK: - IBOutlets
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfRating: UITextField!
    @IBOutlet weak var tfDuration: UITextField!
    @IBOutlet weak var btAddPoster: UIButton!
    @IBOutlet weak var tvSinopse: UITextView!
    @IBOutlet weak var btAddEdit: UIButton!
    @IBOutlet weak var btSearchMovie: UIButton!
    @IBOutlet weak var lbCategories: UILabel!
    @IBOutlet weak var ivPoster: UIImageView!
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if movie != nil {
            if let categories = movie.categories {
                lbCategories.text = categories.map({($0 as! Category).name!}).joined(separator: " | ")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if movie == nil {
            movie = Movie(context: context)
        }
        if let vc = segue.destination as? CategoriesViewController {
            vc.movie = movie
        }
    }
    
    // MARK: - IBActions
    @IBAction func addPoster(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar poster", message: "De onde você quer escolher o poster?", preferredStyle: .actionSheet)
    
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default, handler: { (action: UIAlertAction) in
                self.selectPicture(sourceType: .camera)
            })
            alert.addAction(cameraAction)
        }
    
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default) { (action: UIAlertAction) in
            self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let photosAction = UIAlertAction(title: "Álbum de fotos", style: .default) { (action: UIAlertAction) in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(photosAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func close(_ sender: UIButton?) {
        if movie != nil && movie.title == nil {
            context.delete(movie)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchMovie() {
        guard let storyboard = storyboard else { return }
        let searchMovieViewController = storyboard.instantiateViewController(withIdentifier: "SearchMovieViewController") as! SearchMovieViewController
        
        let selectedMovie = searchMovieViewController.selectedMovie.share()
        
        selectedMovie.subscribe(onNext: { [weak self] movie in
            if let `self` = self  {
                self.movieAPI.value = movie
                self.updateUI(with: movie)
            }
        }).disposed(by: disposeBag)
        
        self.present(searchMovieViewController, animated: true, completion: nil)
    }
    
    @IBAction func addUpdateMovie(_ sender: UIButton) {
        guard tfTitle.text != nil, tfRating.text != nil, tfDuration.text != nil, tvSinopse.text != nil, lbCategories.text != nil, lbCategories.text != "Categorias", tfTitle.text != "", tfRating.text != "", tfDuration.text != "", tvSinopse.text != "", lbCategories.text != "" else {
            self.showAlert(message: "Favor preencher todos os dados!")
            return
        }
        if movie == nil {
            movie = Movie(context: context)
        }
        movie.title = tfTitle.text!
        movie.rating = Double(tfRating.text!)!
        movie.summary = tvSinopse.text
        movie.duration = tfDuration.text
        movie.trackId = Int32(movieID ?? Int(Date().timeIntervalSince1970))
        movie.imgSearchPosterURL = posterURL ?? "" //caso tenha adicionado o filme na mão
        movie.trailerURL = trailerURL ?? "" //caso tenha adicionado o filme na mão
        if smallImage != nil {
            movie.poster = smallImage
        }
        else if ivPoster.image != nil {
            movie.poster = ivPoster.image
        }
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        close(nil)
    }
    
    // MARK: - Methods
    private func setupUI() {
        if movie != nil {
            tfTitle.text = movie.title
            tfRating.text = "\(movie.rating)"
            tfDuration.text = movie.duration
            tvSinopse.text = movie.summary
            btAddEdit.setTitle("Atualizar", for: .normal)
            if let image = movie.poster as? UIImage {
                ivPoster.image = image
            }
            else if let posterURL = movie.imgSearchPosterURL {
                ivPoster.imageFromURL(posterURL)
            } else {
                ivPoster.image = UIImage(named: "movies")
            }
        }
    }
    
    private func selectPicture(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func updateUI(with movie: MovieFromAPI) {
        tfTitle.text = movie.trackName
        lbCategories.text = movie.primaryGenreName
        tvSinopse.text = movie.longDescription
        self.movieID = movie.trackId
        self.posterURL = movie.artworkUrl100
        self.trailerURL = movie.previewUrl
        self.ivPoster.imageFromURL(movie.artworkUrl100)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension AddEditMovieViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let smallSize = CGSize(width: 100, height: 100)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        UIGraphicsBeginImageContext(smallSize)
        image.draw(in: CGRect(x: 0, y: 0, width: smallSize.width, height: smallSize.height))
        smallImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        ivPoster.image = smallImage
        
        dismiss(animated: true, completion: nil)
    }
}
