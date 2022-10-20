//
//  HomeCategoryCollectionViewCell.swift
//  Coding_Test
//
//  Created by mac on 2022-10-16.
//

import UIKit

class HomeCategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HomeCategoryCollectionViewCell"
    
    @IBOutlet private var categoryImageView: UIImageView!
    @IBOutlet private var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        let nib = UINib(nibName: identifier, bundle: nil)
        return nib
    }
    
    func configure(data: CategoryModel) {
        categoryName.text = data.categoryName
        
        let url = URL(string: data.imageUrl)
        guard let url = url else {
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            if error == nil && data != nil {
                
                if url.absoluteURL != url {
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    self?.categoryImageView.image = image
                }
            }
        }
        dataTask.resume()
    }
}

