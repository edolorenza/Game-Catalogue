//
//  FeedViewController.swift
//  Game Catalogue
//
//  Created by Edo Lorenza on 07/06/21.
//

import UIKit

enum FeedSectionType{
    case listOfGames(viewModels: [GamesViewModel]) // 0
    case listOfCreator(viewModels: [CreatorViewModel]) //1
    
    var title: String{
        switch self {
        case .listOfGames:
            return "Games"
        case .listOfCreator:
            return "Cretor"
        }
    }
}


class FeedViewController: UIViewController {
    //MARK: - Properties
    private var games: [Games] = []
    private var creator: [Creator] = []
    
    private var collectionView: UICollectionView = UICollectionView (
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout {
            sectionIndex, _ -> NSCollectionLayoutSection? in
            return FeedViewController.createSectionLayout(section: sectionIndex)
        }
    )
    
    private var sections = [FeedSectionType]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.backgroundColor = .systemBackground
        collectionView.frame = view.bounds
    }
    
    
    //MARK: - Actions
    
    //MARK: - API
    private func fetchData() {
        
        let group = DispatchGroup()
        group.enter()
        group.enter()
        
        var listOfGames: GamesResponse?
        var listOfCreator: CreatorResponse?
        
        //list of game
        APICaller.shared.getListOfGame { result in
            defer {
                group.leave()
            }
            switch result {
                case.success(let model):
                    listOfGames = model
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        //featured playlist
        APICaller.shared.getListOfCreator { result in
            defer {
                group.leave()
            }
            switch result {
                case.success(let model):
                    listOfCreator = model
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
 
        
        group.notify(queue: .main){
            
            guard let game = listOfGames?.results,
                  let creator = listOfCreator?.results
              
            else { return }
            
            self.configureModels(newGame: game, newCreator: creator)
        }
        
    }
    
    //MARK: - Helpers
    private func setupView(){
        configureCollectionView()
        fetchData()
    }
    
    private func configureCollectionView(){
        view.addSubview(collectionView)
        //configure collectionview cell
        collectionView.register(FeedViewCollectionViewCell.self,
                                forCellWithReuseIdentifier: FeedViewCollectionViewCell.identifier)
        collectionView.register(CreatorViewCollectionViewCell.self,
                                forCellWithReuseIdentifier: CreatorViewCollectionViewCell.identifier)

        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
    }
    
    private func configureModels(newGame: [Games], newCreator: [Creator]) {
        //configure models
        self.games = newGame
        self.creator = newCreator
        
        sections.append(.listOfGames(viewModels: games.compactMap({
            return GamesViewModel(
                name: $0.name,
                coverImage: $0.background_image,
                ratings: "\($0.rating)",
                genre: $0.genres.compactMap({
                    $0.name
                }),
                releaseData: $0.released)
        })))
        sections.append(.listOfCreator(viewModels: creator.compactMap({
            return CreatorViewModel(
                name: $0.name,
                profileImage: $0.image,
                totalGames: $0.games_count,
                positions: $0.positions.first?.name ?? "")
        })))
        
        collectionView.reloadData()
    }
    
}

//MARK: - UICollectionViewDelegate
extension FeedViewController: UICollectionViewDelegate {
        
}

//MARK: - UICollectionViewDataSource
extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type {
        case .listOfGames(let viewModels):
            return viewModels.count
        case .listOfCreator(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let type = sections[indexPath.section]
        switch type {
        case .listOfGames(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedViewCollectionViewCell.identifier, for: indexPath) as? FeedViewCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
            
        case .listOfCreator(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreatorViewCollectionViewCell.identifier, for: indexPath) as? CreatorViewCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
}

//MARK: - UICollectionViewCompositionalLayout
extension FeedViewController {
     static func createSectionLayout(section: Int) -> NSCollectionLayoutSection{
        let supplementaryViews = [
         NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(60)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        ]
        
        switch section {
        case 0:
            // item
            let item = NSCollectionLayoutItem(
                                layoutSize: NSCollectionLayoutSize(
                                widthDimension: .fractionalWidth(1.0),
                                heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 16, bottom: 2, trailing: 8)
      
            //group
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                                  layoutSize: NSCollectionLayoutSize(
                                  widthDimension: .fractionalWidth(0.9),
                                  heightDimension: .absolute(350)),
                                  subitem: item, count: 1)
            //section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryViews
            return section
        case 1:
            // item
            let item = NSCollectionLayoutItem(
                                layoutSize: NSCollectionLayoutSize(
                                widthDimension: .fractionalWidth(1.0),
                                heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 16, bottom: 2, trailing: 8)
            
            //vertical group in horizontal grup
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                                layoutSize: NSCollectionLayoutSize(
                                widthDimension: .fractionalWidth(1.0),
                                heightDimension: .absolute(390)),
                                subitem: item, count: 3)
            
            //group
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                                  layoutSize: NSCollectionLayoutSize(
                                  widthDimension: .fractionalWidth(0.9),
                                  heightDimension: .absolute(390)),
                                  subitem: verticalGroup, count: 1)
            //section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryViews
            return section
        default:
            // item
            let item = NSCollectionLayoutItem(
                                layoutSize: NSCollectionLayoutSize(
                                widthDimension: .fractionalWidth(1.0),
                                heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            //group
            let group = NSCollectionLayoutGroup.vertical(
                                layoutSize: NSCollectionLayoutSize(
                                widthDimension: .fractionalWidth(0.9),
                                heightDimension: .absolute(390)),
                                subitem: item, count: 1)
            //section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        }
    }
}

