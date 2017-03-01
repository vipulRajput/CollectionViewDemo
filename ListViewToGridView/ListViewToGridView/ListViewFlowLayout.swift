//
//  ListViewFlowLayout.swift
//  ListViewToGridView
//
//  Created by Appinventiv on 01/03/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class ListViewFlowLayout: UICollectionViewFlowLayout {

    let itemHeight: CGFloat = 120
    
    
    func itemWidth() -> CGFloat {
        print("ProductsListFlowLayout width")
        return collectionView!.frame.width
    }
    
    override var itemSize: CGSize {
        set {
            print("ProductsListFlowLayout set")
            self.itemSize = CGSize(width: itemWidth(),height: itemHeight)
        }
        get {
            print("ProductsListFlowLayout get")
            return CGSize(width: itemWidth(),height: itemHeight)
        }
    }
}
