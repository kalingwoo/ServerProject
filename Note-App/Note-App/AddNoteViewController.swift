//
//  AddNoteViewController.swift
//  Note-App
//
//  Created by Louise on 15/8/2023.
//

import UIKit




class AddNoteViewController: UIViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    
    @IBOutlet weak var bodyTextField: UITextView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func saveChlick(_ sender: Any) {
        APIFunction.function.AddNote(date: "Placeholder", title: titleTextField.text!, note: bodyTextField.text)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("lol")
        // Do any additional setup after loading the view.
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
