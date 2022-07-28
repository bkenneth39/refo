//
//  DetailRow.swift
//  refo_watch
//
//  Created by Bryan Kenneth on 26/07/22.
//

import SwiftUI

struct DetailRow: View {
    @State var kind = ""
    @State var name = "Retro"
    @State var resource: FetchedResults<Resources>.Element
    @Environment(\.managedObjectContext) var viewContext
    var body: some View {
        NavigationLink {
            if resource.kind == "Link" {
                EditingLink(resource: $resource).environment(\.managedObjectContext, viewContext)
            } else if resource.kind == "Notes" {
                EditingNotes(resource: $resource).environment(\.managedObjectContext, viewContext)
            } else if resource.kind == "Code" {
                EditingCode(resource: $resource).environment(\.managedObjectContext, viewContext)
            } else {
                EditingPicture().environment(\.managedObjectContext, viewContext)
            }
        } label: {
            HStack{
                Image(systemName: kind == "Notes" ? "doc.fill" : kind == "Link" ? "link" : kind == "Photos" ? "photo.fill" : "chevron.left.forwardslash.chevron.right")
                    .foregroundColor(Color("SecondaryColor")).font(.system(size: 25))
                    .frame(width: UIScreen.main.bounds.width * 0.12, height: .infinity, alignment: .leading)
                Text(name).font(.system(size: 20)).fontWeight(.regular)
            }
        }
       .listRowBackground(Color("PrimaryColor"))
            .listRowSeparator(.hidden)
    }
    
    
   
}

//struct DetailRow_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailRow()
//    }
//}
