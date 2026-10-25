//
//  MissionListItemView.swift
//  MoonShot
//  Created by Phillip Kim on 20/10/2026.

import SwiftUI

struct MissionListItemView: View {
    
    let mission: Mission
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(mission.displayName)
                .font(.headline)
            
            Text(mission.formattedLaunchDate)
                .font(.caption)
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    MissionListItemView(mission: missions[0])
}


