//
//  MainTabBarController.swift
//  UnsplashTestProject
//
//  Created by NODIR KARIMOV on 18/01/22.
//

import UIKit

class MainTabBarController: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()
        tabbarUI()

        setupViewControllers()
    }
    
    func tabbarUI() {
        tabBar.backgroundColor = UIColor.lightGray
        tabBar.unselectedItemTintColor = .white
        tabBar.tintColor = .black
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        tabBar.layer.borderColor = UIColor.clear.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.black.cgColor
    }
    
    func setupViewControllers() {
        let vc1 = UINavigationController(rootViewController: FirstViewController())
        let vc2 = UINavigationController(rootViewController: SecondViewController())
        setViewControllers([vc1, vc2], animated: true)
        
        vc1.tabBarItem.title = "FIRST"
        vc2.tabBarItem.title = "SECOND"
    }
}
