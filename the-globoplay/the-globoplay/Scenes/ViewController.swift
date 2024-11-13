//
//  ViewController.swift
//  the-globoplay
//
//  Created by Letícia Faleia on 06/11/24.
//

import UIKit


class ViewController: UIViewController {
    
    
    private var request = Service()
    var genres = [] as [Genre]
    private var table: UITableView!
    private var appName = "globoplay"
    private var movieCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        request.getMoviesGenresRequest{ Genres in
            self.genres = Genres.genres
            self.setupTable()
        }
    }
    
    private func setupNavBar () {
        
        navigationItem.title = appName
        
        let titleBarAttibutes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                 NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]
        
        navigationController?.navigationBar.titleTextAttributes = titleBarAttibutes
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func setupTable() {
        table = UITableView()
        view.addSubview(table)
        
        table.delegate = self
        table.dataSource = self
        table.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.reuseId)
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.backgroundColor = .homeBackground
        table.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.table.bounds.size.width, height: 40))
        table.contentInset = UIEdgeInsets(top: -40, left: 0, bottom: 0, right: 0)
        
        table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.reuseId, for: indexPath) as! MoviesTableViewCell
        
        cell.genreId = self.genres[indexPath.section].id
        cell.genreName = self.genres[indexPath.section].name
        cell.parent = self
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        label.frame = CGRect(x: 15, y: 5, width: self.table.bounds.size.width, height: 20)
        label.text = self.genres[section].name
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
