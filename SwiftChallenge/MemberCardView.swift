//
//  MemberCardView.swift
//  SwiftChallenge
//
//  Created by Brian Seo on 3/22/21.
//

import SwiftUI

struct MemberCardView: View {
    @State var searchText: String = ""
    @State var addMember: Bool = false
    @EnvironmentObject var memberStore: MemberStore
    var body: some View {
        
        
        VStack {
            HStack {
                Text("Members")
                    .font(.system(size: 40, weight: .heavy))
                Spacer()
                Button(action: {
                    self.addMember.toggle()
                }) {
                    Image(systemName: "plus")
                        .font(.largeTitle)
                }.sheet(isPresented: $addMember, content: {
                    FormView(addMember: $addMember)
                })
            }
            .padding()
            SearchBar(text: $searchText)
                .padding(.top, -20)
            List {
                ForEach(memberStore.members.filter { $0.firstName.lowercased().contains(searchText.lowercased()) || $0.lastName.lowercased().contains(searchText.lowercased()) || searchText.isEmpty}) { member in
                    MemberCard(member: member)
                        .listRowInsets(EdgeInsets())
                }
            }
            
        }
    }
}

struct FormView: View {
    @State var fName: String = ""
    @State var lName: String = ""
    @State var email: String = ""
    @State var zipCode: String = ""
    @State var age: Double = 0
    @State var pushNotif: Bool = true
    @Binding var addMember: Bool
    @EnvironmentObject var memberStore: MemberStore
    
    @State var emptyFields: Bool = false
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Personal Info")){
                    TextField("First Name", text: $fName)
                        .disableAutocorrection(true)
                    TextField("Last Name", text: $lName)
                        .disableAutocorrection(true)
                    TextField("Email", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    TextField("Zip", text: $zipCode)
                    HStack {
                        Text("Age: \(age, specifier: "%.0f")")
                            .padding(.trailing, 10)
                        Slider(value: $age, in: 0...100, step: 1)
                    }
                }
                
                Section (header: Text("Preferences")) {
                    Toggle (isOn: $pushNotif){
                        Text("Push Notifications")
                    }
                }
                Button(action: {
                    memberStore.addMember(firstName: fName, lastName: lName, email: email, zipCode: zipCode, age: age, pushNotif: pushNotif)
                    self.addMember = false
                }, label: {
                    HStack{
                        Spacer()
                        Text("Submit")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                })
                .disabled(self.fName.isEmpty || self.lName.isEmpty || self.email.isEmpty || self.zipCode.isEmpty)
                
            }
            .navigationBarTitle("Add New Member")
        }
        
    }
}

struct MemberCardView_Previews: PreviewProvider {
    static var previews: some View {
        MemberCardView()
    }
}
