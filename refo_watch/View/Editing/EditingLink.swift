//
//  EditingLink.swift
//  refo_watch
//
//  Created by Bryan Kenneth on 27/07/22.
//

import SwiftUI

struct EditingLink: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var mode
    @State var title: String
    @State var urlLink: String
    @Binding var resource: FetchedResults<Resources>.Element
    
    
    init(resource: Binding<FetchedResults<Resources>.Element>) {
        self._resource = Binding(projectedValue: resource)
        self._title = State(initialValue: resource.wrappedValue.title ?? "Unittled")
        self._urlLink = State(initialValue: resource.wrappedValue.linkInet ?? "https://google.com")
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
                    
                    Text("URL Link 🔗")
                          .foregroundColor(Color("SecondaryColor"))
                          .fontWeight(.bold)
                          .padding(.top, 20)
                          .padding(.horizontal)
                          .multilineTextAlignment(.leading)
                          .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                      TextField("Link", text: $urlLink)
                          .frame(minHeight: 43)
                          .padding(.horizontal,10)
                          .overlay(
                                  RoundedRectangle(cornerRadius: 10)
                                      .stroke(Color("SecondaryColor"), lineWidth: 1)
                              )
                          .textFieldStyle(.plain)
                    Button {
                        editingLink()
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
                    .frame(width: .infinity, height: .infinity, alignment: .topLeading)
                    .padding(.horizontal)
                    
                    .navigationTitle("Edit Resource")
            )
    }
    
    func editingLink(){
        if $urlLink.wrappedValue != "" {
            
            
            $resource.wrappedValue.title = $title.wrappedValue
//            newCategory.kind = "Link"
            $resource.wrappedValue.linkInet = $urlLink.wrappedValue
            
            print($resource.wrappedValue)
            //            newCategory.categoryResource?.name = category.name
            
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

//struct EditingLink_Previews: PreviewProvider {
//    static var previews: some View {
//        EditingLink()
//    }
//}
