//
//  DetailView.swift
//  refo_watch
//
//  Created by Bryan Kenneth on 26/07/22.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @State private var presentAlert = false
    @State private var newName: String?
    @State private var selection: String? = nil
    var category: FetchedResults<Category>.Element?
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest var resources: FetchedResults<Resources>
    
    init(category: FetchedResults<Category>.Element) {
        self.category = category
        _resources = FetchRequest(
                entity: Resources.entity(),
                sortDescriptors: [],
                predicate: NSPredicate(format: "categoryResource == %@", category)
        )
    }
    
    var arrays = ["a","b","c"]
    
    var body: some View {
        Color("PrimaryColor")
            .ignoresSafeArea()
            .overlay(
                VStack{
                   
                    List{
                        ForEach(resources, id: \.self){
                            resource in
                            DetailRow(kind: resource.kind ?? "Notes", name: resource.title ?? "Unitled", resource: resource)
                                .padding(.bottom).environment(\.managedObjectContext, viewContext)
                                .swipeActions {
                                    Button {
                                        withAnimation {
                                            viewContext.delete(resource)
                                            do {
                                                try viewContext.save()
                                            } catch {
                                                let error = error as NSError
                                                
                                                fatalError("Unresolved error: \(error)")
                                            }
                                        }
                                    } label: {
                                        Text("Delete")
                                    }.tint(.red)
                                }
                        }
                    }.listStyle(.plain)
                    NavigationLink(destination: NewLink(category: category!).environment(\.managedObjectContext, viewContext), tag: "A", selection: $selection) { EmptyView().environment(\.managedObjectContext, viewContext) }
                    NavigationLink(destination: NewCode(category: category!).environment(\.managedObjectContext, viewContext), tag: "B", selection: $selection) { EmptyView().environment(\.managedObjectContext, viewContext) }
                    NavigationLink(destination: NewPicture(), tag: "C", selection: $selection) { EmptyView() }
                    NavigationLink(destination: NewNotes(category: category!).environment(\.managedObjectContext, viewContext), tag: "D", selection: $selection) { EmptyView().environment(\.managedObjectContext, viewContext) }
                        
                   
                }.navigationTitle(category?.name ?? "Untitled")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                            Button {
                                presentAlert = true
                            } label: {
                                Image(systemName: "plus")
                            }.foregroundColor(Color("SecondaryColor"))
                            

                    }
                }
                    .confirmationDialog("What kind of resource do you want to add?", isPresented: $presentAlert, titleVisibility: .visible) {
                            Button("Notes") {
                                selection = "D"
                            }.foregroundColor(Color("SecondaryColor"))

//                            Button("Photos") {
//                                selection = "C"
//                            }.foregroundColor(Color("SecondaryColor"))

                            Button("Link") {
                                selection = "A"
                            }.foregroundColor(Color("SecondaryColor"))
                        
                            Button("Code") {
                                selection = "B"
                            }.foregroundColor(Color("SecondaryColor"))
                    }.onAppear(perform: {
                        
                    })
                    
                    
                    
                   
            )
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView{
//            DetailView()
//        }
//
//    }
//}
