//
//  UIImageView+Extensions.swift
//  Tradernet
//
//  Created by Vladislav Bondarev on 23.12.2022.
//

import UIKit

extension UIImageView {
    func downloadIcon(with urlString: String, completion: ((Bool) -> Void)? = nil) {
        guard let url = URL(string: urlString) else { return }
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else {
                completion?(false)
                return
            }
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
                completion?(true)
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
