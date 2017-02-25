//
//  CollectionViewDemoVC.swift
//  CollectionViewDemo
//
//  Created by Appinventiv on 22/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class CollectionViewDemoVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var AudiLogo: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var imageArray = ["i1","i2","i3","i4","i5","i6","i7","i8","i9",
                      "i10","i11","i12","i13","i14","i15","i16","i17","i18",
                      "i19","i20"]
    var selectedImageArrayIndex: [Int] = []
    var selectedCell: [IndexPath] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        self.AudiLogo.clipsToBounds = true
        self.AudiLogo.layer.cornerRadius = 45
        self.deleteButton.isHidden = true
        collectionView.allowsMultipleSelection = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstID", for: indexPath) as! AudiView
        cell.image.backgroundColor = UIColor(patternImage: UIImage(named: imageArray[indexPath.row])!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if selectedCell.contains(indexPath){
            cell.contentView.backgroundColor = UIColor.red
            print(index)
            print("checking cell", cell)
            print(selectedCell)
        }
    }
    
    func collectionView(_ didSelectItemAtcollectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = UIColor.red
            selectedCell.append(indexPath)
            selectedImageArrayIndex.append(indexPath.row)
            print("on selected", selectedCell)
            self.deleteButton.isHidden = false
        } else {
            
        }
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
      
        selectedCell = selectedCell.sorted(by: <)
        selectedImageArrayIndex = selectedImageArrayIndex.sorted(by: >)
        print(selectedImageArrayIndex)
        for index in selectedImageArrayIndex{
            imageArray.remove(at: index)
        }
        
        self.collectionView.deleteItems(at: selectedCell)
        selectedCell.removeAll()
        selectedImageArrayIndex.removeAll()
        self.deleteButton.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        if selectedCell.contains(indexPath){
            cell!.contentView.backgroundColor = nil
            let temp = selectedCell.remove(at: selectedCell.index(of: indexPath)!)
            
            var temp1 = 0
            let targetRow = indexPath.row
            print(selectedImageArrayIndex)
            for i in 0..<selectedImageArrayIndex.count {
                if targetRow == selectedImageArrayIndex[i] {
                    temp1 = i
                }
            }
            print("de-seleted",temp)
            selectedImageArrayIndex.remove(at: temp1)
            
            print(selectedImageArrayIndex)
        }
        if selectedCell.count == 0 {
            self.deleteButton.isHidden = true
        }
    }
}

class AudiView: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.backgroundColor = nil
    }
    
    
}
