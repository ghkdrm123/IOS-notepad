//
//  ViewController.swift
//  FinalProject
//
//  Created by admin16 on 2018. 6. 7..
//  Copyright © 2018년 admin16. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AddDelegate {
    
    
    
    func sendMemo(controller: AddController, message: Memo) {
        print(message.content)
        print(message.date)
        print(message.title)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addController = segue.destination as! AddController
        addController.delegate = self
    }
    
}

