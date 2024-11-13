//
//  MovieTableViewCell.swift
//  the-globoplay
//
//  Created by Letícia Faleia on 12/11/24.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    private var moviesRequest = Service()
    private var movies = [] as [Movie]
    private var moviesColletion: UICollectionView!
    static let reuseId = "MoviesTableViewCell"
    var parent: UIViewController?
    var genreName: String?
   
    var genreId: Int? {
        didSet {
            moviesRequest.getMoviesByGenresRequest(with_genre: genreId ?? 0) { movies in
                self.movies = movies.results
                self.moviesColletion.reloadData()
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .homeBackground
        setupMovieCollection()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
   
    private func setupMovieCollection(){
        
        let Layout = UICollectionViewFlowLayout()
        Layout.itemSize = CGSize(width: 140, height: 200)
        Layout.scrollDirection = .horizontal
        
        moviesColletion = UICollectionView(frame: self.contentView.frame, collectionViewLayout: Layout)
        moviesColletion.backgroundColor = .homeBackground
        moviesColletion.translatesAutoresizingMaskIntoConstraints = false
        
        moviesColletion.delegate = self
        moviesColletion.dataSource = self
        moviesColletion.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.cellId)
        
        contentView.addSubview(moviesColletion)
        
        moviesColletion.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        moviesColletion.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        moviesColletion.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        moviesColletion.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

}

extension MoviesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellId, for: indexPath) as! MovieCollectionViewCell
        
        
        cell.imageUrl = movies[indexPath.row].poster_path
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movieId = movies[indexPath.row].id

        parent?.navigationController?.pushViewController(MovieDetailsViewController(movieId: movieId), animated: true)
    }
    
}
