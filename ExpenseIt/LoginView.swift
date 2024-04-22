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
            
            Text("Welcome")
                .font(.system(size: 28))
//                .bold()
                .underline()
            
            Divider()
            
            TextField("Email Address",text: $username)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .border(.secondary)
            .padding(.trailing, 50)
            .padding(.leading, 50)
            .cornerRadius(25)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password",text: $password)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .border(.secondary)
            .padding(.trailing, 50)
            .padding(.leading, 50)
            
            
            Button {
                doLoginPost(username: username, password: password) { (tokens, error) in
                    if let error = error {
                        print ("Error occured doing login: \(error)")
                    } else {
                        print ("login was ok")
//                        TODO : Add success message for user
                    }
                }
            } label: {
                HStack {
                    Image(systemName: "person.badge.key")
                    Text("Log In")
                }
            }.buttonStyle(.borderedProminent)
            
    
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        
        
    }
}


func doLoginPost(username: String, password: String, completion: @escaping (Tokens?, Error?) -> Void) {
    
    let parameters: [String: Any] = [
        "email": username,
        "password": password
    ]
    
    let service = "com.expenseit.ios"
    
    let apiURL = "https://expenseit.tech/api/login_check"

    AF.request(apiURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: ["Accept": "application/json"]).responseJSON { response in
        switch response.result {
        case .success(let value):
            
            if let json = value as? [String: Any],
            let token = json["token"] as? String,
            let refreshToken = json["refresh_token"] as? String {
                // Create tokens from struct
                let tokens = Tokens(refresh_token : refreshToken, token: token, fetchedAt: Date())
                // Save to keychain
                KeychainHelper.standard.save(tokens, service: service, account: username)
                
                let result = KeychainHelper.standard.read(service: service, account: username, type: Tokens.self)!
                
                print (result.token)
                print (result.refresh_token)
                print (result.fetchedAt)
            }

            

//            print (result.timestamp)

        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
}


struct Tokens: Codable {
    var refresh_token: String
    var token: String
    var fetchedAt: Date
}
