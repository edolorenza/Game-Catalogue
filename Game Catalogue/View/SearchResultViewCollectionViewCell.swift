//
//  SearchResultViewCollectionViewCell.swift
//  Game Catalogue
//
//  Created by Edo Lorenza on 09/06/21.
//

import UIKit
import SDWebImage

class SearchResultViewCollectionViewCell: UICollectionViewCell{
    
    //MARK: - Properties
    static let identifier = "SearchResultViewCollectionViewCell"
    
    private let profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.backgroundColor = .secondaryLabel
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
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
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "⭐️ 4.8"
        label.textColor = .label
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "Action, Adventure"
        label.textColor = .secondaryLabel
        return label
    }()
    
    
    //MARK: - lifecycle
    override init (frame: CGRect){
    super.init(frame: frame)
        self.backgroundColor = .secondarySystemBackground
        contentView.layer.masksToBounds = true
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) Has Not Been Implemented")
    }
    
    //MARK: - Helpers
    func setupView(){
        contentView.addSubview(profileImageView)
        profileImageView.centerY(inView: self)
        profileImageView.anchor(left: leftAnchor,paddingLeft: 8)
        profileImageView.setDimensions(height: frame.width/4, width: frame.width/4)
        
        let stack = UIStackView(arrangedSubviews: [yearLabel, titleLabel, ratingLabel, genreLabel])
        stack.distribution = .fillEqually
        contentView.addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 4
        stack.centerY(inView: profileImageView)
        stack.anchor(left: profileImageView.rightAnchor, right:rightAnchor, paddingLeft: 6, paddingRight: 4)
    }
    
    func configure(with viewModel: GamesViewModel) {
        profileImageView.sd_setImage(with: URL(string: viewModel.coverImage))
        yearLabel.text = viewModel.releaseData.formattedDate
        titleLabel.text = viewModel.name
        ratingLabel.text = "⭐️  \(viewModel.ratings)"
    }
    
}
