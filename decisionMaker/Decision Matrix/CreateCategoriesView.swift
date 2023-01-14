//
//  CreateCategories.swift
//  decisionMaker
//
//  Created by Kai Quan Tay on 14/1/23.
//

import SwiftUI

struct CreateCategoriesView: View {
    @State var categories: [Category] = []
    @State var options: [Option] = []

    @State var disableNavigation: Bool = true

    @State var errorText: String = "Add at least two categories and options"

    var body: some View {
        List {
            Section {
                ForEach($categories) { $category in
                    HStack {
                        TextField("Category Name", text: $category.title)
                            .onChange(of: category.title) { _ in
                                isNavigationDisabled()
                            }
                        Spacer()

                        Picker(selection: $category.weight) {
                            ForEach(1..<6) { index in
                                Text("\(index)")
                            }
                        } label: {
                            EmptyView()
                        }
                    }
                }
                .onDelete { index in
                    categories.remove(atOffsets: index)
                    isNavigationDisabled()
                }
                .onMove { indexSet, moveTo in
                    categories.move(fromOffsets: indexSet,
                                    toOffset: moveTo)
                }
            } header: {
                HStack {
                    Text("Categories")
                    Spacer()
                    Button {
                        categories.append(.init(title: "Untitled Category",
                                                weight: 3))
                        isNavigationDisabled()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }

            Section {
                ForEach($options) { $option in
                    HStack {
                        TextField("Option Name", text: $option.title)
                            .onChange(of: option.title) { _ in
                                isNavigationDisabled()
                            }
                    }
                }
                .onDelete { index in
                    options.remove(atOffsets: index)
                    isNavigationDisabled()
                }
                .onMove { indexSet, moveTo in
                    options.move(fromOffsets: indexSet,
                                 toOffset: moveTo)
                }
            } header: {
                HStack {
                    Text("Options")
                    Spacer()
                    Button {
                        options.append(.init(title: "Untitled Option",
                                             scores: [:]))
                        isNavigationDisabled()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }

            Section {
                NavigationLink("Next") {
                    AssignScoresView(categories: categories, options: options)
                }
                .disabled(disableNavigation)

                if !errorText.isEmpty && disableNavigation {
                    Text(errorText)
                        .italic()
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
            }
        }
        .navigationTitle("Decision Matrix")
    }

    func isNavigationDisabled() {
        if categories.count < 2 || options.count < 2 {
            disableNavigation = true
            errorText = "Add at least two categories and options"
        } else if Array(Set(categories.map({ $0.title }))).count != categories.count {
            disableNavigation = true
            errorText = "No duplicate category names allowed"
        } else if Array(Set(options.map({ $0.title }))).count != options.count {
            disableNavigation = true
            errorText = "No duplicate option names allowed"
        } else {
            disableNavigation = false
        }
    }
}

struct CreateCategories_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateCategoriesView()
        }
    }
}
