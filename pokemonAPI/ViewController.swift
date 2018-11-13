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
                var typeOne: String
                var typeTwo: String
                
                typeOne = (json["types"].arrayValue)[0]["type"]["name"].string!
                
                
                switch typeOne {
                case "normal":
                    self.view.backgroundColor = UIColor(displayP3Red: 156/255, green: 155/255, blue: 106/255, alpha: 1)
                case "water":
                    self.view.backgroundColor = UIColor(displayP3Red: 78/255, green: 121/255, blue: 229/255, alpha: 1)
                case "fire":
                    self.view.backgroundColor = UIColor(displayP3Red: 222/255, green: 116/255, blue: 49/255, alpha: 1)
                case "electric":
                    self.view.backgroundColor = UIColor(displayP3Red: 240/255, green: 202/255, blue: 72/255, alpha: 1)
                case "grass":
                    self.view.backgroundColor = UIColor(displayP3Red: 127/255, green: 191/255, blue: 82/255, alpha: 1)
                case "steel":
                    self.view.backgroundColor = UIColor(displayP3Red: 160/255, green: 160/255, blue: 189/255, alpha: 1)
                case "psychic":
                    self.view.backgroundColor = UIColor(displayP3Red: 228/255, green: 73/255, blue: 113/255, alpha: 1)
                case "flying":
                    self.view.backgroundColor = UIColor(displayP3Red: 136/255, green: 115/255, blue: 228/255, alpha: 1)
                case "ice":
                    self.view.backgroundColor = UIColor(displayP3Red: 144/255, green: 204/255, blue: 205/255, alpha: 1)
                case "fighting":
                    self.view.backgroundColor =  UIColor(displayP3Red: 161/255, green: 53/255, blue: 44/255, alpha: 1)
                case "ghost":
                    self.view.backgroundColor = UIColor(displayP3Red: 96/255, green: 80/255, blue: 32/255, alpha: 1)
                case "ground":
                    self.view.backgroundColor = UIColor(displayP3Red: 214/255, green: 182/255, blue: 95/255, alpha: 1)
                case "dark":
                    self.view.backgroundColor =  UIColor(displayP3Red: 97/255, green: 79/255, blue: 66/255, alpha: 1)
                case "poison":
                    self.view.backgroundColor = UIColor(displayP3Red: 135/255, green: 65/255, blue: 142/255, alpha: 1)
                case "bug":
                    self.view.backgroundColor = UIColor(displayP3Red: 172/255, green: 183/255, blue: 66/255, alpha: 1)
                case "rock":
                    self.view.backgroundColor =  UIColor(displayP3Red: 161/255, green: 143/255, blue: 67/255, alpha: 1)
                case "dragon":
                    self.view.backgroundColor = UIColor(displayP3Red: 83/255, green: 46/255, blue: 237/255, alpha: 1)
                case "fairy":
                    self.view.backgroundColor = UIColor(displayP3Red: 218/255, green: 126/255, blue: 145/255, alpha: 1)
                default:
                    self.view.backgroundColor = .white
                }
                
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

