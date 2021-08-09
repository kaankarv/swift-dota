//
//  HeroViewController.swift
//  dotaKarakter
//
//  Created by Kaan Karvan on 3.08.2021.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL , contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class HeroViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var attributeLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    
    
    var hero:HeroStats!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text=hero?.localized_name
        attackLabel.text = hero?.localized_name
        attributeLabel.text=hero?.primary_attr
        
        
       let urlString = "https://api.opendota.com" + (hero!.img)
       let url = URL(string: urlString)
        
        imageView.downloaded(from: url!)
       
        

        // Do any additional setup after loading the view.
    }

}
