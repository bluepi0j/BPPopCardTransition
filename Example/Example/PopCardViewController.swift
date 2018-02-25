//
//  PopCardViewController.swift
//  Example
//
//  Created by Vic on 2017-08-12.
//  Copyright © 2017 bluepi0j. All rights reserved.
//

import UIKit
import BPPopCardTransition

class PopCardViewController: UIViewController {
    var tranDeleagte:BPPopCardTransitionsDelegate?

    @IBOutlet var bannerImageView: UIImageView!
    var bannerImage: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if bannerImage != nil {
            self.bannerImageView.image = bannerImage
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func dismissVCButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
