//
//  NewLink.swift
//  refo_watch
//
//  Created by Bryan Kenneth on 26/07/22.
//

import SwiftUI

struct NewLink: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var mode
    @State var title = ""
    @State var urlLink = ""
    
    var category: FetchedResults<Category>.Element
    
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
                       addLink()
                            
                    } label: {
                        Text("Done")
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 43)
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
                    
                    .navigationTitle("New Resource")
            )
    }
    func addLink(){
        if $urlLink.wrappedValue != "" {
            let newCategory = Resources(context: viewContext)
            
            newCategory.title = $title.wrappedValue
            newCategory.kind = "Link"
            newCategory.linkInet = $urlLink.wrappedValue
            newCategory.categoryResource = category
//            newCategory.categoryResource?.name = category.name
            print(category)
            print(newCategory)
            print(viewContext)
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

//struct NewLink_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView{
//            NewLink()
//        }
//        
//    }
//}
