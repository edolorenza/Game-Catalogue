//
//  SearchViewController.swift
//  Game Catalogue
//
//  Created by Edo Lorenza on 07/06/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - Properties
    let searchController: UISearchController = {
        let result = SearchResultViewController()
        let vc = UISearchController(searchResultsController: result)
        vc.searchBar.placeholder = "Games"
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true
        return vc
    }()
    
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
        setupSearchController()
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
    
    private func setupSearchController(){
        navigationItem.searchController = searchController
        
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }

    
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let resultController = searchController.searchResultsController as? SearchResultViewController,
            let query = searchBar.text,
            !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        resultController.delegate = self
        APICaller.shared.search(query: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    resultController.update(with: results)
                break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
}

extension SearchViewController: SearchResultViewControllerDelegate{
    func showResult(controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let genres = genre[indexPath.row]
        let vc = DetailCreatorViewController(creators: genres)
        vc.title = genres.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
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
