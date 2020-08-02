//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Armando Carrillo on 02/08/20.
//  Copyright © 2020 Armando Carrillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var photoFromAPOD: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var CopyrightLabel: UILabel!
    
   let photoInfoController = PhotoInfoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = ""
        CopyrightLabel.text = ""
        
        photoInfoController.fetchPhotoInfo { (photoInfo) in
            if let photoInfo = photoInfo {
                self.title = photoInfo.title
                self.descriptionLabel.text = photoInfo.description
            
            if let copyright = photoInfo.copyright {
                self.CopyrightLabel.text = "Copyright \(copyright)"
            } else {
                self.CopyrightLabel.isHidden = true
            }
        }
    }


}
}
