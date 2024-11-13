//
//  MovieCollectionViewCell.swift
//  the-globoplay
//
//  Created by Letícia Faleia on 12/11/24.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    private var moviePoster: UIImageView!
    static let cellId = "MovieCollectionViewCell"
    
    var imageUrl: String? {
        didSet {
            setupMoviePosterImage()
        }
    }
    
    override init(frame: CGRect) {
          super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        moviePoster.isHidden = false
    }
    
    private func setupMoviePosterImage() {
        
        moviePoster = UIImageView()
        contentView.addSubview(moviePoster)
        
        moviePoster.loadImage(urlString: APIConstants.imageUrl + (imageUrl ?? "erro")) {}
        moviePoster.contentMode = .scaleAspectFit
        moviePoster.clipsToBounds = true
        moviePoster.translatesAutoresizingMaskIntoConstraints = false
        
        moviePoster.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        moviePoster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        moviePoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        moviePoster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
}
