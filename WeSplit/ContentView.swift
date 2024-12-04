//
//  ContentView.swift
//  WeSplit
//
//  Created by Diana Dashinevich on 03/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 15
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPrson = grandTotal / peopleCount
        
        return amountPerPrson
    }
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        
        return checkAmount + tipValue
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("What is the total cost?") {
                    HStack {
                        Text(Locale.current.currency?.identifier ?? "USD")
                        Divider()
                        TextField(
                            "Amount",
                            value: $checkAmount,
                            format: .number
                        )
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                    }
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 21) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section("How much tip do you want to leave?") {
                    HStack {
                        Text(" %  ")
                        Divider()
                        TextField("Amount", value: $tipPercentage, format: .number)
                    }
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                Section("Total amount for the check") {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                .foregroundColor(.black)
                
                Section("Amount per person") {
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                .foregroundColor(.black)
                
            }
            .navigationTitle("WeSplit")
            
            .onTapGesture {
                self.amountIsFocused = false
            }

            .foregroundColor(.indigo)
        }
    }
}

#Preview {
    ContentView()
}


