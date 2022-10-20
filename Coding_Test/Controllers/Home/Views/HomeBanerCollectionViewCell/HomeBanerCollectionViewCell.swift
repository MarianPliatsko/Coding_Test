//
//  HomeCollectionViewCell.swift
//  Coding_Test
//
//  Created by mac on 2022-10-15.
//

import UIKit
import Cosmos
import TinyConstraints

class HomeBanerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HomeBanerCollectionViewCell"
    var onImageLoadFailed: (( ) -> Void)?
    let homeVC = HomeViewController()
    let cornerRadius = 5.0
    
    @IBOutlet private var banerImageView: UIImageView!
    @IBOutlet private var cosmos: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cosmosConfiguration()
        
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath( roundedRect: bounds,
                                         cornerRadius: cornerRadius).cgPath
    }
    
    static func nib() -> UINib {
        let nib = UINib(nibName: identifier, bundle: nil)
        return nib
    }
    
    func cosmosConfiguration() {
        cosmos.settings.updateOnTouch = false
    }
    
    func configure(data: BanerModel ) {
        cosmos.rating = Double(data .rating)
        
        let baseUrl = "https://res.cloudinary.com/goopterdev"
        let url = URL(string: baseUrl+data.imageUrl)
        guard let url = url else {
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            if error != nil {
                self?.onImageLoadFailed?()
            }
            
            guard data != nil else {
                return
            }
            
            if url.absoluteURL != url {
                return
            }
            
            guard let data = data else {
                return
            }
            
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                self?.banerImageView.image = image
            }
        }
        
        dataTask.resume()
    }
}