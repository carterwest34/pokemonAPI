//
//  ViewController.swift
//  pokemonAPI
//
//  Created by Carter West on 11/12/18.
//  Copyright © 2018 Carter West. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var pokemonLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    //setting up base url to be added to for call
    let pokemonAPIBaseUrl = "https://pokeapi.co/api/v2/pokemon/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        textField.resignFirstResponder()
        
        guard
            let pokemonTextField = textField.text, !pokemonTextField.isEmpty else {return}
        
        //clear out text field upon button press
        textField.text = ""
        
        let pokemonNameComponent = pokemonTextField.replacingOccurrences(of: " ", with: "+")
        
        
        let nameRequestURL = pokemonAPIBaseUrl + pokemonNameComponent
       
        
        
        
        Alamofire.request(nameRequestURL).responseJSON { (resonse) in
            switch resonse.result {
            case .success(let value):
                let json = JSON(value)
                self.pokemonLabel.text = json["name"].stringValue
                let pokemonID = json["id"].int
                let imageRequestURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(String(pokemonID!)).png")
                if let url = imageRequestURL{
                    self.imageView.sd_setImage(with: url)
                } else {
                    let alertController = UIAlertController(title: "Pokemon Not Found", message: "Try Again.", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Ok.", style: .default)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                let pokemonType = json[""].string
            case .failure(let error):
                self.pokemonLabel.text = "Invalid selection entered or error occured. Please try again."
                let alertController = UIAlertController(title: "Pokemon Not Found", message: "Try Again.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok.", style: .default)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
                print(error.localizedDescription)
            }
        }
    }
}

