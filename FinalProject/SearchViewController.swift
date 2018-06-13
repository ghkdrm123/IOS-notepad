//
//  SearchViewController.swift
//  FinalProject
//
//  Created by admin16 on 2018. 6. 13..
//  Copyright © 2018년 admin16. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
    @IBOutlet var searchlbl: UITextField!
    @IBOutlet var searchTable: UITableView!
    var searchlist = Array<Memo>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searCell", for: indexPath) as! MySearchTableCell
        
        cell.lblTitle.text = searchlist[(indexPath as NSIndexPath).row].title
        cell.lblDate.text = searchlist[(indexPath as NSIndexPath).row].date
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchlist.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func viewWillAppear(_ animated: Bool) {
        searchTable.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
     
    */
    @IBAction func searchBtn(_ sender: Any) {

        
        let contactDB = FMDatabase(path: databasePath)
        if contactDB.open(){
            var str = searchlbl.text!
            
            let querySQL = "SELECT * FROM TEST WHERE TITLE = '\(str)'"
            let result: FMResultSet? = contactDB.executeQuery(querySQL, withArgumentsIn: [])
            
            // next 메서드는 일치하는 레코드가 적어도 하나 이상인지 확인하기 위함
            while(result?.next() == true){
                print("while")
                
                let title = result?.string(forColumn: "title")
                let date = result?.string(forColumn: "date")
                let content = result?.string(forColumn: "content")
                
                let newMemo: Memo = Memo(title: title!, date: date!, content: content!)
                searchlist.append(newMemo)
                print("here1")
                let index = searchlist.index(of: newMemo)
                let inserIndexPath=IndexPath(item: index!, section: 0)
                searchTable.insertRows(at: [inserIndexPath], with: .automatic)
                
            }

            print(searchlist.count)
            contactDB.close()
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print(segue.identifier)
        if segue.identifier == "searchDetail" {
            let cell = sender as! UITableViewCell
            let indexPath = self.searchTable.indexPath(for: cell)
            let detailView = segue.destination as! DetailViewController
           
            print(searchlist[((indexPath as NSIndexPath?)?.row)!].title)
            detailView.reciveItem(searchlist[((indexPath as NSIndexPath?)?.row)!].title)
            
        }
    }
    
    
}
