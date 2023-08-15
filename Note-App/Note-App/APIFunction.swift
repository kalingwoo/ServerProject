//
//  APIFunction.swift
//  Note-App
//
//  Created by Louise on 15/8/2023.
//

import Foundation
import Alamofire

//Custim note struct
struct Note: Decodable{
    var title: String
    var date: String
    var note: String
    var _id: String
}

//function that interacte with API
class APIFunction{
    
    var delegate: DataDelegate?
    //create an instance of the class so the other file can interact with it
    static let function = APIFunction()
    
    func fetchNotes()
    {
        AF.request("http://10.10.4.4:8081/fetch").response{ response in //send the request to the link, and get response named response
            
            print(response.data)
            
            let data =  String(data: response.data!, encoding: .utf8) // turn the data we pass into string
            
            self.delegate?.updateArray(newArray: data!)
            //Fires off the custom delegate in the view controller
            //call delegate in theViewCOntroller
        }
    }
    
    //Adds a note to the server, passing the argument as header
    func AddNote(date: String, title: String, note: String){
        AF.request("http://10.10.4.4:8081/create", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "date": date, "note":  note]).responseJSON{ //headers is an array, name same as the api(postman) header, and pass the value from this code
            response in
        }
    }
    //Updates a note to the server, passing the argument as header
    func updateNote(date: String, title: String, note: String, id: String) {
        AF.request("http://10.10.4.4:8081/update", method: .post, encoding: URLEncoding.httpBody, headers:["title": title, "date": date, "note": note, "id": id]).responseJSON{
            response in
            print(response)
        }
    }
    //Deletes a note to the server, passing the note id as header
    func deleteNote(id: String) {
        AF.request("http://10.10.4.4:8081/delete", method: .post, encoding: URLEncoding.httpBody, headers:[ "id": id]).responseJSON{
            response in
            print(response)
        }
    }
    
}
