//
//  TableViewController.swift
//  Table
//
//  Created by bglee on 2017. 10.
//  Copyright © 2017년 bglee. All rights reserved.
//

import UIKit

var memoList = Array<Memo>()

class TableViewController: UITableViewController {
    
    @IBOutlet var tvListView: UITableView!
    
    var databasePath = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        //        let fileMgr = FileManager.default
        //        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        //        //let dirPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)[0]
        //
        //        //let docsDir = dirPath[0]
        //
        //
        //
        //        //databasePath = docsDir.appending("/contacts.db")
        //        databasePath = dirPath.appendingPathComponent("contracts.db").path!
        //        print(databasePath)
        //
        //        if !fileMgr.fileExists(atPath: databasePath) {
        //            // DB 접속
        //            let contactDB = FMDatabase(path: databasePath)
        //
        //            if contactDB.open() {
        //                let sql_stmt = "CREATE TABLE IF NOT EXISTS CONTACTS ( ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, AGE INTEGER )"
        //                if !contactDB.executeStatements(sql_stmt){
        //                    print("Error : contactDB execute Fail, \(contactDB.lastError())")
        //                }
        //                contactDB.close()
        //
        //            } else {
        //                print("Error : contactDB open Fail, \(contactDB.lastError())")
        //            }
        //        } else {
        //            print("contactDB is exist")
        //        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.text = memoList[(indexPath as NSIndexPath).row].title
        //cell.imageView?.image = UIImage(named: itemsImageFile[(indexPath as NSIndexPath).row])
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
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
            print(((indexPath as NSIndexPath?)?.row)!)
            detailView.reciveItem(((indexPath as NSIndexPath?)?.row)!)
        }
    }
    
}
