//
//  ListLayout.swift
//  MoonShot
//
//  Created by Phillip Kim on 20/10/2026.

import SwiftUI

struct ListLayout: View {
    
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        List(missions, id: \.id) { mission in
            NavigationLink(value: mission, label: {
                MissionListItemView(mission: mission).padding(.horizontal, 16)
            })
        }
        .listStyle(.plain)
    }
}

#Preview {
    ListLayout(
        astronauts: Bundle.main.decode("astronauts.json"),
        missions: Bundle.main.decode("missions.json")
    )
}
