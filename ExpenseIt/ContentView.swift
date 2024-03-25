//
//  ContentView.swift
//  ExpenseIt
//
//  Created by George Clarke on 05/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var showLoginPage: Bool = false
    @State private var showGalleryPage: Bool = false
    
    var body: some View {
        ZStack{
            
            //camera placeholder
            
            HomeView(showLoginPage: $showLoginPage, showGalleryPage: $showGalleryPage)
            
        }
    }
}
