//
//  DetailViewController.swift
//  Game Catalogue
//
//  Created by Edo Lorenza on 07/06/21.
//

import UIKit

class DetailViewController: UIViewController{
    //MARK: - Properties
    private let gameImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.masksToBounds = true
        iv.image = #imageLiteral(resourceName: "gameImage")
        return iv
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "DESCRIPTION"
        label.textColor = .lightGray
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        label.text = "2015"
        label.textColor = .white
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        label.text = "The Witcher 3: Wild Hunt"
        label.textColor = .white
        return label
    }()
    
    private let playTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "Playtime\n 50 Hours"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let achievmentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
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
        label.text = "The third game in a series, it holds nothing back from the player. Open world adventures of the renowned monster slayer Geralt of Rivia are now even on a larger scale. Following the source material more accurately, this time Geralt is trying to find the child of the prophecy, Ciri while making a quick coin from various contracts on the side. Great attention to the world building above all creates an immersive story, where your decisions will shape the world around you.\n\nCD Project Red are infamous for the amount of work they put into their games, and it shows, because aside from classic third-person action RPG base game they provided 2 massive DLCs with unique questlines and 16 smaller DLCs, containing extra quests and items.\n\nPlayers praise the game for its atmosphere and a wide open world that finds the balance between fantasy elements and realistic and believable mechanics, and the game deserved numerous awards for every aspect of the game, from music to direction.The third game in a series, it holds nothing back from the player. Open world adventures of the renowned monster slayer Geralt of Rivia are now even on a larger scale. Following the source material more accurately, this time Geralt is trying to find the child of the prophecy, Ciri while making a quick coin from various contracts on the side. Great attention to the world building above all creates an immersive story, where your decisions will shape the world around you.\n\nCD Project Red are infamous for the amount of work they put into their games, and it shows, because aside from classic third-person action RPG base game they provided 2 massive DLCs with unique questlines and 16 smaller DLCs, containing extra quests and items.\n\nPlayers praise the game for its atmosphere and a wide open world that finds the balance between fantasy elements and realistic and believable mechanics, and the game deserved numerous awards for every aspect of the game, from music to direction."
        label.textColor = .white
        return label
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        view.backgroundColor = ColorCons.tuna
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    //MARK: - Helpers
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.addSubview(scrollView)
          // constrain the scroll view
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        
        scrollView.addSubview(gameImageView)
        gameImageView.anchor(top: scrollView.topAnchor,left: view.leftAnchor,right: view.rightAnchor, height: view.frame.width/1.5)
        
        let headerStack = UIStackView(arrangedSubviews: [yearLabel, titleLabel])
        headerStack.distribution = .fillEqually
        headerStack.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.25)
        scrollView.addSubview(headerStack)
        headerStack.axis = .vertical
        headerStack.spacing = 2
        headerStack.anchor(top: gameImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: -58)
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
        playTimeLabel.attributedText = atributedText(title: "Playtime", Value: "50 Hours")
        achievmentLabel.attributedText = atributedText(title: "Achievments", Value: "204")
        ratingLabel.attributedText = atributedText(title: "Ratings", Value: "4.67/5")
    }
    
    func atributedText(title: String, Value: String) -> NSAttributedString {
        let atributedString = NSMutableAttributedString(string: "\(title)\n", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray])
        atributedString.append(NSAttributedString(string: Value, attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        return atributedString
    }
}
