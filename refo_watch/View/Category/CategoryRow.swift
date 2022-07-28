//
//  CategoryRow.swift
//  refo_watch
//
//  Created by Bryan Kenneth on 26/07/22.
//

import SwiftUI

struct CategoryRow: View {
    @State var name = "Tech"
    @State var category: FetchedResults<Category>.Element
    @Environment(\.managedObjectContext) var viewContext
    var body: some View {
        NavigationLink {
            DetailView(category: category).environment(\.managedObjectContext, viewContext)
        } label: {
            HStack{
                Image(systemName: "folder.fill")
                    .foregroundColor(Color("SecondaryColor")).font(.system(size: 25))
                Text(name).font(.system(size: 20)).fontWeight(.regular)
            }
        }
       .listRowBackground(Color("PrimaryColor"))
            .listRowSeparator(.hidden)
    }
}


//struct CategoryRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryRow()
//    }
//}
