import UIKit
import DropDown

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    
    private let dropDown = DropDown()

    private var isShowing: Bool = false
    
    private var listOfCityContainer: [CityContainer] = []
    private var listOfCityModel: [CityModel] = []
    
    private var categoryContainerData: [CategoryContainer] = []
    
    private var banerDataContainer: [BanerContainer] = []
    private var banerDataModel: [BanerModel] = []
    
    //MARK: - Outlets
    
    @IBOutlet private var homeCollectionView: UICollectionView!
    @IBOutlet private var menuButton: UIButton!
    @IBOutlet private var dropDownLabel: UILabel!
    @IBOutlet private var dropDownImage: UIImageView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        homeCollectionView.register(HomeBanerCollectionViewCell.nib(),
                                    forCellWithReuseIdentifier: HomeBanerCollectionViewCell.identifier)
        homeCollectionView.register(HomeCollectionReusableView.nib(),
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: HomeCollectionReusableView.identifier)
        getBanerData()
        configDropDown()
        getCategoryData()
        dropDownImage.image = UIImage(systemName: "chevron.down")
    }
    
    //MARK: - Actions
    
    @IBAction func dropDownButton(_ sender: Any) {
        showDropDown()
    }
    
    @IBAction func detailButton(_ sender: Any) {
    }
    
    //MARK: - Private methods
    
    private func getBanerData() {
        BanerDataRepository.shared.getBaner { [weak self] data in
            switch data {
            case.success(let data):
                self?.banerDataContainer = [data]
                self?.updateUIBanner()
                
            case .failure(let error):
                if error == .cityNotFound {
                    print("city not founded")
                } else
                if error == .timeOut {
                    print("Network Time Out")
                }
            }
        }
    }
    
    private func getCategoryData() {
        let data = CategoryDataRepository()
        data.getCityList { [weak self] data in
            
            switch data {
            case.success(let data):
                self?.categoryContainerData = [data]
            case .failure(let error):
                if error == .categoryNotFound {
                    print("city not founded")
                } else
                if error == .timeOut {
                    print("Network Time Out")
                }
            }
        }
    }
    
    private func updateUIBanner() {
        for element in banerDataContainer {
            let element = element.records
            self.banerDataModel = element
            self.homeCollectionView.reloadData()
        }
    }
    
    private func showDropDown() {
        CityDataRepository.shared.getCityList { [weak self] data in
            
            switch data {
            case.success(let data):
                self?.listOfCityContainer = [data]
                self?.updateDropDownUI()
                self?.dropDown.show()
                
            case.failure(let error):
                if error == .cityNotFound {
                    print("city not founded")
                } else
                if error == .timeOut {
                    print("Network Time Out")
                }
            }
        }
    }
    
    private func updateDropDownUI() {
        for element in self.listOfCityContainer {
            let element = element.records
            self.listOfCityModel = element
        }
        
        for element in self.listOfCityModel {
            dropDown.dataSource = [element.name]
            dropDown.selectionAction = { [weak self]
                (index: Int, item: String) in
                self?.dropDownLabel.text = self?.dropDown.dataSource[index]
            }
        }
    }
    
    private func configDropDown() {
        self.dropDownLabel.text = "Select a city"
        dropDown.anchorView = dropDownLabel
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banerDataModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomeBanerCollectionViewCell.identifier, for: indexPath) as? HomeBanerCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.onImageLoadFailed = {[weak self] in
            DispatchQueue.main.async {
                self?.banerDataModel[indexPath.row].imageFailed = true
                collectionView.collectionViewLayout.invalidateLayout()
            }
        }
        
        cell.configure(data: self.banerDataModel[indexPath.row])
        print("cells:\(cell)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeCollectionReusableView.identifier, for: indexPath) as? HomeCollectionReusableView else {
            return UICollectionReusableView()
        }
        headerView.categoryContainerData = categoryContainerData
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item = banerDataModel[indexPath.row]
        var width = CGFloat()
        let screenWidth = view.frame.size.width
        let screenHeight = 143.0
        
        if item.imageFailed ?? false {
            return .zero
        }
        
        switch item.width {
        case 4:
            width = screenWidth
        case 2:
            width = (screenWidth - 10) / 2
        default:
            width = 0
        }
        return CGSize(width: width, height: screenHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
}
