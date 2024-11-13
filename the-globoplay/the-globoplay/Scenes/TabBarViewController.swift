//
//  TabBarViewController.swift
//  the-globoplay
//
//  Created by Letícia Faleia on 12/11/24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        let home = UINavigationController(rootViewController: ViewController())
        let favMovies = UINavigationController(rootViewController: MovieListViewController())
//        let searchMovie = UINavigationController(rootViewController: SearchMovieViewController(movieName: "))
        
        home.title = "Início"
        favMovies.title = "Minha lista"
//        searchMovie.title = movieName: "Buscar"
        
        let ItemAppearance = UITabBarItem.appearance()
        let titleBarAttibutes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)]
        ItemAppearance.setTitleTextAttributes(titleBarAttibutes, for: .normal)
     
        self.viewControllers = ([home, favMovies])
        self.tabBar.tintColor = .white
        self.tabBar.barTintColor = .black
        
        guard let items = self.tabBar.items else { return }
        
        items.first?.image = UIImage(systemName: "house.fill")
        items.last?.image = UIImage(systemName: "star.fill")
//        items.first?.image = UIImage(systemName: "search.fill")
        
    }

}
