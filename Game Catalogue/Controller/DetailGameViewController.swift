//
//  DetailViewController.swift
//  Game Catalogue
//
//  Created by Edo Lorenza on 07/06/21.
//

import UIKit
import SDWebImage

class DetailGameViewController: UIViewController{
    //MARK: - Properties
    
    private var game: Games
    
    private let gameImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "DESCRIPTION"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    private let playTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let achievmentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.alpha = 0.5
        view.backgroundColor = .black
        view.isHidden = true
        return view
    }()
    
    let scrollView: UIScrollView = {
       let v = UIScrollView()
       v.translatesAutoresizingMaskIntoConstraints = false
       v.contentInsetAdjustmentBehavior = .never
       return v
    }()

    private let summary: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .label
        return label
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationController?.view.backgroundColor = UIColor.clear
        prepareForReuse()
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let loader = self.loader()
        self.fetchData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.descriptionLabel.isHidden = false
            self.overlayView.isHidden = false
            self.stopLoader(loader: loader)
        }
       
    }
    
     func prepareForReuse() {
        descriptionLabel.isHidden = true
        titleLabel.text = nil
        summary.text = nil
        gameImageView.image = nil
        achievmentLabel.text = nil
        playTimeLabel.attributedText = nil
        achievmentLabel.attributedText = nil
        ratingLabel.attributedText = nil
        yearLabel.text = nil
    }
    
    init(game: Games) {
        self.game = game
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addSubview(scrollView)
    }
    
    //MARK: - API
    private func fetchData(){
        APICaller.shared.getDetailOfGame(game: game) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.game = model
                    self?.configure()
                case . failure(let error):
                    print(error)
                }
            }
        }
    }
    
    
    //MARK: - Helpers
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
          // constrain the scroll view
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        
        scrollView.addSubview(gameImageView)
        gameImageView.anchor(top: scrollView.topAnchor,left: view.leftAnchor,right: view.rightAnchor, height: view.frame.width/1.5)
        
        scrollView.addSubview(overlayView)
        overlayView.setHeight(60)
        overlayView.anchor(top: gameImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: -58)
        
        let headerStack = UIStackView(arrangedSubviews: [yearLabel, titleLabel])
        headerStack.distribution = .fillEqually
        scrollView.addSubview(headerStack)
        headerStack.axis = .vertical
        headerStack.spacing = 2
        headerStack.anchor(top: gameImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: -58, paddingRight: 16)
        yearLabel.setHeight(28)
        titleLabel.setHeight(28)
        
        
        let stack = UIStackView(arrangedSubviews: [achievmentLabel, playTimeLabel,ratingLabel])
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.axis = .horizontal
        stack.spacing = 24
        stack.anchor(top: gameImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: stack.bottomAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        let topDivider = UIView()
        topDivider.backgroundColor = .lightGray
        view.addSubview(topDivider)
        topDivider.anchor(top:  descriptionLabel.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: -6, paddingLeft: 16, paddingRight: 16, height: 0.5)

        
        scrollView.addSubview(summary)
        summary.anchor(top: descriptionLabel.bottomAnchor, left: view.leftAnchor, bottom: scrollView.bottomAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
    }
    
    func configure(){
        guard let date = game.released else { return }
        guard let playtime = game.playtime else { return }
        guard let rating = game.rating else { return }
        
        let releaseYear = date.formattedDate

        titleLabel.text = game.name
        yearLabel.text = releaseYear
        summary.text = game.description_raw
        gameImageView.sd_setImage(with: URL(string: game.background_image ?? ""))
        achievmentLabel.text = String(game.achievements_count ?? 0)
        playTimeLabel.attributedText = atributedText(title: "Playtime", Value: "\(playtime) Hours")
        achievmentLabel.attributedText = atributedText(title: "Achievments", Value: "204")
        ratingLabel.attributedText = atributedText(title: "Ratings", Value: "\(rating)/5")
    }
    
    func atributedText(title: String, Value: String) -> NSAttributedString {
        let atributedString = NSMutableAttributedString(string: "\(title)\n", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.secondaryLabel])
        atributedString.append(NSAttributedString(string: Value, attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.label]))
        return atributedString
    }
    
}
 
extension DetailGameViewController{
    func loader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "please wait..", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.startAnimating()
        alert.view.addSubview(indicator)
        self.present(alert, animated: true, completion: nil)
        return alert
    }
    
    func stopLoader(loader: UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
}
