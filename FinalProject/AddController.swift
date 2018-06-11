//
//  addController.swift
//  FinalProject
//
//  Created by admin16 on 2018. 6. 11..
//  Copyright © 2018년 admin16. All rights reserved.
//

import UIKit
import Foundation

protocol AddDelegate {
    func sendMemo(controller: AddController, message: Memo)
}

class AddController: UIViewController {
    @IBOutlet var memoTitle: UITextField!
    @IBOutlet var memoContent: UITextView!
    
    let now = NSData()
    var delegate:AddDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBAction func save_btn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        var newMemo: Memo = Memo(title: memoTitle.text!, date: "123", content: memoContent.text)
        
        
        if delegate != nil{
            delegate?.sendMemo(controller: self, message: newMemo)
        }
        
    }
}
