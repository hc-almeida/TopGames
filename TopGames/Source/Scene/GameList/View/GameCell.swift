//
//  GameCell.swift
//  TopGames
//
//  Created by Hellen on 01/11/21.
//

import Foundation
import UIKit

class GameCell: UITableViewCell {
    
    // MARK: - User Interface Components
    
    private lazy var cardView: UIView = {
        let cardView = UICardView()
        cardView.backgroundColor = .white
        return cardView
    }()
    
    private lazy var cardImageView: UIView = {
        let cardImageView = UICardView()
        cardImageView.clipsToBounds = true
//        cardImageView.sh
//        cardImageView.backgroundColor = .white
        return cardImageView
    }()
    
    lazy var blurImage: UIImageView = {
        let blurImage = UIImageView()
        blurImage.backgroundColor = .green
        blurImage.addBlurToView()
        return blurImage
    }()
    
    lazy var gameImage: UIImageView = {
        let gameImage = UIImageView()
        gameImage.layer.cornerRadius = 4
        gameImage.clipsToBounds = true
        gameImage.backgroundColor = .yellow
        gameImage.contentMode = .scaleAspectFill
        return gameImage
    }()
    
    var cardNameView: UIView = {
        let cardNameView = UIView()
        cardNameView.backgroundColor = .black
        return cardNameView
    }()
    
    var nameGame: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
//        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var noteGame: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Nota metricts: 60"
//        label.textAlignment = .center
        return label
    }()
    
    var categoryGame: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Aventura - Ação"
//        label.textAlignment = .center
        return label
    }()
    
    var release: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "02 novembro 2019"
//        label.textAlignment = .center
        return label
    }()
    
    var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_favorites_bordered"), for: .normal)
        return button
    }()
    
    var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up.fill"), for: .normal)
        return button
    }()
    
    lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [favoriteButton,
                                                      shareButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()

    
    // MARK: - Public Properties
    
    static let identifier = String(describing: GameCell.self)
    
    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        clear()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        clear()
    }
    
    // MARK: - Public Functions

    let viewModel = GameListViewModel()
    
    func configure(with model: GameListCellModel) {
        nameGame.text = model.name
        categoryGame.text = model.genres
        
        let imageURL = model.image
        
        viewModel.downloadImageWith(urlString: imageURL) { [weak self] (imageData, error) in
             guard let self = self,
                   let currentStr = model.image,
                   currentStr == imageURL,
                   let imageData = imageData,
                   let gameImage = UIImage(data: imageData) else { return }
             DispatchQueue.main.async {
                 self.blurImage.image = gameImage
                 self.gameImage.image = gameImage
             }
         }
    }
    
    // MARK: - Private Functions
    
    func clear() {
        blurImage.image = nil
        gameImage.image = nil
        nameGame.text = nil
    }
}

// MARK: - ViewCodeProtocol Extension

extension GameCell: ViewCodeProtocol {
    
    func setupSubviews() {
        addSubview(cardView)
        cardView.addSubview(cardImageView)
        cardView.addSubview(nameGame)
        cardView.addSubview(noteGame)
        cardView.addSubview(categoryGame)
        cardView.addSubview(release)
        addSubview(cardImageView)
        cardImageView.addSubview(blurImage)
        blurImage.addSubview(gameImage)
        
//        cardView.addSubview(favoriteButton)
//        cardView.addSubview(shareButton)
        
//        addSubview(cardImageView)
//        cardImageView.addSubview(blurImage)
//        blurImage.addSubview(gameImage)
//        addSubview(nameGame)
//        addSubview(noteGame)
//        addSubview(categoryGame)
//        addSubview(release)
//        addSubview(stackView)
//        addSubview(favoriteButton)
//        addSubview(shareButton)
    }
    
    func setupConstraints() {
        
        cardView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 8, paddingRight: 16, height: 240)

        cardImageView.anchor(top: cardView.topAnchor, left: cardView.leftAnchor, bottom: cardView.bottomAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16, width: 150, height: 200)
        
//        cardImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 8, width: 160, height: 220)

        blurImage.anchor(top: cardImageView.topAnchor, leading: cardImageView.leadingAnchor, bottom: cardImageView.bottomAnchor, trailing: cardImageView.trailingAnchor)
        
        gameImage.anchor(top: blurImage.topAnchor, left: blurImage.leftAnchor, bottom: blurImage.bottomAnchor, right: blurImage.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)

//        nameGame.anchor(top: cardView.topAnchor, left: cardImageView.rightAnchor, right: cardView.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 8)
        
        nameGame.anchor(top: topAnchor, left: cardImageView.rightAnchor, right: rightAnchor, paddingTop: 32, paddingLeft: 16, paddingRight: 8)
        
        noteGame.anchor(top: nameGame.bottomAnchor, left: cardImageView.rightAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 8)
        
        categoryGame.anchor(top: noteGame.bottomAnchor, left: cardImageView.rightAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 16, paddingRight: 8)
        
        release.anchor(top: categoryGame.bottomAnchor, left: cardImageView.rightAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 16, paddingRight: 8)
        
//        favoriteButton.anchor(top: categoryGame.bottomAnchor, left: cardImageView.rightAnchor, paddingTop: 24, paddingLeft: 16, width: 35, height: 35)
//
//        shareButton.anchor(top: categoryGame.bottomAnchor, left: favoriteButton.rightAnchor, paddingTop: 24, paddingLeft: 16, width: 35, height: 35)
//
//        shareButton.anchor(top: favoriteButton.bottomAnchor, left: cardImageView.rightAnchor, paddingTop: 24, paddingLeft: 16, width: 35, height: 35)
    }
    
    func setupComponents() {
        backgroundColor = .white
        selectionStyle = .none
//        favoriteImage.image = UIImage(named: "icon_favorites_bordered")
    }
}
