//
//  LoginView.swift
//  ExpenseIt
//
//  Created by George Clarke on 09/02/2024.
//

import SwiftUI
import Alamofire
import Foundation
import SwiftyJSON



struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""


    var body: some View {
        VStack{
            
            Image("expenseit")
            
            TextField("Email Address",text: $username)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .border(.secondary)
            .padding(.trailing, 50)
            .padding(.leading, 50)
            .cornerRadius(25)
            
            SecureField("Password",text: $password)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .border(.secondary)
            .padding(.trailing, 50)
            .padding(.leading, 50)
            
            Button("Log In"){
                sendPostRequestWithAlamofire(username: username, password: password)
            }

        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        
        
    }
}

var token = ""
var refresh_token = ""

func sendPostRequestWithAlamofire(username: String, password: String) {
    
    let parameters: [String: Any] = [
        "email": username,
        "password": password
    ]
    
    let apiURL = "https://expenseit.tech/api/login_check"

    AF.request("https://expenseit.tech/api/login_check", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: ["Accept": "application/json"]).responseDecodable(of: Tokens.self) { response in
        switch response.result {
        case .success(let value):
            token = value.token
            refresh_token = value.refresh_token
//            print ("Token \(value.token)")
//            print ("Refresh Token \(value.refresh_token)")
            print (token)
//            print("Response JSON: \(value)")
//            print(response)
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
}


struct Tokens: Codable{
        var refresh_token: String
        var token: String
}
