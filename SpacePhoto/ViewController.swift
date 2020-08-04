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
        //update descriptionLabel and copyrightLabel
        photoInfoController.fetchPhotoInfo { (photoInfo) in
            if let photoInfo = photoInfo {
                self.updateUI(with: photoInfo)
                
            }
        }
     }
    
    func updateUI(with photoInfo: PhotoInfo) {
        guard let url = photoInfo.url.withHTTPS() else {return}
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data){
                DispatchQueue.main.async {
                    self.title = photoInfo.title
                    self.photoFromAPOD.image = image
                    self.descriptionLabel.text = photoInfo.description
                    
                    if let copyright = photoInfo.copyright {
                        self.CopyrightLabel.text = "Copyright: \(copyright)"
                    } else {
                        self.CopyrightLabel.isHidden = true
                    }
                }
            }
        })
        task.resume()
    }
}
