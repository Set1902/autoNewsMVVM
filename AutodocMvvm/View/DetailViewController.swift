//
//  DetailViewController.swift
//  AutodocMvvm
//
//  Created by Sergei Kovalev on 17.08.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var Name: UILabel!
    
    @IBOutlet weak var Image: UIImageView!
    
    @IBOutlet weak var Descr: UILabel!
    
    
     var news = News()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            Name.text = news.title!
            Descr.text = news.newsDescription!
        
        uploadImage(with: news.titleImageURL!)
            
            
            
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func uploadImage(with image: String) {
        guard let imageURL = URL(string: image) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.Image.image = image
            }
        }
    }

}

