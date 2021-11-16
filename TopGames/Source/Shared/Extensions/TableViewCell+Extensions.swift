//
//  TableViewCell+Extensions.swift
//  TopGames
//
//  Created by Hellen on 15/11/21.
//

import UIKit

extension UITableViewCell {
    
    static func registerOn(_ tableView: UITableView) {
        let reuseIdentifier = String(describing: self.self)
        tableView.register(self.self, forCellReuseIdentifier: reuseIdentifier)
    }
}
