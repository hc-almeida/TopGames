//
//  TabBar.swift
//  TopGames
//
//  Created by Hellen on 01/11/21.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tabBar = UITabBar.appearance()
        tabBar.tintColor = .systemGray
        tabBar.barTintColor = .systemPink
        
        viewControllers = [gameListTabBar(), favoriteListTabBar()]
        
    }
    
    private func gameListTabBar() -> UINavigationController {
        let gameList = GameListViewController()
        gameList.title = "Search"
        gameList.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: gameList)
    }
    
    private func favoriteListTabBar() -> UINavigationController {
        let favorite = FavoritesViewController()
        favorite.title = "Favorites"
        favorite.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favorite)
    }
}
