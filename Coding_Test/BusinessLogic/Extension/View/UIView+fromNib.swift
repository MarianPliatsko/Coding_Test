//
//  UIView+fromNib.swift
//  Coding_Test
//
//  Created by mac on 2022-10-15.
//

import UIKit

//extension UIView {
//    @discardableResult
//    func fromNib<T : UIView>() -> T? {
//        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
//            return nil
//        }
//        
//        self.addSubview(contentView)
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.frame = self.bounds
//        return contentView
//    }
//}
