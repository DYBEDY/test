//
//  ViewController.swift
//  MyFirstJSON
//
//  Created by Roman on 17.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var newImage: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getJson()
        
    }

    func getJson() {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "NO error")
                return
            }
            
            do {
                let wiki = try JSONDecoder().decode(DogsAPI.self, from: data)
                print(wiki)
            } catch {
                print(error.localizedDescription)
            }
            guard let image = UIImage(data: data) else { return }
            self.newImage.image = image
            
           
        } .resume()
    }
}

