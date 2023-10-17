//
//  AsyncViewController.swift
//  SeSACWeek4
//
//  Created by 고은서 on 2023/10/30.
//

import UIKit

class AsyncViewController: UIViewController {
    
    @IBOutlet var firstImage: UIImageView!
    @IBOutlet var secondImage: UIImageView!
    @IBOutlet var thirdImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstImage.backgroundColor = .black
        
        DispatchQueue.main.async {
            self.firstImage.layer.cornerRadius = self.firstImage.frame.width / 2
        }
        
        
    }
    
    // sync async serial concurrent
    // UI Freezing
    
    @IBAction func buttonCliked(_ sender: UIButton) {
        
        let url = URL(string: "https://science.nasa.gov/_ipx/w_1536&f_webp/https://smd-cms.nasa.gov/wp-content/uploads/2023/10/veil-nebula-potw2113a.webp%3Fw=2000")!
        
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            
            DispatchQueue.main.async {
                self.firstImage.image = UIImage(data: data)
            }
        }
        
        
    }
}
