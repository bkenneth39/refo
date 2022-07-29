//
//  NewCode.swift
//  refo_watch
//
//  Created by Bryan Kenneth on 26/07/22.
//

import SwiftUI

struct NewCode: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var mode
    var category: FetchedResults<Category>.Element
    
    
    @State var title = ""
    @State var code = ""
    @State private var showScannerSheet = false
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
                        Text("Code Snippets 👨🏻‍💻")
                              .foregroundColor(Color("SecondaryColor"))
                              .fontWeight(.bold)
                              .padding(.top, 20)
                              .multilineTextAlignment(.leading)
                              .frame(width: .infinity, alignment: .leading)
                        
                        Spacer()
                        Button {
                            showScannerSheet = true
                        } label: {
                            Text("Scan Code")
                                .foregroundColor(Color("SecondaryColor"))
                        }.padding(.top,20)

                    }
                    ScrollView{Text(code).padding(.horizontal)}
                        .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("SecondaryColor"), lineWidth: 1)
                                   
                            )
                        
                    Button {
                        addCode()
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
                    
                    .padding(.horizontal)
                    .navigationTitle("New Resource")
                    .sheet(isPresented: $showScannerSheet, content: {
                        self.makeScannerView()
                    })
            )
    }
    
    private func makeScannerView()-> ScannerView {
        ScannerView(completion: {
            textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines){
                let newScanData = ScanData(content: outputText)
                code = newScanData.content
//                self.texts.append(newScanData)
            }
            self.showScannerSheet = false
        })
    }
    func addCode(){
        if $code.wrappedValue != "" {
            let newCategory = Resources(context: viewContext)
            
            newCategory.title = $title.wrappedValue
            newCategory.kind = "Code"
            newCategory.code = $code.wrappedValue
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

//struct NewCode_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView{
//            NewCode()
//        }
//
//    }
//}
