//
//  MemberCardView.swift
//  SwiftChallenge
//
//  Created by Brian Seo on 3/22/21.
//

import SwiftUI

struct MemberCardView: View {
    @State var searchText: String = ""
    @State private var addMember: Bool = false
    @EnvironmentObject var memberStore: MemberStore
    
    var body: some View {
        
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "Search for member...")
                List {
                    ForEach(memberStore.members.filter {
                        self.searchText.isEmpty ? true : $0.firstName.lowercased().contains(self.searchText.lowercased()) || $0.lastName.lowercased().contains(self.searchText.lowercased())})
                        { member in
                            let index = getIndex(member: member)
                            NavigationLink(destination: ProfileView(member: $memberStore.members[index!]))
                            {
                                MemberCard(member: $memberStore.members[index!])
                            }
                                        
                        }
//                    ForEach(memberStore.members.indices, id: \.self) { index in
//                        NavigationLink(
//                            destination: ProfileView(member: $memberStore.members[index])) {
//                            MemberCard(member: $memberStore.members[index])
//                        }
//                    }
                    .onDelete(perform: removeRow)
                }
                //fixes the gray background
                .listStyle(PlainListStyle())
                .navigationTitle("Members")
                .navigationBarItems(trailing:
                    Button(action: {
                        self.addMember.toggle()
                    }) {
                        Image(systemName: "plus")
                            .font(.largeTitle)
                    }.sheet(isPresented: $addMember) {
                        FormView()
                    }
            )
            }
        }
        
    }
    
    func removeRow(at offset: IndexSet) {
        memberStore.members.remove(atOffsets: offset)
    }
    
    func getIndex(member: Member) -> Int? {
        return memberStore.members.firstIndex { $0.firstName == member.firstName && $0.lastName == member.lastName}
    }
}


struct MemberCardView_Previews: PreviewProvider {
    static var previews: some View {
        MemberCardView().environmentObject(MemberStore())
    }
}

