//
//  DevelopersViewCollectionViewCell.swift
//  Game Catalogue
//
//  Created by Edo Lorenza on 07/06/21.
//

import UIKit
import SDWebImage

class DevelopersViewCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "DevelopersViewCollectionViewCell"

    private let developerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .label
        return label
    }()

    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError()
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
       
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        developerImageView.image = nil
    }

    //MARK: - Helpers
    private func setupView(){
        addSubview(developerImageView)
        addSubview(nameLabel)
        
        developerImageView.anchor(top: topAnchor, left: leftAnchor)
        developerImageView.setDimensions(height: frame.height, width: frame.height + frame.height/2)
        
     
        addSubview(nameLabel)
        nameLabel.centerY(inView: developerImageView)
        nameLabel.anchor(left: developerImageView.rightAnchor, right: rightAnchor, paddingLeft: 16)
    }
    
    func configure(with viewModel: DeveloperViewModel) {
        developerImageView.sd_setImage(with: URL(string: viewModel.developersImage))
        nameLabel.text = viewModel.name
    }
}
