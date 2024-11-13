//
//  MovieDetailsViewController.swift
//  the-globoplay
//
//  Created by Letícia Faleia on 12/11/24.
//

import UIKit
import Foundation

class MovieDetailsViewController: UIViewController {
    public var moviesRequest = Service()
    public var movieId: Int!
    public var movie: MovieDetail!
    
    var scrollView: UIScrollView!
    private var moviePosterImage: UIImageView!
    private var movieNameLabel: UILabel!
    private var movieGenreLabel: UILabel!
    public var movieOverviewLabel: UILabel!
    public var segmentedControlUnderline: UIView!
    public var segmentedControl: UISegmentedControl!
    
    public var detailStackView: UIStackView!
    public var buttonStackView: UIStackView!
    
    public var recommendedVC: MovieRecoViewController!
    public var movieInfoVC: MovieInfoViewController!
    
    init(movieId: Int){
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .homeBackground
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
        
        moviesRequest.getMovieDetails(movieId: movieId) { movie in
            self.movie = movie
            self.setupScrollView()
            self.setupMoviePosterImage()
            self.setupMovieName()
            self.setupMovieGenre()
            self.setupMovieOverview()
            self.setupButtonStackView()
            self.setupSegmentedControl()
            self.setupContainerView()
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.isTranslucent = false
    }
    
    private func setupScrollView(){
        scrollView = UIScrollView(frame: .zero)
        view.addSubview(scrollView)
    
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    private func setupMoviePosterImage(){
        moviePosterImage = UIImageView()
        scrollView.addSubview(moviePosterImage)
        
        moviePosterImage.translatesAutoresizingMaskIntoConstraints = false
        
        moviePosterImage.loadImage(urlString: APIConstants.imageUrl + self.movie.poster_path) {}
        moviePosterImage.contentMode = .scaleAspectFit
        
        moviePosterImage.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        moviePosterImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        moviePosterImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
    }
    
    private func setupMovieName(){
        movieNameLabel = UILabel()
        scrollView.addSubview(movieNameLabel)
        
        movieNameLabel.text = movie.title
        movieNameLabel.font = .boldSystemFont(ofSize: 28)
        movieNameLabel.textColor = .white
        movieNameLabel.textAlignment = .center
        movieNameLabel.lineBreakMode = .byWordWrapping
        movieNameLabel.numberOfLines = 0
        
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        movieNameLabel.topAnchor.constraint(equalTo: moviePosterImage.bottomAnchor, constant: 20).isActive = true
        movieNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        movieNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
    }
    
    private func setupMovieGenre(){
        movieGenreLabel = UILabel()
        scrollView.addSubview(movieGenreLabel)
        
        movieGenreLabel.text = movie.genres[0].name
        movieGenreLabel.font = .systemFont(ofSize: 18)
        movieGenreLabel.textColor = .lightGray
        
        movieGenreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        movieGenreLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 20).isActive = true
        movieGenreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupMovieOverview() {
        movieOverviewLabel = UILabel()
        scrollView.addSubview(movieOverviewLabel)
        
        movieOverviewLabel.text = movie.overview
        movieOverviewLabel.font = .systemFont(ofSize: 20)
        movieOverviewLabel.textColor = .white
        movieOverviewLabel.textAlignment = .left
        movieOverviewLabel.numberOfLines = 0
        movieOverviewLabel.lineBreakMode = .byWordWrapping
        
        movieOverviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        movieOverviewLabel.topAnchor.constraint(equalTo: movieGenreLabel.bottomAnchor, constant: 30).isActive = true
        movieOverviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        movieOverviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
}
