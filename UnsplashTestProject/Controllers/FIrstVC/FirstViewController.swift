//
//  ViewController.swift
//  UnsplashTestProject
//
//  Created by NODIR KARIMOV on 17/01/22.
//

import UIKit
import RealmSwift

class FirstViewController: UIViewController {
    
    let realm = try! Realm()
    
    let networkManager = NetworkManager()
        
    var results: [Result] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.barTintColor = UIColor.systemBackground
        searchBar.searchTextField.delegate = self
        searchBar.placeholder = "Search"
        searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 8, vertical: 0)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Unsplash Photo"
            
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }
    
    override func viewDidLayoutSubviews() {
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            searchBar.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 3),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 5)
        ])
    }
}

