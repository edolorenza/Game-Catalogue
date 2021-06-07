//
//  SearchViewController.swift
//  Game Catalogue
//
//  Created by Edo Lorenza on 07/06/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - Properties
    
    private var genre = [Creator]()
    
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

            item.contentInsets = NSDirectionalEdgeInsets(
                top: 2,
                leading: 6,
                bottom: 2,
                trailing: 6
            )

            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(180)),
                subitem: item,
                count: 2
            )

            group.contentInsets = NSDirectionalEdgeInsets(
                top: 4,
                leading: 0,
                bottom: 4,
                trailing: 0
            )

            return NSCollectionLayoutSection(group: group)
        })
    )
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupCollectionView()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.frame = view.bounds
    }

    //MARK: - Actions
    
    
    //MARK: - API
    private func fetchData(){
        APICaller.shared.getListOfGenres(urlPath: APICaller.serviceUrlPath(rawValue: "genres") ?? APICaller.serviceUrlPath.genres) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let genres):
                    self?.genre = genres
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    //MARK: - Helpers
    private func setupCollectionView(){
        view.addSubview(collectionView)
        collectionView.register(GenreViewCollectionViewCell.self,
                                forCellWithReuseIdentifier: GenreViewCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
    }

    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genre.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: GenreViewCollectionViewCell.identifier,
                for: indexPath
        ) as? GenreViewCollectionViewCell else {
            return UICollectionViewCell()
        }
        let genre = genre[indexPath.row]
        cell.configure(
            with: CreatorViewModel(
                name: genre.name,
                profileImage: genre.image_background,
                totalGames: genre.games_count,
                positions: genre.slug)
        )
        return cell
    }
}
