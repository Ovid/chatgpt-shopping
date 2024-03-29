//
//  ContentView.swift
//  Shopping
//
//  Created by Curtis Poe on 12/01/2024.
//

import SwiftUI

struct ShoppingItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var isChecked: Bool
    var frequency: Int
}

enum SortAction {
    case alpha, frequency
}

class ShoppingListViewModel: ObservableObject {
    @Published var items: [ShoppingItem] = [] {
        didSet {
            saveItems()
        }
    }
    
    private var lastSortAction: SortAction = .frequency

    init() {
        loadItems()
    }

    func addItem(_ newItem: ShoppingItem) -> Bool {
        if let index = items.firstIndex(where: { $0.name == newItem.name }) {
            items[index].frequency += 1
            applyLastSortAction()  // Re-sort the list if needed
            return false
        } else {
            items.append(newItem)
            return true
        }
    }


    func deleteItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    // Implement the saveItems method
    private func saveItems() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: "shoppingItems")
        }
    }

    // Implement the loadItems method
    private func loadItems() {
        if let savedItems = UserDefaults.standard.data(forKey: "shoppingItems"),
           let decodedItems = try? JSONDecoder().decode([ShoppingItem].self, from: savedItems) {
            items = decodedItems
        }
    }

    func sortAlpha() {
        lastSortAction = .alpha
        items.sort {
            if $0.isChecked == $1.isChecked {
                return $0.name < $1.name
            }
            return !$0.isChecked && $1.isChecked
        }
    }

    func sortFrequency() {
        lastSortAction = .frequency
        items.sort {
            if $0.isChecked == $1.isChecked {
                return $0.frequency > $1.frequency
            }
            return !$0.isChecked && $1.isChecked
        }
    }
    
    func applyLastSortAction() {
        switch lastSortAction {
        case .alpha:
            sortAlpha()
        case .frequency:
            sortFrequency()
        }
    }
}

struct CustomButtonStyle: ButtonStyle {
    var isSelected: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity) // Equal width
            .padding()
            .background(isSelected ? Color.blue : Color.gray)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct ContentView: View {
    @StateObject var viewModel = ShoppingListViewModel()
    @State private var newItemName: String = ""
    @State private var duplicateItemName: String = ""
    @State private var selectedSort: SortAction = .frequency
    @State private var showingDuplicateItemAlert = false  // Ensure this is declared within ContentView
    @State private var fadeOutBackground = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("New item", text: $newItemName, onCommit: {
                    if !newItemName.isEmpty {
                        let newItem = ShoppingItem(name: newItemName, isChecked: false, frequency: 1)
                        if !viewModel.addItem(newItem) {
                            duplicateItemName = newItem.name
                            showingDuplicateItemAlert = true
                            fadeOutBackground = true

                            // Start a timer to reset the fade-out effect after 10 seconds
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                fadeOutBackground = false
                                duplicateItemName = ""
                            }
                        }
                        else {
                            duplicateItemName = ""
                            viewModel.applyLastSortAction()
                        }
                    }
                })
                .onSubmit {
                    newItemName = ""
                }
                .padding()
                .alert(isPresented: $showingDuplicateItemAlert) {
                    Alert(title: Text("Item already exists"), message: Text("'\(duplicateItemName)' is already in your list."), dismissButton: .default(Text("OK")))
                }
                
                List {
                    ForEach($viewModel.items) { $item in
                        HStack {
                            Toggle(isOn: $item.isChecked) {
                                Text(item.name)
                                    .fontWeight(item.name == duplicateItemName ? .bold : .regular)
                            }
                            .onChange(of: item.isChecked) {
                                if item.isChecked {
                                    item.frequency += 1
                                }
                                viewModel.applyLastSortAction()
                            }
                        }
                        .background(item.name == duplicateItemName ? (fadeOutBackground ? Color.yellow.opacity(0.5) : Color.yellow) : Color.clear)
                        .cornerRadius(5) // Optional: for rounded corners
                        .padding(.vertical, 4) // Optional: for better spacing
                    }
                    .onDelete(perform: viewModel.deleteItem)
                }

                HStack {
                    Button("A to Z") {
                        viewModel.sortAlpha()
                        selectedSort = .alpha
                        generateHapticFeedback()
                    }
                    .buttonStyle(CustomButtonStyle(isSelected: selectedSort == .alpha))
                    .frame(width: 150) // Set a specific width for the button

                    Button("Popular") {
                        viewModel.sortFrequency()
                        selectedSort = .frequency
                        generateHapticFeedback()
                    }
                    .buttonStyle(CustomButtonStyle(isSelected: selectedSort == .frequency))
                    .frame(width: 150) // Set a specific width for the button
                }
                .padding() // Add padding around HStack if needed

            }
            .navigationTitle("Ovid‘s Shopping")
        }
    }

    private func generateHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
