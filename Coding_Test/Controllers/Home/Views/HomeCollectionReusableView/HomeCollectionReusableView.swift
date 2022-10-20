//
//  HomeCollectionReusableView.swift
//  Coding_Test
//
//  Created by mac on 2022-10-15.
//

import UIKit

class HomeCollectionReusableView: UICollectionReusableView {
    
    //MARK: - Properties
    
    var categoryContainerData: [CategoryContainer] = [] {
        didSet {
            updateUICategory()
        }
    }
    private var categotyModelData: [CategoryModel] = []
    static let identifier = "HomeCollectionReusableView"
    
    //MARK: - Outlets
    
    @IBOutlet private var headerCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
        headerCollectionView.register(HomeCategoryCollectionViewCell.nib(), forCellWithReuseIdentifier: HomeCategoryCollectionViewCell.identifier)
    }
    
    //MARK: - Methods
    
    static func nib() -> UINib {
        let nib = UINib(nibName: identifier, bundle: nil)
        return nib
    }
    
    private func updateUICategory() {
        for element in categoryContainerData {
            let element = element.records
            self.categotyModelData = element    
        }
        
        headerCollectionView.reloadData()
    }
}

    //MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension HomeCollectionReusableView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categotyModelData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCollectionViewCell.identifier, for: indexPath) as? HomeCategoryCollectionViewCell else {
            return  UICollectionViewCell()
        }
        
        cell.configure(data: categotyModelData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: collectionView.frame.size.height)
    }
}

