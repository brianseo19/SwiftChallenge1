//
//  EditView.swift
//  SwiftChallenge
//
//  Created by Brian Seo on 4/30/21.
//

import SwiftUI

struct EditView: View {
    @State var fName: String = ""
    @State var lName: String = ""
    @State var email: String = ""
    @State var zipCode: String = ""
    @State var age: Double = 0
    @State var pushNotif: Bool = true
    @State var emailValid: Bool = false
    @State var zipValid: Bool = false
    
    @Binding var member: Member
//    @Binding var editMember: Bool
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var memberStore: MemberStore
    let validate = Validate()
    
    var validation: Bool {
        fName.isEmpty || lName.isEmpty || age == 0
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Personal Info")){
                    TextField("First Name", text: $fName, onCommit: saveData)
                        .disableAutocorrection(true)
                    TextField("Last Name", text: $lName)
                        .disableAutocorrection(true)
                    TextField("Email", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        //email validation
                        .onChange(of: email, perform: { value in
//                            print(value)
                            if(validate.isValidEmailAddress(emailAddressString: value))
                            {
                                self.emailValid = true
                            }
                            else {
                                self.emailValid = false
                            }
                        })
                        .onAppear(perform: {
                            if(validate.isValidEmailAddress(emailAddressString: email)) {
                                self.emailValid = true
                            }
                            else {
                                self.emailValid = false
                            }
                        })
                    TextField("Zipcode", text: $zipCode)
                        //zipcode validation
                        .onChange(of: zipCode, perform: { value in
                            if(validate.isValidZip(zipString: value))
                            {
                                self.zipValid = true
                            }
                            else {
                                self.zipValid = false
                            }
                        })
                        .onAppear(perform: {
                            if(validate.isValidZip(zipString: zipCode)) {
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
                    saveData()
                    presentationMode.wrappedValue.dismiss()
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
            .onAppear(perform: setData)
            .navigationBarTitle("Edit Member")
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
            }))
        }
        
    }
    
    func setData() {
        fName = member.firstName
        lName = member.lastName
        email = member.email
        zipCode = member.zipCode
        age = member.age
        pushNotif = member.pushNotif
    }
    
    func saveData() {
        member.firstName = fName
        member.lastName = lName
        member.email = email
        member.age = age
        member.zipCode = zipCode
        member.pushNotif = pushNotif
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(member: .constant(Member(firstName: "Brian", lastName: "Seo", email: "brian.seo919@gmail.com", zipCode: "85286", age: 21, pushNotif: true, profilePic: UIImage(named:"portrait2")!)))
    }
}
