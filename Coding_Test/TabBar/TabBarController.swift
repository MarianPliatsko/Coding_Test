//
//  ViewController.swift
//  Coding_Test
//
//  Created by mac on 2022-10-13.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .label
        viewControllers = createdViewControllers()
    }

    func createdViewControllers() -> [UIViewController] {
        let homeStoryBoard = UIStoryboard(name: "Home", bundle: nil)
        let homeViewController = homeStoryBoard.instantiateViewController(withIdentifier: "HomeViewController")
        
        
        let whatsHotStoryBoard = UIStoryboard(name: "WhatsHot", bundle: nil)
        let whatsHotViewController = whatsHotStoryBoard.instantiateViewController(withIdentifier: "WhatsHotViewController")
        
        
        let orderStoryBoard = UIStoryboard(name: "Order", bundle: nil)
        let orderViewController = orderStoryBoard.instantiateViewController(withIdentifier: "OrderViewController")
        
        
        let accountStoryBoard = UIStoryboard(name: "Account", bundle: nil)
        let accountViewController = accountStoryBoard.instantiateViewController(withIdentifier: "AccountViewController")
        
        homeViewController.title = "Home"
        whatsHotViewController.title = "Whats Hot"
        orderViewController.title = "Order"
        accountViewController.title = "Account"
        
        homeViewController.tabBarItem.image = UIImage(named: "i_home")
        whatsHotViewController.tabBarItem.image = UIImage(named: "i_hot")
        orderViewController.tabBarItem.image = UIImage(named: "i_order")
        accountViewController.tabBarItem.image = UIImage(named: "i_my_account")
        
        return [homeViewController, whatsHotViewController, orderViewController, accountViewController]
    }
}

