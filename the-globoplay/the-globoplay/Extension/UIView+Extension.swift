//
//  UIView+Extension.swift
//  the-globoplay
//
//  Created by Letícia Faleia on 12/11/24.
//

import Foundation
import UIKit

var isOutdated =  true

extension UIColor {
    static let homeBackground = UIColor(red: 31/255.0, green: 31/255.0, blue: 31/255.0, alpha: 1.0)
}

extension UIImageView {
    func loadImage(urlString: String, completion: @escaping() -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        completion()
                    }
                }
            }
        }
    }
}
