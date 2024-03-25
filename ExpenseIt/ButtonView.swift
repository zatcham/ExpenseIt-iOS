//
//  ButtonView.swift
//  ExpenseIt
//
//  Created by George Clarke on 09/02/2024.
//

import SwiftUI

struct HomeView: View {
    @Binding var showLoginPage: Bool
    @Binding var showGalleryPage: Bool
    
    var body: some View {
        LoginButton(showLoginPage: $showLoginPage)
        uploadImageButton(showGalleryPage: $showGalleryPage)
    }
}

struct uploadImageButton: View {
    @Binding var showGalleryPage:Bool
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button(action: {
                    print("uploadimage button pressed")
                    self.showGalleryPage.toggle()
                }) {
                    Image(systemName: "square.and.arrow.up")
                    Text("upload image to scan")
                        .font(.system(size:35))
                        .foregroundColor(.white)
                        .buttonStyle(PlainButtonStyle())
                }
                .frame(width: 500, height: 200)
                .sheet(isPresented:$showGalleryPage, content:{
                    GalleryView()
                })
            }
            Spacer()
        }
        
    }
}

struct LoginButton: View {
    @Binding var showLoginPage: Bool
    var body: some View {
        HStack {
        
            ZStack {
                Color.black.opacity(0.25)
                ControlButtton(systemIconName: "person.circle.fill") {
                    print("Login Button Pressed")
                    self.showLoginPage.toggle()
                }.sheet(isPresented: $showLoginPage , content: {
                    LoginView()
                })

                }
            }
            .frame(width: 50, height:50)
            .cornerRadius(8.0)
            .padding()
                        
    }
}

struct ControlButtton: View {
    let systemIconName: String
    let action: () -> Void
    
    var body: some View {

        Button(action: {
            self.action()
        }) {
            Image(systemName: systemIconName)
                .font(.system(size:35))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 50, height: 50)
    }
}
