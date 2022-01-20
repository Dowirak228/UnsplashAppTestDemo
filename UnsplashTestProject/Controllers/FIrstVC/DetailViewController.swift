//
//  DetailViewController.swift
//  UnsplashTestProject
//
//  Created by NODIR KARIMOV on 18/01/22.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    let realm = try! Realm()
        
    var result: Result!
    var isTapped: Bool = true
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .green
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " Name: \(result.user.first_name)"
        return label
    }()
    
    private lazy var userLocationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " Location: \(result.user.location ?? "Earth")"
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = #colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [imageView, userNameLabel, userLocationLabel, button].forEach {view.addSubview($0)}
        
        setupConstraints()
        
        let urlString = "\(result.urls.small)"
        let url = URL(string: urlString)!
        imageView.downloaded(from: url)
    }
    
    //Mark: - Data Manipulation Methods
    func save(data: ImageDB) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("Error saving category \(error)")
        }
        let secondVC = SecondViewController()
        secondVC.loadData()
    }
    
    @objc func saveButtonTapped() {
        
        let ac = UIAlertController(title: "Save", message: "Do you wanna save it?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { alert in
            let imageDB = ImageDB()
            imageDB.imageView = self.result.urls.small
            imageDB.name = self.result.user.first_name
            imageDB.location = self.result.user.location ?? "Earth"
            self.save(data: imageDB)
        })
        
        let noAction = UIAlertAction(title: "No", style: .cancel)
            
        ac.addAction(yesAction)
        ac.addAction(noAction)
        present(ac, animated: true, completion: nil)
        
    }
        
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 3/4),
            
            userNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            userNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            userNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            userNameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            userLocationLabel.topAnchor.constraint(equalTo: userNameLabel.topAnchor, constant: 50),
            userLocationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            userLocationLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            userLocationLabel.heightAnchor.constraint(equalToConstant: 50),
            
            button.topAnchor.constraint(equalTo: userLocationLabel.bottomAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
}

