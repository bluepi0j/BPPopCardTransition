//
//  ViewController.swift
//  Example
//
//  Created by Vic on 2017-08-12.
//  Copyright © 2017 bluepi0j. All rights reserved.
//

import UIKit
import BPPopCardTransition

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, BPPopCardAnimtionDelegate {

    @IBOutlet var collectionView: UICollectionView!
    
    var selectedCellFrame: CGRect?
    
    var selectedCellImageView: UIImageView?
    
    let transitionDelegate:BPPopCardTransitionsDelegate = BPPopCardTransitionsDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        // rounded corner
        cell.contentView.layer.cornerRadius = 8.0
        cell.contentView.layer.masksToBounds = true
        
        // add rounded corner shadow
        cell.layer.cornerRadius = 8.0
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowOffset = CGSize(width: 0.4, height: 1.0)
        
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell: ImageCollectionViewCell = collectionView.cellForItem(at: indexPath)! as! ImageCollectionViewCell
        
        selectedCellFrame = collectionView.convert(cell.frame, to: self.view)
        selectedCellImageView = cell.cellImageView

        
        let popCardViewController: PopCardViewController = self.storyboard?.instantiateViewController(withIdentifier: "PopCardViewController") as! PopCardViewController
        
        transitionDelegate.delegate = self
        
        popCardViewController.transitioningDelegate = transitionDelegate
        popCardViewController.bannerImage = self.selectedCellImageView!.image
        popCardViewController.modalPresentationStyle = .custom
        self.present(popCardViewController, animated: true, completion: nil)
        
    }
    
    func rectZoomPosition() -> CGRect {
        return selectedCellFrame!
    }
    
    func cellImageView() -> UIImageView {
        return selectedCellImageView!
    }

}







