//
//  APIFunction.swift
//  Note-App
//
//  Created by Louise on 15/8/2023.
//

import Foundation
import Alamofire

struct Note: Decodable{
    var title: String
    var date: String
    var note: String
    var _id: String
}

class APIFunction{
    
    var delegate: DataDelegate?
    
    static let function = APIFunction()
    
    func fetchNotes()
        {
            AF.request("http://10.10.4.4:8081/fetch").response{ response in //send the request to the link, and get response named response
                
                print(response.data)
                
                let data =  String(data: response.data!, encoding: .utf8) // turn the data we pass into string
                
                self.delegate?.updateArray(newArray: data!)//call delegate in theViewCOntroller
            }
        }
    
    func AddNote(date: String, title: String, note: String){
        AF.request("http://10.10.4.4:8081/create", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "date": date, "note": note]).responseJSON{
            response in
            }
    }
     
}
