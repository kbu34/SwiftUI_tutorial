//
//  ContentView.swift
//  MoonShot
//
//  Created by Phillip Kim on 20/09/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let layout = [
            GridItem(.adaptive(minimum: 80, maximum: 120)),
        ]
        
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
