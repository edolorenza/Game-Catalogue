//
//  GenreViewCollectionViewCell.swift
//  Game Catalogue
//
//  Created by Edo Lorenza on 07/06/21.
//

import UIKit
import SDWebImage

class GenreViewCollectionViewCell: UICollectionViewCell {
    static let identifier = "GenreViewCollectionViewCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        imageView.image = UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .systemBackground
        contentView.dropShadow()
    }
    
    //MARK: - Helpers
    private func setupView(){
        contentView.addSubview(label)
        contentView.addSubview(imageView)
        imageView.layer.cornerRadius = 4
        imageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 8)
        imageView.setHeight(frame.height-40)
        
        label.anchor(top: imageView.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        contentView.addSubview(overlayView)
        overlayView.anchor(top: topAnchor, right: rightAnchor, paddingTop: 8, paddingRight: 8)
        overlayView.setDimensions(height: frame.height-40, width: frame.width/2)
    }

    func configure(with viewModel: CreatorViewModel) {
        label.text = viewModel.name
        imageView.sd_setImage(with: URL(string:viewModel.profileImage))
    }
}
