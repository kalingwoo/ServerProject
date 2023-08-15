//
//  ViewController.swift
//  Note-App
//
//  Created by Louise on 15/8/2023.
//

import UIKit

protocol DataDelegate{
    func updateArray(newArray: String)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var notesArray = [Note]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath)
        cell.textLabel?.text = notesArray[indexPath.row].title // show note title
       // cell.textLabel?.text = notesArray[indexPath.row]
        return cell
    }
    
    @IBOutlet weak var notesTabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIFunction.function.delegate = self //let APIFunction kow the updateArray function will be handled by ViewController
        APIFunction.function.fetchNotes()
       
        
        notesTabelView.delegate = self
        notesTabelView.dataSource = self
        // Do any additional setup after loading the view.
    }


}

extension ViewController: DataDelegate {
    
    
    func updateArray(newArray: String){
        do{
            notesArray = try JSONDecoder().decode([Note].self, from: newArray.data(using: .utf8)!)
            
        }catch{
            print("Failed to decode")
        }
        self.notesTabelView?.reloadData() //always reload the data if there are any changes
        
    }
    
}
