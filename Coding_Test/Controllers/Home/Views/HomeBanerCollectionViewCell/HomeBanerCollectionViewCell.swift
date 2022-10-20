import UIKit
import Cosmos

class HomeBanerCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifier = "HomeBanerCollectionViewCell"
    var onImageLoadFailed: (( ) -> Void)?
    let homeVC = HomeViewController()
    let cornerRadius = 5.0
    
    //MARK: - Outlets
    
    @IBOutlet private var banerImageView: UIImageView!
    @IBOutlet private var cosmos: CosmosView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var cityLabel: UILabel!
    
    
    //MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cosmosConfiguration()
        cellConfiguratin()
        imageViewConfiguration()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath( roundedRect: bounds,
                                         cornerRadius: cornerRadius).cgPath
    }
    
    //MARK: - Methods
    
    static func nib() -> UINib {
        let nib = UINib(nibName: identifier, bundle: nil)
        return nib
    }
    
    private func cosmosConfiguration() {
        cosmos.settings.updateOnTouch = false
    }
    
    private func cellConfiguratin() {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    private func imageViewConfiguration() {
        banerImageView.contentMode = .scaleAspectFill
        banerImageView.clipsToBounds = true
    }
    
    func configure(data: BanerModel ) {
        cosmos.rating = Double(data .rating)
        
        nameLabel.text = data.name
        if data.width == 4 {
            cityLabel.text = data.city
        }
        
        let baseUrl = "https://res.cloudinary.com/goopterdev"
        let url = URL(string: baseUrl+data.imageUrl)
        guard let url = url else {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data, error == nil,
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.banerImageView.image = image
                }
            } else {
                self?.onImageLoadFailed?()
            }
        }
        dataTask.resume()
    }
}
