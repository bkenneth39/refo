//
//  NewPicture.swift
//  refo_watch
//
//  Created by Bryan Kenneth on 26/07/22.
//

import SwiftUI

struct NewPicture: View {
    @State var title = ""
    @State var urlLink = ""
    
    @State private var image = UIImage()
    @State private var showSheet = false
    
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
                        Text("Picture 🖼")
                              .foregroundColor(Color("SecondaryColor"))
                              .fontWeight(.bold)
                              .padding(.top, 20)
                              
                              .multilineTextAlignment(.leading)
                        Spacer()
                        Button {
                            showSheet = true
                        } label: {
                            Text("Add / Change Picture")
                        }.padding(.top, 20)

                    }.frame(maxWidth: UIScreen.main.bounds.width)
                    
                    
                    Image(uiImage: self.image)
                                  .resizable()
                                  .cornerRadius(0)
                                  .frame(maxWidth: UIScreen.main.bounds.width, maxHeight:300)
                                  .background(Color.black.opacity(0.2))
                                  .aspectRatio(contentMode: .fit)
                                  

                    Button {
                        
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
                    .navigationTitle("New Resource")
                    .sheet(isPresented: $showSheet) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                    }
            )
    }
}

struct NewPicture_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NewPicture()
        }
        
    }
}
