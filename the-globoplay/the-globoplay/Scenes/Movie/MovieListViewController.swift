//
//  MyMovieListaViewController.swift
//  the-globoplay
//
//  Created by Letícia Faleia on 13/11/24.
//

import Foundation
import UIKit

class MovieListViewController: UIViewController {
    private var collection: UICollectionView!
    private var myListRequest = Service()
    private var myList: [ListMovie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .homeBackground
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    private func setupNavBar () {
        
        
        navigationItem.title = "Minha lista"
        
        let titleBarAttibutes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                 NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]
        
        navigationController?.navigationBar.titleTextAttributes = titleBarAttibutes
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        
    }

    
    private func setupCollection () {
        let Layout = UICollectionViewFlowLayout()
        Layout.itemSize = CGSize(width: view.frame.size.width * 0.275, height: view.frame.size.width * 0.47)
        
        collection = UICollectionView(frame: view.frame, collectionViewLayout: Layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .homeBackground
        
        collection.delegate = self
        collection.dataSource = self
        collection.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.cellId)
        
        view.addSubview(collection)
        
        collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        collection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive =  true
    }
}


extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellId, for: indexPath) as! MovieCollectionViewCell
        
        cell.imageUrl = myList[indexPath.row].poster_path
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieId = myList[indexPath.row].id
        
        self.present(MovieDetailsViewController(movieId: movieId), animated: true, completion: nil)
        self.modalPresentationStyle = .fullScreen
        
        
    }
    
    
}
