//
//  ContentView.swift
//  TimeCalculator
//
//  Created by Aidan Bergerson on 12/10/24.
//

import SwiftUI

enum TimeUnit: String, CaseIterable {
    case seconds = "Seconds"
    case minutes = "Minutes"
    case hours = "Hours"
    case days = "Days"
    
    var toSeconds: Double {
        switch self {
        case .seconds: return 1
        case .minutes: return 60
        case .hours: return 3600
        case .days: return 86400
        }
    }
}

struct ContentView: View {
    @State private var time = 0
    @State private var inputUnit: TimeUnit = .seconds
    @State private var outputUnit: TimeUnit = .minutes
    
    var unitsOfTime: TimeUnit = .seconds

    var covertedTime: Double {
        let timeInSeconds = Double(time) * inputUnit.toSeconds
        return timeInSeconds / outputUnit.toSeconds
    }
    
    var errorMessage: String? {
        if inputUnit == outputUnit {
            return "Input and output units must be different"
        }
        
        return nil
    }
    
    var body: some View {
        Form {
            Section("Input") {
                TextField("Enter your time", value: $time, format: .number)
                Picker("Select your input", selection: $inputUnit) {
                    ForEach(TimeUnit.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Section("Output") {
                Picker("Select the output", selection: $outputUnit) {
                    ForEach(TimeUnit.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            if let error = errorMessage {
                Section("Error") {
                    Text(error)
                        .foregroundStyle(.red)
                }
            } else if time == 0 {
                
            } else {
                Section("Result") {
                    Text("\(covertedTime, specifier: "%.2f") \(outputUnit.rawValue)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
