//
//  SearchBar.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
       var body: some View {
           HStack {
               TextField("Search Location", text: $text)
                   .cornerRadius(8)
                   .padding(.vertical, 5)
                Image(systemName: "magnifyingglass")
                   .foregroundColor(.gray)
                   .padding(.trailing, 8)
                              }
           .padding(10)
           .background(Color.gray.opacity(0.1))
           .cornerRadius(15)
       }
}

#Preview {
    SearchBar(text: .constant(""))
}
