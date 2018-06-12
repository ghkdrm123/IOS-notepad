//
//  AddViewController.swift
//  Table
//
//  Created by bglee on 2017. 10.
//  Copyright © 2017년 bglee. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet var tfAddItem: UITextField!
    @IBOutlet var AddContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save_Btn(_ sender: UIBarButtonItem) {
        var newMemo: Memo = Memo(title: tfAddItem.text!, date: "123", content: AddContent.text!)
        memoList.append(newMemo)
        //itemsImageFile.append("clock.png")
        tfAddItem.text=""
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func btnAddItem(_ sender: UIButton) {
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


