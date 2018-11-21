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
import RxAlamofire
import VBFramework

class ExampleViewController: ViewController {
    
    //-------------------------------------------------------------------------------------------------------------
    // MARK: Properties
    //-------------------------------------------------------------------------------------------------------------
    // Views
    @IBOutlet weak var tbvIssues: UITableView!
    @IBOutlet weak var sbarIssues: UISearchBar!
    @IBOutlet weak var viewExample: VBContainerView!
    
    
    //-------------------------------------------------------------------------------------------------------------
    // MARK: Lifecycle
    //-------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Calling setups...
        self.setupData()
        self.setupLayout()
    }
    
    
    //-------------------------------------------------------------------------------------------------------------
    // MARK: Setup
    //-------------------------------------------------------------------------------------------------------------
    func setupData() {
        let url = URL.init(string: "https://jsonplaceholder.typicode.com/todos/1")
        
        // MARK: URLSession simple and fast
//        let session = URLSession.shared
//
//        _ = session.rx
//            .json(url: url!)
//            .observeOn(MainScheduler.instance)
//            .subscribe { print($0) }
//
//        // validation
//        _ = request(.get, url!)
//            .validate(statusCode: 200..<300)
//            .validate(contentType: ["application/json"])
//            .responseJSON()
//            .observeOn(MainScheduler.instance)
//            .subscribe { print($0) }
        
        RxAlamofire.requestJSON(.get, url!)
            .debug()
            .subscribe(onNext: { [weak weakSelf=self] (r, json) in
                
                // Tratando o sucesso
                if let dict = json as? [String: AnyObject] {
                    let titulo = dict["title"] as! String
                    weakSelf?.exibeSucesso(titulo)
                }
                
                }, onError: { [weak weakSelf=self] (error) in
                    weakSelf?.exibeErro()
            })
            .disposed(by: disposeBag)
    }
    
    func setupLayout() {
        self.viewExample.maskedCorners = .layerMaxXMinYCorner
    }
    
    func setupText() {
        
    }
    
    
    //-------------------------------------------------------------------------------------------------------------
    // MARK: Aux
    //-------------------------------------------------------------------------------------------------------------
    private func exibeErro() {
        print("Ocorreu um erro ao tentar realizar a requisição...")
    }
    
    private func exibeSucesso(_ titulo: String) {
        print("Sucesso ao fazer a requisição. Titulo: \(titulo)")
    }
}



