//
//  ExampleViewController.swift
//  example-rxswift
//
//  Created by Victor Baleeiro on 22/11/17.
//  Copyright © 2017 Victor Baleeiro. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ExampleViewController: ViewController {
    
    //-------------------------------------------------------------------------------------------------------------
    // MARK: Properties
    //-------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var lblCombine: UILabel!
    
    
    //-------------------------------------------------------------------------------------------------------------
    // MARK: Lifecycle
    //-------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Calling setups...
        self.setupData()
    }
    
    
    //-------------------------------------------------------------------------------------------------------------
    // MARK: Setup
    //-------------------------------------------------------------------------------------------------------------
    func setupData() {
        
        //Delegate
        txtFirstName.delegate = self
        txtLastName.delegate = self
        
        //Reative
        Observable.combineLatest(txtFirstName.rx.text, txtLastName.rx.text) {
            text1, text2 -> String in
            return text1! + " " + text2!
            }
            .map { "Complete name: \(self.checkLabelCharLimits(str: $0.description))" }
            .bind(to: lblCombine.rx.text)
            .disposed(by: disposeBag)
    }
    
    func setupLayout() {
        
    }
    
    func setupText() {
        
    }
    
    
    //-------------------------------------------------------------------------------------------------------------
    // MARK: Aux
    //-------------------------------------------------------------------------------------------------------------
    func checkLabelCharLimits(str: String) -> String {
        return (str.count > 10) ? (str[..<str.index(str.startIndex, offsetBy: 9)] + "...") : str
    }
}

extension ExampleViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
