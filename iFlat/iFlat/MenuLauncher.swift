//
//  MenuLauncher.swift
//  iFlat
//
//  Created by Tolga Taner on 19.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit



class MenuLauncher:NSObject {
    
    
        let blackView = UIView()
        
        let menu : [Menu] = {
            
            
            return [Menu(name:.Logout)]
            
        }()
        
        
        let menuCollectionView : UICollectionView = {
            
            let layout = UICollectionViewLayout()
            
            
            var flow = UICollectionViewFlowLayout()
            
            flow.itemSize = CGSize(width: 60, height: 10)
            
            let cv = UICollectionView(frame: .zero, collectionViewLayout: flow)
            
            
            cv.backgroundColor = UIColor.white
            
            cv.isPagingEnabled = true
            return cv
            
        }()
        
        
        
        func openMenu() {
            
            if let window = UIApplication.shared.keyWindow {
                
                
                
                blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
                
                blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
                
                window.addSubview(blackView)
                window.addSubview(menuCollectionView)
                
                menuCollectionView.frame = CGRect(x: 0,y: 200, width: Int(window.frame.width), height: Int(window.frame.height))
          
                
                blackView.frame = window.frame
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    
                    self.blackView.alpha = 1
                    
                    self.menuCollectionView.frame = CGRect(x: 0,y: window.frame.height-50, width:self.menuCollectionView.frame.width, height: self.menuCollectionView.frame.height)
                    
                    
                }, completion: nil)
            }
            
    }
        func handleDismiss()  {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 0
                
             self.menuCollectionView.removeFromSuperview()
                
            }
            )
            
        }
        
        
    
    
    
        
        override init(){
            super.init()
            menuCollectionView.dataSource = self
            menuCollectionView.delegate = self
            menuCollectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.cellId)
            
            
        }
        
        
    }
    
    
    extension MenuLauncher : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            self.handleDismiss()
            
            
            
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return menu.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            
            if let cell :MenuCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.cellId, for: indexPath) as? MenuCollectionViewCell {
                
                cell.settingsLabel.text = menu[indexPath.row].name.rawValue
                    return cell
            }
                
            else {
                return UICollectionViewCell()
                
            }
            
        }
        
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width:collectionView.frame.width, height:50)
        }
        
        
        
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        
        
    }

