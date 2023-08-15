//
//  ViewController.swift
//  Note-App
//
//  Created by Louise on 15/8/2023.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //initaization
    @IBOutlet weak var notesTabelView: UITableView!
    var notesArray = [Note]()
    
    //segue data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddNoteViewController
        //pass the note and tells the view controller to update instead of add
        if segue.identifier == "updateNoteSegue"{ //if clicking the add note button
            vc.note = notesArray[notesTabelView.indexPathForSelectedRow!.row] //if chicking the first item, show the first note, second appear second etc
            vc.update = true
        }
    }
    
    
    
    
    //lifecycle hooks
    
    override func viewWillAppear(_ animated: Bool) {
        //update the notes array by keep fetching
        APIFunction.function.fetchNotes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //update the notes array by keep fetching
        APIFunction.function.fetchNotes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIFunction.function.delegate = self //let APIFunction kow the updateArray function will be handled by ViewController
        APIFunction.function.fetchNotes()
        
        
        notesTabelView.delegate = self
        notesTabelView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    // TableView delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath) as! NotePrototypeCell //let it be noteprototypecell, its use for make the cell looks pretty
        cell.title.text = notesArray[indexPath.row].title
        cell.note.text = notesArray[indexPath.row].note
        cell.date.text = notesArray[indexPath.row].date
        
        //cell.textLabel?.text = notesArray[indexPath.row].title // show note title
        // cell.textLabel?.text = notesArray[indexPath.row]
        return cell
    }
    
    
    
}

// custom dewlwgates
protocol DataDelegate{
    func updateArray(newArray: String)
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
