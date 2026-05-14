//
//  ContentView.swift
//  Converter
//
//  Created by Phillip Kim on 15/05/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var source = 0.0
    @State private var inputUnitSelection = "km"
    @State private var outputUnitSelection = "km"
    let units = ["km", "ft", "yd", "mile"]
    
    var converted: Double {
        let kmSource = sourceToKM(source)
        return kmToTarget(kmSource)
    }
    
    func sourceToKM(_ source: Double) -> Double {
        if inputUnitSelection == "km" {
            return source
        } else if inputUnitSelection == "ft" {
            return source / 0.0003048
        } else if inputUnitSelection == "yd" {
            return source / 0.0009144
        } else {
            return source / 1609.34
        }
    }
    
    func kmToTarget(_ km: Double) -> Double {
        if outputUnitSelection == "km" {
            return km
        } else if outputUnitSelection == "ft" {
            return km * 0.0003048
        } else if outputUnitSelection == "yd" {
            return km * 0.0009144
        } else {
            return km * 1609.34
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Enter your distance") {
                    TextField("Source", value: $source, format: .number)
                        .keyboardType(.decimalPad)
                    
                    Picker("Selected input unit", selection: $inputUnitSelection) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Result") {
                    Picker("Selected output unit", selection: $outputUnitSelection) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    Text(converted, format: .number)
                }
            }
            .navigationTitle("Converter")
        }
    }
}

#Preview {
    ContentView()
}
