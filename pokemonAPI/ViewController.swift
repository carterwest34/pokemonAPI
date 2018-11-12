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

class ViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    //setting up base url to be added to for call
    let pokemonAPIBaseUrl = "https://pokeapi.co/v2/"
    
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
        
        let pokemonNameComponent = pokemonTextField.replacingOccurrences(of: "", with: "+")
        
        let requestURL = pokemonAPIBaseUrl + pokemonNameComponent
        
    }
    

}

