//
//  ContentView.swift
//  iExpense
//
//  Created by Phillip Kim on 31/05/2026.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    private let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(types, id: \.self) { type in
                    Section {
                        ForEach(expensesFilter(type)) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "NZD"))
                                    .foregroundColor(item.amount < 10 ? .green : item.amount < 100 ? .yellow : .red)
                            }
                        }
                        .onDelete { IndexSet in removeItems(at: IndexSet, for: type)}
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet, for type: String) {
        let chosenElement = expensesFilter(type)[offsets.first!]
        let uuid = chosenElement.id
        let index = expenses.items.firstIndex(where: { $0.id == uuid })!
        expenses.items.remove(at: index)
    }
    
    func expensesFilter(_ type: String) -> [ExpenseItem] {
        expenses.items.filter { $0.type == type}
    }
}

#Preview {
    ContentView()
}
