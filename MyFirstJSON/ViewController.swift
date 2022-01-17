//
//  ViewController.swift
//  MyFirstJSON
//
//  Created by Roman on 17.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var newImage: UIImageView!
    
    var dog: DogsAPI!
    
    
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
                self.dog = try JSONDecoder().decode(DogsAPI.self, from: data)
                print(self.dog.message ?? "")
            } catch {
                print(error.localizedDescription)
            }
            
            DispatchQueue.global().async {
                guard let url = URL(string: self.dog.message ?? "") else { return }
                guard let imageData = try? Data(contentsOf: url) else { return }
                
                DispatchQueue.main.async {
                    self.newImage.image = UIImage(data: imageData)
                }
                
            }
        } .resume()
    }
    
}
