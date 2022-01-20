//
//  FirstVCExtension.swift
//  UnsplashTestProject
//
//  Created by NODIR KARIMOV on 18/01/22.
//

import UIKit

extension FirstViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let imageResultUrlString = results[indexPath.item].urls.small
        
        let url = URL(string: imageResultUrlString)!
        cell.imageView.downloaded(from: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.result = results[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.frame.width / 3
        return .init(width: size, height: size)
    }
    
}

extension FirstViewController: UISearchBarDelegate, UITextFieldDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        results.removeAll()
        guard let text = searchBar.text else { return }
        
        DispatchQueue.main.async {
            self.networkManager.fetchPhotos(query: text) { image in
                self.results = image.results
                self.collectionView.reloadData()
            }
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        results.removeAll()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            results.removeAll()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

