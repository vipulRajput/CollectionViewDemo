//
//  ListViewToGridViewVC.swift
//  ListViewToGridView
//
//  Created by Appinventiv on 28/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

enum ButtonPressed{
    case gridButtonPressed
    case listButtonPressed
}


class ListViewToGridViewVC: UIViewController {
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var gridShowBtn: UIButton!
    @IBOutlet weak var listShowBtn: UIButton!
    
    let listLayout = ListViewFlowLayout()
    let gridLayout = GridViewFlowLayout()
    let image = ImagesInformation()
    var buttonPressed = ButtonPressed.gridButtonPressed
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        
        let gridNib = UINib(nibName: "GridViewCell", bundle: nil)
        imagesCollectionView.register(gridNib, forCellWithReuseIdentifier: "GridViewCellID")
        
        let listNib = UINib(nibName: "ListViewCell", bundle: nil)
        imagesCollectionView.register(listNib, forCellWithReuseIdentifier: "ListViewCellID")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.imagesCollectionView.setCollectionViewLayout(self.gridLayout, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func gridShowBtnPressed(_ sender: UIButton) {
        
        buttonPressed = .gridButtonPressed
        print(buttonPressed)
        self.imagesCollectionView.reloadData()
        self.imagesCollectionView.setCollectionViewLayout(self.gridLayout , animated: true)
    }
    
    @IBAction func listShowBtnPressed(_ sender: UIButton) {
        
        buttonPressed = .listButtonPressed
        self.imagesCollectionView.reloadData()
        self.imagesCollectionView.setCollectionViewLayout(self.listLayout , animated: true)
    }
}


extension ListViewToGridViewVC: UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if buttonPressed == .gridButtonPressed {
            let cell1 = returnGridCell(collectionView,indexPath)
            return cell1
        }
        else{
            let cell2 = returnListCell(collectionView,indexPath)
            return cell2
        }
    }
}

extension ListViewToGridViewVC {

    func returnGridCell(_ collectionView: UICollectionView,_ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridViewCellID", for: indexPath) as? GridViewCell else{
            fatalError("Cell Not Found !")
        }
        cell.populatedData(image.imageInfo[indexPath.item] as [String:String])
        return cell
    }

    func returnListCell(_ collectionView: UICollectionView,_ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListViewCellID", for: indexPath) as? ListViewCell else{
            fatalError("Cell Not Found !")
        }
        cell.populatedData(image.imageInfo[indexPath.item] as [String:String])
        return cell
    }
}


