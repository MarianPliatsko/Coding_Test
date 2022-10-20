import UIKit

class HomeCategoryCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifier = "HomeCategoryCollectionViewCell"
    
    //MARK: - Outlets
    
    @IBOutlet private var categoryImageView: UIImageView!
    @IBOutlet private var categoryName: UILabel!
    
    //MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Methods
    
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
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.categoryImageView.image = image
                }
            }
        dataTask.resume()
    }
}

