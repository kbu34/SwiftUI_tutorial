//
//  ContentView.swift
//  MoonShot
//
//  Created by Phillip Kim on 20/09/2026.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts = Bundle.main.decode("astronauts.json")
    
    var body: some View {
        Text(String(astronauts.count))
    }
}

#Preview {
    ContentView()
}
