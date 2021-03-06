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
        if (tfAddItem.text == ""){
            tfAddItem.text = "제목없는 문서"
        }
        
        let today = NSDate() //현재 시각 구하기
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var dateString = dateFormatter.string(from: today as Date)
        
        
        var newMemo: Memo = Memo(title: tfAddItem.text!, date: dateString, content: AddContent.text!)
        memoList.append(newMemo)
        tfAddItem.text=""
        
        let contactDB = FMDatabase(path: databasePath)
        
        if contactDB.open() {
            let insertSQL = "INSERT INTO TEST (title, date, content) VALUES ('\(newMemo.title)', '\(newMemo.date)', '\(newMemo.content)')"
            
            let result = contactDB.executeUpdate(insertSQL, withArgumentsIn: [])
            
            if !result {
                
                print("Error \(contactDB.lastErrorMessage())")
            }
            print("succes")
            
            contactDB.close()
        } else {
            print("Error \(contactDB.lastErrorMessage())")
        }
        
        _ = navigationController?.popViewController(animated: true)
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


