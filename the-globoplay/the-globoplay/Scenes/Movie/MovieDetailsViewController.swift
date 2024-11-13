//
//  MovieDetailsViewController.swift
//  the-globoplay
//
//  Created by Letícia Faleia on 12/11/24.
//

import UIKit
import Foundation

class MovieDetailsViewController: UIViewController {
    private var moviesRequest = Service()
    private var movieId: Int!
    private var movie: MovieDetail!
    
    var scrollView: UIScrollView!
    private var moviePosterImage: UIImageView!
    private var movieNameLabel: UILabel!
    private var movieGenreLabel: UILabel!
    private var movieOverviewLabel: UILabel!
    private var segmentedControlUnderline: UIView!
    private var segmentedControl: UISegmentedControl!
    
    private var detailStackView: UIStackView!
    var buttonStackView: UIStackView!
    
    private var recommendedVC: MovieRecoViewController!
    private var movieInfoVC: MovieInfoViewController!
    
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
    
    private func setupButtonStackView() {
        buttonStackView = UIStackView()
        scrollView.addSubview(buttonStackView)
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 10
        
        buttonStackView.topAnchor.constraint(equalTo: movieOverviewLabel.bottomAnchor, constant: 20).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        let watch = UIButton()
        buttonStackView.addArrangedSubview(watch)
        
        watch.backgroundColor = .white
        watch.tintColor = .black
        watch.setTitleColor(.black, for: .normal)
        watch.setTitle("Assista", for: .normal)
        watch.layer.cornerRadius = 5
        watch.setImage(UIImage(systemName: "play.fill"), for: .normal)
        watch.heightAnchor.constraint(equalToConstant: 50).isActive = true

        
        let myList = UIButton()
        buttonStackView.addArrangedSubview(myList)
        
        myList.backgroundColor = .black
        myList.setTitle("Minha lista", for: .normal)
        myList.tintColor = .white
        myList.setImage(UIImage(systemName: "star.fill"), for: .normal)
        myList.layer.borderColor = CGColor.init(red: 0.50, green: 0.50, blue: 0.50, alpha: 1)
        myList.layer.borderWidth = 1.0
        myList.layer.cornerRadius = 5
        myList.addTarget(self, action: #selector(tapMyListButton), for: .touchUpInside)
        myList.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func tapMyListButton(){
        let spinner = UIActivityIndicatorView()
        
        scrollView.addSubview(spinner)
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.color = .white
        spinner.transform = CGAffineTransform.init(scaleX: 4, y: 4)
        
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        moviesRequest.addMovieToList(movieId: self.movieId) { statusCode in
            alertFunction(code: statusCode)
        }
        
        func alertFunction(code: Int){
            
            let sucessAlert = UIAlertController(title: "Filme adicionado com sucesso!", message: "Mais um filme na sua lista :)", preferredStyle: .alert)
            let failureAlert = UIAlertController(title: "Não foi possível adicionar a sua lista", message: "Tente novamente mais tarde.", preferredStyle: .alert)
            
            sucessAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            failureAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            spinner.stopAnimating()
            
            if code == 200 {
                self.present(sucessAlert, animated: true, completion: nil)
                isOutdated = true
                
            } else {
                
                self.present(failureAlert, animated: true, completion: nil)
            }
        }
    }

    
    private func setupSegmentedControl() {
        segmentedControl = UISegmentedControl(items: ["Assista também", "Detalhes"])
        view.addSubview(segmentedControl)
        
        segmentedControl.addTarget(self, action: #selector(handleSegmentedControl), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .black
        segmentedControl.tintColor = .clear
        segmentedControl.selectedSegmentTintColor = .clear
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.setContentPositionAdjustment(UIOffset(horizontal: -10, vertical: 20), forSegmentType: .any, barMetrics: .default)
        segmentedControl.layer.cornerRadius = 0
        segmentedControl.layer.borderWidth = 2.0
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)], for: .normal)

        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)], for: .selected)
        
        segmentedControlUnderline = UIView()
        view.addSubview(segmentedControlUnderline)
        segmentedControlUnderline.translatesAutoresizingMaskIntoConstraints = false
        segmentedControlUnderline.backgroundColor = .white
        
        segmentedControl.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 20).isActive = true
        segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 100).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        let numberOfSegments = CGFloat(segmentedControl.numberOfSegments)
        segmentedControlUnderline.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
        segmentedControlUnderline.heightAnchor.constraint(equalToConstant: 4.0).isActive =  true
        segmentedControlUnderline.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor).isActive = true
        segmentedControlUnderline.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / numberOfSegments).isActive = true
        
        print(segmentedControl.widthForSegment(at: 0))
    }
    
    
    @objc func handleSegmentedControl () {
        changeSegmentedControlUnderline()
        
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                recommendedVC.view.isHidden = false
                movieInfoVC.view.isHidden = true
            
            case 1:
                recommendedVC.view.isHidden = true
                movieInfoVC.view.isHidden = false
        
            default: break
                
        }
    }
    
    private func changeSegmentedControlUnderline () {
        
        let segmentIndex = CGFloat(segmentedControl.selectedSegmentIndex)
        let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        let leftDistance = segmentIndex * segmentWidth
        UIView.animate(withDuration: 0.3) {
            self.segmentedControlUnderline.transform = CGAffineTransform(translationX: leftDistance, y: 0)
        }
    }
    
    private func setupContainerView() {
        
        recommendedVC = MovieRecoViewController(movieId: self.movieId)
        movieInfoVC = MovieInfoViewController(movie: self.movie)
        
        addChild(recommendedVC)
        addChild(movieInfoVC)
        
        scrollView.addSubview(recommendedVC.view)
        scrollView.addSubview(movieInfoVC.view)
        
        recommendedVC.didMove(toParent: self)
        movieInfoVC.didMove(toParent: self)
        
        movieInfoVC.view.translatesAutoresizingMaskIntoConstraints = false
        recommendedVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        recommendedVC.view.heightAnchor.constraint(equalToConstant: 400).isActive = true
       
        recommendedVC.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20).isActive = true
        recommendedVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        recommendedVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        recommendedVC.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20).isActive = true
        
       
        movieInfoVC.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20).isActive = true
        movieInfoVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        movieInfoVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        movieInfoVC.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20).isActive = true
        
        movieInfoVC.view.isHidden = true
    }
}
