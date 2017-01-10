//
//  CollectionViewController.swift
//  CollectionTest2
//
//  Created by Vladimir Nevinniy on 1/10/17.
//  Copyright © 2017 Vladimir Nevinniy. All rights reserved.
//

import UIKit

private let reuseIdentifier = "iconCell"



struct ItemMenu {
    var image: UIImage
    var name: String
    var selected: Bool
}


class CollectionViewController: UICollectionViewController {
    
    
    

    var aMenu: [ItemMenu] = [ItemMenu]()
    
    
    private let openImage = UIImage(named: "open")!
    
    private var selectIndexPath: IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path = Bundle.main.path(forResource: "Menu", ofType: "plist")
        let tempMenu = NSArray(contentsOfFile: path!) as! Array<String>
        
        
        for currentName in tempMenu {
            if let image = UIImage(named: currentName) {
                
                let item = ItemMenu(image: image, name: currentName, selected: false)
                
                aMenu.append(item)
    
            }
        }
        
        
      
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
       // self.collectionView!.register(CollectionViewCellIcon.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return aMenu.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCellIcon
    
        let currentItem = aMenu[indexPath.row]
        
        cell.icon.image = currentItem.image
        
        if currentItem.selected {
            cell.opened.image = openImage
            selectIndexPath = indexPath
        }
        
    
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let oldIndex = selectIndexPath {
            aMenu[oldIndex.row].selected = false
            if let oldCell  = collectionView.cellForItem(at: oldIndex) as? CollectionViewCellIcon {
                oldCell.opened.image = nil
            }
        }
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCellIcon else {
            return
        }
        
        
        cell.opened.image = openImage
        aMenu[indexPath.row].selected = true
        selectIndexPath = indexPath
        

        
        let actions = UIView(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        
        actions.backgroundColor = UIColor.white
        
        
        let newButton = UIButton(frame: CGRect(x: 0, y: 10, width: 100, height: 10))
        
        newButton.setTitle("Test", for: .normal)
        newButton.backgroundColor = UIColor.black
        
        actions.addSubview(newButton)
        
        self.view.addSubview(actions)
        
        
        
//        let allert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
//        
//        allert.view.backgroundColor = UIColor.white
//       
//        
//        let action = UIAlertAction(title: "Test", style: UIAlertActionStyle.default) { (alertAction) in
//            print(alertAction.title ?? "")
//        }
//        
//        
//        allert.addAction(action)
//        
//        
//        print(allert.view.frame)
//        
//        
//        self.present(allert, animated: true, completion: nil)
        
        
      //  collectionView.reloadData()
        
        
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
