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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell: ImageCollectionViewCell = collectionView.cellForItem(at: indexPath)! as! ImageCollectionViewCell
        
        selectedCellFrame = collectionView.convert(cell.frame, to: self.view)
        selectedCellImageView = cell.cellImageView
        
        
        let popCardViewController: PopCardViewController = self.storyboard?.instantiateViewController(withIdentifier: "PopCardViewController") as! PopCardViewController
        
        let delegate:BPPopCardTransitionsDelegate = BPPopCardTransitionsDelegate()
        
        delegate.deleagte = self
        
        popCardViewController.transitioningDelegate = delegate
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

