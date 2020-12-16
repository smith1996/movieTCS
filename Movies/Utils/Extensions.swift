//
//  Extensions.swift
//  Movies
//
//  Created by Smith Huamani Hilario on 12/2/20.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            imageCache.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        
        image = nil

        if let cachedImage = imageCache.object(forKey: link as NSString) {
            contentMode = mode
            image = cachedImage
            return
        } else {
            downloaded(from: url, contentMode: mode)
        }
    }
}
