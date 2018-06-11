//
//  memo.swift
//  FinalProject
//
//  Created by admin16 on 2018. 6. 12..
//  Copyright © 2018년 admin16. All rights reserved.
//
import Foundation

class Memo: NSObject {
    var title: String
    var date: String
    var content: String
    
    init(title: String, date: String, content: String) {
        self.title = title
        self.date = date
        self.content = content
        
        super.init()
    }
    
}
