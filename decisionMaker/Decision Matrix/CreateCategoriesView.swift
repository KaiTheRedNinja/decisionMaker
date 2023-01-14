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

    var body: some View {
        List {
            Section {
                ForEach($categories) { $category in
                    HStack {
                        TextField("Category Name", text: $category.title)
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
            }
        }
        .navigationTitle("Decision Matrix")
    }

    func isNavigationDisabled() {
        if categories.isEmpty || options.isEmpty {
            disableNavigation = true
            return
        }
        if Array(Set(categories.map({ $0.title }))).count != categories.count {
            disableNavigation = true
            return
        }
        if Array(Set(options.map({ $0.title }))).count != options.count {
            disableNavigation = true
            return
        }

        disableNavigation = false
        return
    }
}

struct CreateCategories_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateCategoriesView()
        }
    }
}
