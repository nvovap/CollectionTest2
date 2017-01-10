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
    var submenu: Array<Dictionary<String, String>>
    
}


class CollectionViewController: UICollectionViewController {
    
    
    

    var aMenu: [ItemMenu] = [ItemMenu]()
    
    
    private let openImage = UIImage(named: "open")!
    
    private var selectIndexPath: IndexPath?
    private var actionsView: UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path = Bundle.main.path(forResource: "Menu", ofType: "plist")
        let tempMenu = NSArray(contentsOfFile: path!) as! Array<Dictionary<String, Any>>
        
        
        for currentDict in tempMenu {
            
            if let currentName = currentDict["name"] as? String, let submenu = currentDict["submenu"] as? Array<Dictionary<String, String>> {
                if let image = UIImage(named: currentName) {
                    
                    let item = ItemMenu(image: image, name: currentName, selected: false, submenu: submenu)
                    
                    aMenu.append(item)
                    
                }
                
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
            
            if let actionsView = actionsView {
                actionsView.removeFromSuperview()
            }
            
            
            if let oldCell  = collectionView.cellForItem(at: oldIndex) as? CollectionViewCellIcon {
                oldCell.opened.image = nil
            }
            
            if oldIndex.row == indexPath.row {
                selectIndexPath = nil
                actionsView = nil
                return
            }
        }
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCellIcon else {
            return
        }
        
        
        cell.opened.image = openImage
        var currentMenu = aMenu[indexPath.row]
            
        currentMenu.selected = true
        selectIndexPath = indexPath
        
        
        let positionY: Int = Int(cell.frame.maxY)
        
        actionsView = UIView(frame: CGRect(x: 0, y: positionY, width: Int(self.view.frame.width), height: 10 + currentMenu.submenu.count * 40))
        
        if let actionsView = actionsView {
            actionsView.backgroundColor = UIColor.white
            
            print(actionsView.frame)
            
            var currentPositionY = 10
            
            for currentSubmenu in currentMenu.submenu {
                
                if let name = currentSubmenu["name"], let type = currentSubmenu["type"] {
                    let newButton = MyButton(frame: CGRect(x: 20, y: currentPositionY, width: Int(self.view.frame.width-40), height: 30))
                    
                    currentPositionY += 40
                    
                    newButton.setTitle(name, for: .normal)
                    newButton.tag = Int(type) ?? 0
                    newButton.backgroundColor = UIColor.black
                    
                    actionsView.addSubview(newButton)
                    newButton.awakeFromNib()
                    
                }
                
               
                
            }
            
            self.view.addSubview(actionsView)
            
        }
        
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
