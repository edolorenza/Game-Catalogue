//
//  DetailCreatorViewController.swift
//  Game Catalogue
//
//  Created by Edo Lorenza on 07/06/21.
//

import UIKit

class DetailCreatorViewController: UIViewController {
    //MARK: - Properties
    
    private var creators: Creator

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    init(creators: Creator) {
        self.creators = creators
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    
    //MARK: - Helpers
   private func setupView(){
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
}

//MARK: - TableViewDelegate
extension DetailCreatorViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let game = creators.games?[indexPath.row] else { return }
        let vc = DetailGameViewController(game: game)
        vc.title = game.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)

    }
}

//MARK: - TableViewDataSource
extension DetailCreatorViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creators.games?.count ?? 0
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = creators.games?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = model?.name
        return cell
    }
    
}
