//
//  GridViewFlowLayout.swift
//  ListViewToGridView
//
//  Created by Appinventiv on 01/03/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class GridViewFlowLayout: UICollectionViewFlowLayout {
    
    let itemHeight: CGFloat = 120
    
    override init() {
        
        super.init()
        
        setupLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        setupLayout()
        
        print("ProductsListFlowLayout INIT")
        
    }
    
    func setupLayout() {
        
        minimumInteritemSpacing = 0
        
        minimumLineSpacing = 1
        
        scrollDirection = .vertical
        
        print("ProductsListFlowLayout setupLaout")
    
    }
    
    func itemWidth() -> CGFloat {
        
        print("ProductsListFlowLayout width")
    
        return (collectionView!.frame.width / 2) - 20
    
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
