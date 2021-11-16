//
//  GameListView.swift
//  TopGames
//
//  Created by Hellen on 01/11/21.
//

import Foundation
import UIKit

final class GameListView: UIView {
    
    // MARK: - User Interface Components
    
    let array = [UIImage(named: "joker") ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundView = stateDescriptionLabel
        return tableView
    }()
    
    private let stateDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemGray
        return label
    }()
    
    var gamesList: [GameListCellModel] = []
    
    // MARK: - Inits
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(games: [GameListCellModel], stateDescription: String) {
        gamesList = games
        stateDescriptionLabel.text = stateDescription
        tableView.reloadData()
    }
}

extension GameListView: ViewCodeProtocol {
    
    func setupSubviews() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    func setupComponents() {
        tableView.delegate = self
        tableView.dataSource = self
        GameCell.registerOn(tableView)
    }
}

// MARK: - UITableView Extension

extension GameListView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = GameCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
                as? GameCell else { return UITableViewCell() }
        
        cell.configure(with: gamesList[indexPath.row])
        
        return cell
    }
}
