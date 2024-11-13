//
//  MovieSetup+Extension.swift
//  the-globoplay
//
//  Created by Letícia Faleia on 13/11/24.
//

import Foundation
import UIKit

extension MovieDetailsViewController {
    public func setupButtonStackView() {
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
    
    @objc public func tapMyListButton(){
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

    
    public func setupSegmentedControl() {
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
    
    public func changeSegmentedControlUnderline () {
        
        let segmentIndex = CGFloat(segmentedControl.selectedSegmentIndex)
        let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        let leftDistance = segmentIndex * segmentWidth
        UIView.animate(withDuration: 0.3) {
            self.segmentedControlUnderline.transform = CGAffineTransform(translationX: leftDistance, y: 0)
        }
    }
    
    public func setupContainerView() {
        
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
