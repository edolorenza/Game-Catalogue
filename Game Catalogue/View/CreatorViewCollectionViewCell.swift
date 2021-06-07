//
//  CreatorViewCollectionViewCell.swift
//  Game Catalogue
//
//  Created by Edo Lorenza on 07/06/21.
//

import Foundation
import SDWebImage

class CreatorViewCollectionViewCell: UICollectionViewCell{
    
    static let identifier = "CreatorViewCollectionViewCell"
    
    //MARK: - Properties
    private let profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .label
        return label
    }()
    
    
    private let totalGameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
    
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
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
        contentView.backgroundColor = .secondarySystemBackground
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor)
        profileImageView.setDimensions(height: frame.height, width: frame.height)
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, positionLabel, totalGameLabel])
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 4
        stack.centerY(inView: profileImageView)
        stack.anchor(left: profileImageView.rightAnchor, paddingLeft: 8)
    }
    
    func configure(with viewModel: CreatorViewModel) {
        profileImageView.sd_setImage(with: URL(string: viewModel.profileImage))
        nameLabel.text = viewModel.name
        totalGameLabel.text = "Total Game \(viewModel.totalGames)"
        positionLabel.text = viewModel.positions
    }
    
}

