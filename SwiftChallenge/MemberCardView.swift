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
    
//    init() {
//        UITableView.appearance().backgroundColor = .white // Uses UIColor
//    }
    
    var body: some View {
        
        NavigationView {
            List(memberStore.members.indices) { index in
                    NavigationLink(destination: ProfileView(member: $memberStore.members[index])){
                        MemberCard(member: memberStore.members[index])
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Members")
                .navigationBarItems(trailing:
                    Button(action: {
                        self.addMember.toggle()
                    }) {
                        Image(systemName: "plus")
                            .font(.largeTitle)
                    }.sheet(isPresented: $addMember, content: {
                        FormView(addMember: $addMember)
                    })
            )
                        
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
    @State var emailValid: Bool = false
    @State var zipValid: Bool = false
    
    @Binding var addMember: Bool
    @EnvironmentObject var memberStore: MemberStore
    
    var validation: Bool {
        fName.isEmpty || lName.isEmpty || age == 0
    }
    
    
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
                        //email validation
                        .onChange(of: email, perform: { value in
                            if(isValidEmailAddress(emailAddressString: value))
                            {
                                self.emailValid = true
                            }
                            else {
                                self.emailValid = false
                            }
                        })
                    TextField("Zip", text: $zipCode)
                        //zipcode validation
                        .onChange(of: zipCode, perform: { value in
                            if(isValidZip(zipString: value))
                            {
                                self.zipValid = true
                            }
                            else {
                                self.zipValid = false
                            }
                        })
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
                    let newMem = Member(firstName: fName, lastName: lName, email: email, zipCode: zipCode, age: age, pushNotif: pushNotif)
                    memberStore.members.append(newMem)
                    self.addMember = false
                }, label: {
                    HStack{
                        Spacer()
                        Text("Submit")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                })
                .disabled(!emailValid || validation || !zipValid)
            
            }
            .navigationBarTitle("Add New Member")
            .navigationBarItems(trailing: Button(action: {
                self.addMember = false
            }, label: {
                Text("Cancel")
            }))
        }
        
    }
}

struct MemberCardView_Previews: PreviewProvider {
    static var previews: some View {
        MemberCardView().environmentObject(MemberStore())
    }
}

func isValidEmailAddress(emailAddressString: String) -> Bool {
    
    var returnValue = true
    let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    
    do {
        let regex = try NSRegularExpression(pattern: emailRegEx)
        let nsString = emailAddressString as NSString
        let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
        
        if results.count == 0
        {
            returnValue = false
        }
        
    } catch let error as NSError {
        print("invalid regex: \(error.localizedDescription)")
        returnValue = false
    }
    
    return returnValue
}

func isValidZip(zipString: String) -> Bool {
    
    var returnValue = true
    let zipRegEx = "^[0-9]{5}(?:-[0-9]{4})?$"
    
    do {
        let regex = try NSRegularExpression(pattern: zipRegEx)
        let nsString = zipString as NSString
        let results = regex.matches(in: zipString, range: NSRange(location: 0, length: nsString.length))
        
        if results.count == 0
        {
            returnValue = false
        }
        
    } catch let error as NSError {
        print("invalid regex: \(error.localizedDescription)")
        returnValue = false
    }
    
    return returnValue
}
