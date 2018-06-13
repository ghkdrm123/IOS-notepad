//
//  TableViewController.swift
//  Table
//
//  Created by bglee on 2017. 10.
//  Copyright © 2017년 bglee. All rights reserved.
//

import UIKit

var memoList = Array<Memo>()
var databasePath = String()

class TableViewController: UITableViewController {
    
    @IBOutlet var tvListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        let filemgr = FileManager.default
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let docsDir = dirPaths[0] as String
        
        databasePath = docsDir.appending("/test.db")
       
        if !filemgr.fileExists(atPath: databasePath){
            let contactDB = FMDatabase(path: databasePath)
            
            if contactDB.open() {
                let sql_stmt = "CREATE TABLE IF NOT EXISTS TEST (ID INTEGER PRIMARY KEY AUTOINCREMENT, TITLE TEXT, DATE TEXT, CONTENT TEXT)"
                if !contactDB.executeStatements(sql_stmt) {
                    print("Error \(contactDB.lastErrorMessage())")
                }
                
                contactDB.close()
            } else {
                print("Error \(contactDB.lastErrorMessage())")
            }
        }
        let contactDB = FMDatabase(path: databasePath)
        if contactDB.open(){
            let querySQL = "SELECT * FROM TEST"
            let result: FMResultSet? = contactDB.executeQuery(querySQL, withArgumentsIn: [])
            
            // next 메서드는 일치하는 레코드가 적어도 하나 이상인지 확인하기 위함
            while(result?.next() == true){

                let title = result?.string(forColumn: "title")
                let date = result?.string(forColumn: "date")
                let content = result?.string(forColumn: "content")

                let newMemo: Memo = Memo(title: title!, date: date!, content: content!)
                memoList.append(newMemo)
            }
            contactDB.close()
        }
    }
    
    func saveData(saveDate: Memo) {
        let contactDB = FMDatabase(path: databasePath)
        
        if contactDB.open() {
            let insertSQL = "INSERT INTO CONTACTS (name, address, phone) VALUES ('\(saveDate.title)', '\(saveDate.date)', '\(saveDate.content)')"
            
            let result = contactDB.executeUpdate(insertSQL, withArgumentsIn: [])
            
            if !result {
               
                print("Error \(contactDB.lastErrorMessage())")
            }
        } else {
            print("Error \(contactDB.lastErrorMessage())")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tvListView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memoList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
        
        cell.lblTitle.text = memoList[(indexPath as NSIndexPath).row].title
        cell.lblDate.text = memoList[(indexPath as NSIndexPath).row].date
        
        
        return cell
    }
    
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let contactDB = FMDatabase(path: databasePath)
            print(indexPath.row)
            
            if contactDB.open() {
                let insertSQL = "DELETE from TEST WHERE TITLE = '\(memoList[indexPath.row].title)'"
                
                let result = contactDB.executeUpdate(insertSQL, withArgumentsIn: [])
                
                if !result {
                    
                    print("Error \(contactDB.lastErrorMessage())")
                }
                
                contactDB.close()
            } else {
                print("Error \(contactDB.lastErrorMessage())")
            }
            memoList.remove(at: (indexPath as NSIndexPath).row)
            //itemsImageFile.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
           
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    
    // Override to support rearranging the table view.
    //    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    //        let itemToMove = items[(fromIndexPath as NSIndexPath).row]
    //        let itemImageToMove = itemsImageFile[(fromIndexPath as NSIndexPath).row]
    //        items.remove(at: (fromIndexPath as NSIndexPath).row)
    //        itemsImageFile.remove(at: (fromIndexPath as NSIndexPath).row)
    //        items.insert(itemToMove, at: (to as NSIndexPath).row)
    //        itemsImageFile.insert(itemImageToMove, at: (to as NSIndexPath).row)
    //    }
    
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgDetail" {
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            let detailView = segue.destination as! DetailViewController
            
            detailView.reciveItem(memoList[((indexPath as NSIndexPath?)?.row)!].title)
        }
    }
    

}
