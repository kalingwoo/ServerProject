//
//  AddNoteViewController.swift
//  Note-App
//
//  Created by Louise on 15/8/2023.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    //initalization
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    var note: Note?
    var update = false
    
    
    
    //if click the delete button, go in the deletenote function in the API function
    @IBAction func deleteClick(_ sender: Any) {
        APIFunction.function.deleteNote(id: note!._id)
        //after clicking the delete button, quit the current page
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func saveChlick(_ sender: Any) {
        //creat a date string that we can pass in the database
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        
        // if its updateing. go to update function in the api function
        if update == true {
            APIFunction.function.updateNote(date: date, title: titleTextField.text!, note: bodyTextField.text, id: note!._id)
            self.navigationController?.popViewController(animated: true)
        }else if titleTextField.text != "" && bodyTextField.text != "" //make sure user input something
        {
            //if its new note, go to add note function in the apifunction
            APIFunction.function.AddNote(date: date, title: titleTextField.text!, note: bodyTextField.text)
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    //lifecycle hooks
    //viewWillAppear: everytime run this page, run the following code
    override func viewWillAppear(_ animated: Bool) {
        //if its a new note, disable the delete button
        if update == false{
            self.deleteButton.isEnabled = false
            self.deleteButton.title = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Prepopulates the text field if the user is updating a note
        if update == true {
            titleTextField.text = note!.title
            bodyTextField.text = note!.note
            // Do any additional setup after loading the view.
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
