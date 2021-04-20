//
//  ProfileView.swift
//  SwiftChallenge
//
//  Created by Brian Seo on 4/19/21.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var memberStore: MemberStore
    @State var editMember: Bool = false
    @Binding var member: Member
    
    var body: some View {
        
            VStack {
                Image("portrait2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 7)
                VStack(alignment: .center) {
                    Text("\(member.firstName) \(member.lastName)")
                        .font(.system(size: 35, weight: .bold))
                    VStack (alignment: .leading, spacing: 5){
                        Text("Age").font(.headline)
                        Text("\(member.age, specifier: "%.0f")")
                        Text("Email").font(.headline)
                        Text(member.email)
                        Text("Zipcode").font(.headline)
                        Text(member.zipCode)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.top, 5)
                }
                .padding()
            }
            .navigationBarTitle("Member: \(member.firstName)", displayMode: .inline)
            .navigationBarItems(
                trailing:  Button(action: {
                    self.editMember.toggle()
                }) {
                    Text("Edit")
                }.sheet(isPresented: $editMember, content: {
                    EditView(member: $member, editMember: $editMember)
                })
            )
            
        }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(member: .constant(Member(firstName: "b", lastName: "B", email: "B", zipCode: "B", age: 2, pushNotif: true)))
    }
}


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
    @Binding var editMember: Bool
    @EnvironmentObject var memberStore: MemberStore
    
    var validation: Bool {
        fName.isEmpty || lName.isEmpty || age == 0
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Personal Info")){
                    TextField("First Name", text: self.$member.firstName)
                        .disableAutocorrection(true)
//                    TextField("Last Name", text: member.lastName)
//                        .disableAutocorrection(true)
//                    TextField("Email", text: member.email)
//                        .disableAutocorrection(true)
//                        .autocapitalization(.none)
//                        //email validation
//                        .onChange(of: member.email, perform: { value in
//                            print(value)
//                            if(isValidEmailAddress(emailAddressString: value))
//                            {
//                                self.emailValid = true
//                            }
//                            else {
//                                self.emailValid = false
//                            }
//                        })
//                    TextField("Zipcode", text: $member.zipCode)
//                        //zipcode validation
//                        .onChange(of: member.zipCode, perform: { value in
//                            if(isValidZip(zipString: value))
//                            {
//                                self.zipValid = true
//                            }
//                            else {
//                                self.zipValid = false
//                            }
//                        })
//                    HStack {
//                        Text("Age: \(member.age, specifier: "%.0f")")
//                            .padding(.trailing, 10)
//                        Slider(value: $member.age, in: 0...100, step: 1)
//                    }
//                }
//                Section (header: Text("Preferences")) {
//                    Toggle (isOn: $pushNotif){
//                        Text("Push Notifications")
//                    }
//                }
                Button(action: {

                    self.editMember = false
                }, label: {
                    HStack{
                        Spacer()
                        Text("Submit")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                })
//                .disabled(!emailValid || validation || !zipValid)
            
            }
            .navigationBarTitle("Add New Member")
//            .navigationBarItems(trailing: Button(action: {
//                self.addMember = false
//            }, label: {
//                Text("Cancel")
//            }))
        }
        
    }
}
}
