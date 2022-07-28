//
//  ContentView.swift
//  refo_watch
//
//  Created by Bryan Kenneth on 23/07/22.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    var categories: FetchedResults<Category>
    
    
    @State private var presentAlert = false
    @State private var newName: String = ""
    @State private var isEditing = false
    @State private var categoryToEdit: Category?
    
   

    var arrays = ["a","b","c"]
    var body: some View {
        Color("PrimaryColor")
            .ignoresSafeArea()
            .overlay(
                ZStack {
                    VStack{
                        List{
                            ForEach(categories, id: \.self) {category in
                                CategoryRow(name: category.name ?? "Untitled", category: category).environment(\.managedObjectContext, viewContext)
                                    .swipeActions {
                                        Button {
                                            isEditing = true
                                            presentAlert = true
                                            newName = category.name ?? "Untitled"
                                            categoryToEdit = category
                                        } label: {
                                            Text("Edit")
                                        }.tint(.blue)
                                        
                                        Button {
                                            withAnimation {
                                                viewContext.delete(category)
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
                            }.onDelete { index in
                                
                            }
                           
                            
                            
                        }
                        .listStyle(.plain)
                        
                        
                            
                       
                    }.navigationTitle("Your Resource📚")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing){
                                Button {
                                    isEditing = false
                                    newName = ""
                                    presentAlert = true
                                } label: {
                                    Image(systemName: "folder.fill.badge.plus")
                                }.foregroundColor(Color("SecondaryColor"))
                                

                        }
                }
                    
                    ZStack {
                               RoundedRectangle(cornerRadius: 20)
                                   .fill(Color.white)
                               VStack {
                                   Text(isEditing ? "Edit Category" : "Add Category")
                                       .font(.title)
                                       .foregroundColor(.black)
                                   
//                                   Divider()
                                   
                                   TextField("Enter text", text: $newName){
                                       hideKeyboard()
                                   }
                                       .padding(5)
                                       .background(Color.gray.opacity(0.2))
                                       .foregroundColor(.black)
                                       .padding(.horizontal, 20)
                                   
//                                   Divider()
                                   
                                   HStack {
                                       Button("Dismiss") {
//                                           addCategories()
                                           isEditing = false
                                           self.presentAlert.toggle()
                                       }
                                       Spacer()
                                       Button("Save") {
                                           
                                           hideKeyboard()
                                           if !isEditing{
                                               addCategories()
                                           } else {
                                               editCategory()
                                           }
                                           
                                           
                                       }
                                   }
                                   .padding(30)
                                   .padding(.horizontal, 40)
                               }
                    }
                           .frame(width: 300, height: 200)
                           .opacity(presentAlert ? 1 : 0)
                })
        
    }
    
    func editCategory(){
        categoryToEdit?.name = newName
        do {
            try viewContext.save()
            self.presentAlert.toggle()
            newName = ""
        } catch {
            let error = error as NSError
            
            fatalError("Unresolved error: \(error)")
        }
    }
    
    func addCategories(){
        if $newName.wrappedValue != "" {
            let newCategory = Category(context: viewContext)
            
            newCategory.name = $newName.wrappedValue
            
            do {
                try viewContext.save()
                self.presentAlert.toggle()
                newName = ""
            } catch {
                let error = error as NSError
                
                fatalError("Unresolved error: \(error)")
            }
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView{
//            ContentView()
//        }
//        .previewInterfaceOrientation(.portrait)
//
//    }
//}

