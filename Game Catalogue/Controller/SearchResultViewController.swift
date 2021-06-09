//
//  SearchResultViewController.swift
//  Game Catalogue
//
//  Created by Edo Lorenza on 09/06/21.
//

import UIKit

protocol SearchResultViewControllerDelegate: AnyObject {
    func showResult(controller: UIViewController)
}

class SearchResultViewController: UIViewController {
    //MARK: - Properties
    private var games: [Games] = []
    
    weak var delegate: SearchResultViewControllerDelegate?
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        return collectionView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
    }
    
    private func setupCollectionView(){
        view.addSubview(collectionView)
        collectionView.register(SearchResultViewCollectionViewCell.self,
                                forCellWithReuseIdentifier: SearchResultViewCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.frame = view.bounds
        
    }
    
    //MARK: - Helpers
    func update(with results: [Games]){
        self.games = results
        collectionView.reloadData()
        collectionView.isHidden = results.isEmpty
    }
}


//MARK: - UICollectionViewDataSource
extension SearchResultViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultViewCollectionViewCell.identifier, for: indexPath) as? SearchResultViewCollectionViewCell else  {
            return SearchResultViewCollectionViewCell()
        }
        let games = games[indexPath.row]
        cell.configure(with: GamesViewModel(
                        name: games.name ?? "",
                        coverImage: games.background_image ?? "",
                        ratings: String(games.rating ?? 0),
                        genre: games.genres?.compactMap({
                            $0.name
                        }) ?? [""],
                        releaseData: games.released ?? ""))
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension SearchResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let game = games[indexPath.row]
        let vc = DetailGameViewController(game: game)
        vc.title = game.name
        vc.navigationItem.largeTitleDisplayMode = .never
        delegate?.showResult(controller: vc)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        let height = view.frame.width / 3
        return CGSize(width: width, height: height)
    }
}





