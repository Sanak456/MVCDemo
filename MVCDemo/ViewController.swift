//
//  ViewController.swift
//  MVCDemo
//
//  Created by Sanak Ghosh on 4/25/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var dataModel = [DataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func callAPI() {
        AF.request(URL(string: "https://jsonplaceholder.typicode.com/posts")!, method: .get , parameters: nil).responseJSON { response in
            
            if let responseData = response.data {
                do{
                    let decodeJson = JSONDecoder()
                    decodeJson.keyDecodingStrategy = .convertFromSnakeCase
                    self.dataModel = try decodeJson.decode([DataModel].self, from: responseData)
                    self.tableView.reloadData()
                    
                }
                catch{
                    print(error.localizedDescription)
                }
                
            }
        }
            
        
    }
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        cell.textLabel?.text = String(dataModel[indexPath.row].id ?? 0)
        cell.detailTextLabel?.text = dataModel[indexPath.row].title
        
        return cell
    }
    
    
}

