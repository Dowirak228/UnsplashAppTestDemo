//
//  DetailImageDB.swift
//  UnsplashTestProject
//
//  Created by NODIR KARIMOV on 19/01/22.
//

import UIKit
import RealmSwift

class ImageDB: Object {
    @objc dynamic var imageView: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var location: String = ""
}
