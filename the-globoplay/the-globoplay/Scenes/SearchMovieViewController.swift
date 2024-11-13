//
//  SearchMovieViewController.swift
//  the-globoplay
//
//  Created by Letícia Faleia on 13/11/24.
//

import Foundation
import UIKit

class SearchMovieViewController: UIViewController {
    
    var collection: UICollectionView!
    private var service = Service()
    private var movieName: String!
    
    init(movieName: String){
        self.movieName = movieName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        service.getMoviesByName(name: movieName) { movieName in

        }
        
        
    }
    
}
