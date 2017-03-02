import UIKit

enum ButtonPressed{
    case gridButtonPressed
    case listButtonPressed
}

class ListViewToGridViewVC: UIViewController {
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var viewContainingLogo: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var numberOfPhotos: UILabel!
    @IBOutlet weak var viewContainingDeleteBtn: UIView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var gridShowBtn: UIButton!
    @IBOutlet weak var listShowBtn: UIButton!
    
    let listLayout = ListViewFlowLayout()
    let gridLayout = GridViewFlowLayout()
    let image = ImagesInformation()
    var buttonPressed = ButtonPressed.gridButtonPressed
    
    var selectedCell: [IndexPath] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        
        let gridNib = UINib(nibName: "GridViewCell", bundle: nil)
        imagesCollectionView.register(gridNib, forCellWithReuseIdentifier: "GridViewCellID")
        
        let listNib = UINib(nibName: "ListViewCell", bundle: nil)
        imagesCollectionView.register(listNib, forCellWithReuseIdentifier: "ListViewCellID")
        
        self.logoImage.clipsToBounds = true
        self.logoImage.layer.cornerRadius = 50
        self.logoImage.layer.borderWidth = 2.0
        self.logoImage.layer.borderColor = UIColor.white.cgColor
        
        self.viewContainingDeleteBtn.isHidden = true
        self.deleteBtn.clipsToBounds = true
        self.viewContainingDeleteBtn.layer.cornerRadius = 45
        self.deleteBtn.layer.cornerRadius = 45
        self.deleteBtn.layer.borderWidth = 2.0
        self.deleteBtn.layer.borderColor = UIColor.white.cgColor

        viewContainingLogo.layer.cornerRadius = 50
        gridShowBtn.setTitleColor(UIColor.red, for: .normal)
        imagesCollectionView.allowsMultipleSelection = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        
        self.imagesCollectionView.collectionViewLayout.invalidateLayout()
        
        self.imagesCollectionView.setCollectionViewLayout(self.gridLayout, animated: true)
    
    }
   
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
        numberOfPhotos.text = "\(image.imageInfo.count)" + " photos"
        
        if selectedCell.contains(indexPath) {
        
            cell.contentView.backgroundColor = UIColor.red
        
        }
    }

    @IBAction func gridShowBtnPressed(_ sender: UIButton) {
        
        buttonPressed = .gridButtonPressed
        
        self.imagesCollectionView.reloadData()
        
        animateObject(self.gridLayout)
        
        gridShowBtn.setTitleColor(UIColor.red, for: .normal)
        
        listShowBtn.setTitleColor(UIColor.white, for: .normal)
    
    }
    
    
    func collectionView(_ didSelectItemAtcollectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = imagesCollectionView.cellForItem(at: indexPath)
        
        cell?.contentView.backgroundColor = UIColor.red
        
        selectedCell.append(indexPath)
        
        self.viewContainingDeleteBtn.isHidden = false

//        
//        UIView.animate(withDuration: 0.5,delay : 0.0,options : .repeat , animations: {
//            
//                        cell?.frame.origin.x += 5
//                        cell?.frame.origin.y += 5
//            
//        })

//        UIView.animate(withDuration: 1.0, animations: {
//            // animating `transform` allows us to change 2D geometry of the object
//            // like `scale`, `rotation` or `translate`
//            cell?.transform = CGAffineTransform(rotationAngle: 360.0)
//        })
//    

//        UIView.animateKeyframes(withDuration: 2.0, delay: 0.2, options: UIViewKeyframeAnimationOptions.calculationModePaced, animations: {
//            
//            // note that we've set relativeStartTime and relativeDuration to zero.
//            // Because we're using `CalculationModePaced` these values are ignored
//            // and iOS figures out values that are needed to create a smooth constant transition
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0, animations: {
//                cell?.transform = CGAffineTransform(rotationAngle: 1/3 * 115)
//            })
//            
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0, animations: {
//                cell?.transform = CGAffineTransform(rotationAngle: 2/3 * 115)
//            })
//            
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0, animations: {
//                cell?.transform = CGAffineTransform(rotationAngle: 3/3 * 115)
//            })
//            
//        }, completion: nil)
    
    
    }
    
    @IBAction func deleteBtnAction(_ sender: UIButton) {
        
        for indexPath in selectedCell.sorted(by: >) {
           
            image.imageInfo.remove(at: indexPath.item)
            
            imagesCollectionView.deleteItems(at: [indexPath])
        
        }
        
        self.viewContainingDeleteBtn.isHidden = true
        
        selectedCell = [IndexPath]()
        
        numberOfPhotos.text = "\(image.imageInfo.count)" + " photos"
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = imagesCollectionView.cellForItem(at: indexPath)
        
        selectedCell.remove(at: selectedCell.index(of: indexPath)!)
        
        cell?.contentView.backgroundColor = nil
        
        if selectedCell.count == 0 {
        
            self.viewContainingDeleteBtn.isHidden = true
        }
    }
    
    @IBAction func listShowBtnPressed(_ sender: UIButton) {
        
        buttonPressed = .listButtonPressed
        
        self.imagesCollectionView.reloadData()
        
        animateObject(self.listLayout)
        
        listShowBtn.setTitleColor(UIColor.red, for: .normal)
        
        gridShowBtn.setTitleColor(UIColor.white, for: .normal)
    
    }
}

extension ListViewToGridViewVC: UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
    
        return 1
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return image.imageInfo.count
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if buttonPressed == .gridButtonPressed {
    
            let cell1 = returnGridCell(collectionView,indexPath)
            
            return cell1
        
        } else {
            
            let cell2 = returnListCell(collectionView,indexPath)
            
            return cell2
        
        }
    }
}

extension ListViewToGridViewVC {

    func returnGridCell(_ collectionView: UICollectionView,_ indexPath: IndexPath) -> UICollectionViewCell {
     
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridViewCellID", for: indexPath) as? GridViewCell else {
        
            fatalError("Cell Not Found !")
        
        }
        
        cell.populatedData(image.imageInfo[indexPath.item] as [String:String])
        
        if selectedCell.isEmpty {
            
            cell.backgroundColor = nil
            
        } else {
            
            for index in selectedCell {
                
                if indexPath == index {
                    
                    cell.backgroundColor = UIColor.red
                    
                }
            }
        }
        
        return cell
    }

    func returnListCell(_ collectionView: UICollectionView,_ indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListViewCellID", for: indexPath) as? ListViewCell else {
        
            fatalError("Cell Not Found !")
        
        }
        
        cell.populatedData(image.imageInfo[indexPath.item] as [String:String])
        
        if selectedCell.isEmpty {
            
            cell.backgroundColor = nil
        
        } else {
            
            for index in selectedCell {
                
                if indexPath == index {
                    
                    cell.backgroundColor = UIColor.red
                
                }
            }
        }
        
        return cell
    }

    func animateObject(_ layoutObject : UICollectionViewLayout){
        
        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        
        UIView.animate(withDuration: 0.8) { () -> Void in
        
            self.imagesCollectionView.collectionViewLayout.invalidateLayout()
            
            self.imagesCollectionView.setCollectionViewLayout(layoutObject , animated: true)
        
        }
        
        DispatchQueue.main.asyncAfter(deadline: when) {
        
        }
    }
}


