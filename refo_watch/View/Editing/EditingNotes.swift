//
//  EditingNotes.swift
//  refo_watch
//
//  Created by Bryan Kenneth on 27/07/22.
//

import SwiftUI

struct EditingNotes: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var mode
    @Binding var resource: FetchedResults<Resources>.Element
    @State var title = ""
    @State var notes = ""
    @State private var showScannerSheet = false
    
    init(resource: Binding<FetchedResults<Resources>.Element>) {
           UITextView.appearance().backgroundColor = .clear
        self._resource = Binding(projectedValue: resource)
        self._title = State(initialValue: resource.wrappedValue.title ?? "Unittled")
        self._notes = State(initialValue: resource.wrappedValue.notes ?? "No Notes")
    }
    
    var body: some View {
        Color("PrimaryColor")
            .ignoresSafeArea()
            .overlay(
                VStack{
                  Text("Title 🌟")
                        .foregroundColor(Color("SecondaryColor"))
                        .fontWeight(.bold)
                        .padding(.top, 20)
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                    TextField("Title", text: $title)
                        .frame(minHeight: 43)
                        .padding(.horizontal,10)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("SecondaryColor"), lineWidth: 1)
                                   
                            )
                        .textFieldStyle(.plain)
                    
                    HStack {
                        Text("Notes 📝")
                              .foregroundColor(Color("SecondaryColor"))
                              .fontWeight(.bold)
                              .padding(.top, 20)
                              .multilineTextAlignment(.leading)
                             
                        
                        Spacer()

                    }
                    TextEditor(text: $notes)
                            .foregroundColor(.black)
                            .background(Color("PrimaryColor"))
                            .frame(maxHeight: UIScreen.main.bounds.height * 0.4)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("SecondaryColor"), lineWidth: 1)
                                       
                                )
                            
                            
                        
                    Button {
                        editNotes()
                    } label: {
                        Text("Done")
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 43)
                    .background(Color("SecondaryColor"))
                    .cornerRadius(10)
                    .foregroundColor(Color.white)
                    .padding(.top, 20)
                    
                    Spacer()
                    
                }
                    
                    .padding(.horizontal)
                    .navigationTitle("Edit Resource")
                    
            )
    }
    
    func editNotes(){
        if $notes.wrappedValue != "" {
           
            
            resource.title = $title.wrappedValue
//            newCategory.kind = "Notes"
//            newCategory.linkInet = $urlLink.wrappedValue
            
//            newCategory.categoryResource?.name = category.name
//            newCategory.name = "fix"
            resource.notes = $notes.wrappedValue
           
            do {
                try viewContext.save()
                self.mode.wrappedValue.dismiss()
//                self.presentAlert.toggle()
            } catch {
                let error = error as NSError

                fatalError("Unresolved error: \(error)")
            }
        }
        
    }
}


