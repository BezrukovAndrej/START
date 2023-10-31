//
//  ViewController.swift
//  Start Cinema
//
//  Created by Andrey Bezrukov on 23.10.2023.
//

import UIKit


final class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = generateViewControllers()
        generateTabBarIconsWithName(for: viewControllers)
    }
    
    private func generateViewControllers() -> [UIViewController] {
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let upcomingViewController = UINavigationController(rootViewController: UpcomingViewController())
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        let downloadsViewController = UINavigationController(rootViewController: DownloadsViewController())
        
        return [homeViewController, upcomingViewController, searchViewController,
                downloadsViewController]
    }
    
    private func generateTabBarIconsWithName(for viewControllers: [UIViewController]?) {
        guard let viewControllers else { return }
        
        let homeImage = UIImage.IconMainMar.homeImage
        let searchImage = UIImage.IconMainMar.searchImage
        let basketImage = UIImage.IconMainMar.basketImage
        let downloadsIamge = UIImage.IconMainMar.downloadsIamge
        let imagesArray = [homeImage, searchImage, basketImage, downloadsIamge]
        
        let homeName = "HOME".localized
        let searchName = "COMING SOON".localized
        let topSearchName = "TOP SEARCH".localized
        let downloadsName = "DOWNLOADS".localized
        let nameArray = [homeName, searchName, topSearchName, downloadsName]
        
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 1))
        lineView.backgroundColor = .lightGray
        tabBar.insertSubview(lineView, at: 0)
        
        tabBar.tintColor = .label
        
        for (index, viewController) in viewControllers.enumerated() {
            viewController.tabBarItem.image = imagesArray[index]
            viewController.tabBarItem.title = nameArray[index]
        }
    }
}
