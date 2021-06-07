//
//  FeedCell.swift
//  Game Catalogue
//
//  Created by Edo Lorenza on 07/06/21.
//

import Foundation
import SDWebImage

class FeedViewCollectionViewCell: UICollectionViewCell{
    
    static let identifier = "FeedViewCollectionViewCell"
    
    //MARK: - Properties
    private let profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "The Witcher 3: Wild Hunt"
        label.textColor = .label
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "2015"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "⭐️ 4.8"
        label.textColor = .label
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Action, Adventure"
        label.textColor = .secondaryLabel
        return label
    }()
    
    
    //MARK: - lifecycle
    override init (frame: CGRect){
    super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) Has Not Been Implemented")
    }
    
    //MARK: - Helpers
    func setupView(){
//        contentView.backgroundColor = ColorCons.tuna
        contentView.dropShadow()
        
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, ratingLabel, genreLabel])
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 4
        stack.anchor(top:topAnchor, left: leftAnchor, paddingTop: 4)
        
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor,bottom: bottomAnchor, right: rightAnchor)
        profileImageView.setDimensions(height: frame.height-100, width: frame.width)
        profileImageView.layer.cornerRadius = 8
     
    }
    
    func configure(with viewModel: GamesViewModel) {
        profileImageView.sd_setImage(with: URL(string: viewModel.coverImage))
        yearLabel.text = viewModel.releaseData
        titleLabel.text = viewModel.name
        ratingLabel.text = "⭐️  \(viewModel.ratings)"
        genreLabel.text = viewModel.genre.joined(separator: ", ")
    }
    
}

