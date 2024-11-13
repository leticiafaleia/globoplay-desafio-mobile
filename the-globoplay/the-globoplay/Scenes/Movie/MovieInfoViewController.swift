//
//  MovieInfoViewController.swift
//  the-globoplay
//
//  Created by Letícia Faleia on 12/11/24.
//
import UIKit

class MovieInfoViewController: UIViewController {
    
    private var dataSheet: UILabel!
    private var infoStackView: UIStackView!
    private var movieDetail: MovieDetail!
    
    init(movie: MovieDetail){
        self.movieDetail = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .homeBackground
        setupDataSheet()
        setupInfoStackView()
    }
    
    private func setupDataSheet(){
        dataSheet = UILabel()
        view.addSubview(dataSheet)
        
        dataSheet.text = "Ficha técnica"
        dataSheet.textColor = .white
        dataSheet.font = .boldSystemFont(ofSize: 20)
        dataSheet.translatesAutoresizingMaskIntoConstraints = false
        dataSheet.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        dataSheet.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
    private func setupInfoStackView() {
        infoStackView = UIStackView()
        view.addSubview(infoStackView)
        
        infoStackView.axis = .vertical
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.alignment = .leading
        infoStackView.distribution = .fillProportionally
        infoStackView.spacing = 10
        
        infoStackView.topAnchor.constraint(equalTo: dataSheet.bottomAnchor, constant: 20).isActive = true
        infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
        
        let originalTitle = UILabel()
        infoStackView.addArrangedSubview(originalTitle)
        originalTitle.customLabel(label: "Título Original", value: self.movieDetail.original_title)
        
        let genres = UILabel()
        infoStackView.addArrangedSubview(genres)
        genres.customLabel(label: "Generos", value: genres.genreFormatter(array: self.movieDetail.genres))
        
        let runtime = UILabel()
        infoStackView.addArrangedSubview(runtime)
        runtime.customLabel(label: "Duração", value: runtime.timeFormatter(time: self.movieDetail.runtime))
        
        let releaseDate = UILabel()
        infoStackView.addArrangedSubview(releaseDate)
        releaseDate.customLabel(label: "Lançamento", value: self.movieDetail.release_date)
        
        let popularity = UILabel()
        infoStackView.addArrangedSubview(popularity)
        popularity.customLabel(label: "Popularidade", value: "\(self.movieDetail.popularity)")
        
        let country = UILabel()
        infoStackView.addArrangedSubview(country)
        country.customLabel(label: "Pais", value: self.movieDetail.production_countries.first?.name ?? " ")
    }
}

private extension UILabel{
    
    func customLabel(label: String, value: String) {
        
        self.textColor = UIColor(red: 133/255.0, green: 133/255.0, blue: 133/255.0, alpha: 1.0)
        self.font = .systemFont(ofSize: 16)
        
        let string = "\(label): \(value)"
        let attributedText = NSMutableAttributedString(string: string)
        attributedText.addAttribute(.font,
                                    value: UIFont.boldSystemFont(ofSize: 17),
                                    range: NSRange(location: 0, length: label.count))
        
        self.attributedText = attributedText
        
    }
    
    func timeFormatter(time: Int) -> String {
        let time = time
        var formattedTime: String
        
        if time >= 60 {
            let hour = time / 60
            let minutes = time % 60
            formattedTime = "\(hour)h \(minutes)m"
            
            return formattedTime
            
        } else {
            formattedTime = "\(time)m"
            
            return formattedTime
        }
    }
    
    
    func genreFormatter(array: [Genre]) -> String{
        
        var genreList: [String] = []
        
        for genre in array {
            genreList.append(genre.name)
        }
        
        let returnString = genreList.joined(separator: ", ")
        
        return returnString
    }
}
