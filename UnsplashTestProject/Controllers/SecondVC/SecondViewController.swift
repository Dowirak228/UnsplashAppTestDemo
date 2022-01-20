//
//  SecondViewController.swift
//  UnsplashTestProject
//
//  Created by NODIR KARIMOV on 19/01/22.
//

import UIKit
import RealmSwift
import AnimatableReload

class SecondViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var imageDBInfo: Results<ImageDB>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70.0
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.identifier)
        loadData()
    }
    
    @objc func refreshTapped() {
        DispatchQueue.main.async {
            AnimatableReload.reload(tableView: self.tableView, animationDirection: "up")
        }
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
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func loadData() {
        
        imageDBInfo = realm.objects(ImageDB.self)
        DispatchQueue.main.async {
            AnimatableReload.reload(tableView: self.tableView, animationDirection: "up")
        }
    }
}

extension SecondViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imageDBInfo?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        super.tableView(tableView, cellForRowAt: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as? ImageTableViewCell else {
            return UITableViewCell()
        }
        
        let urlString = imageDBInfo?[indexPath.row].imageView ?? ""
        let url = URL(string: urlString)!
        
        cell.cellImageView.downloaded(from: url)
        cell.userNameLabel.text = imageDBInfo?[indexPath.row].name ?? "You haven't specified saving data"
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = SecondDetailVC()
        vc.result = imageDBInfo?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    //Delete by swiping
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.tableView.beginUpdates()
            
            self.tableView.deleteRows(at: [indexPath], with: .automatic)

            
            if let item = imageDBInfo?[indexPath.row] {
                do {
                    try realm.write{
                        realm.delete(item)
                    }
                } catch {
                    print("Error deleting item, \(error)")
                }
            }
            
            self.tableView.endUpdates()
        }
    }
}
