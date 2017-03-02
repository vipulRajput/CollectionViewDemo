//
//  ListViewFlowLayout.swift
//  ListViewToGridView
//
//  Created by Appinventiv on 01/03/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class ListViewFlowLayout: UICollectionViewFlowLayout {

    let itemHeight: CGFloat = 147
    
    
    func itemWidth() -> CGFloat {
   
        return collectionView!.frame.width
    }
    override init() {
        
        super.init()
        
        setupLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        
        minimumInteritemSpacing = 0
        
        minimumLineSpacing = 1
        
        scrollDirection = .vertical
        
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth(),height: itemHeight)
        }
        get {
            return CGSize(width: itemWidth(),height: itemHeight)
        }
    }
}
