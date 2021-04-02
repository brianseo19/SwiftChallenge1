//
//  ContentView.swift
//  SwiftChallenge
//
//  Created by Brian Seo on 3/19/21.
//

import SwiftUI

//struct FormView: View {
//    @State var fName: String = ""
//    @State var lName: String = ""
//    @State var email: String = ""
//    @State var zipCode: String = ""
//    @State var age: Double = 0
//    @State var pushNotif: Bool = true
//    @Binding var addMember: Bool
//    var body: some View {
//        NavigationView {
//            Form {
//                Section (header: Text("Personal Info")){
//                    TextField("First Name", text: $fName)
//                        .disableAutocorrection(true)
//                    TextField("Last Name", text: $lName)
//                        .disableAutocorrection(true)
//                    TextField("Email", text: $email)
//                        .disableAutocorrection(true)
//                        .autocapitalization(.none)
//                    TextField("Zip", text: $zipCode)
//                    HStack {
//                        Text("Age: \(age, specifier: "%.0f")")
//                            .padding(.trailing, 10)
//                        Slider(value: $age, in: 0...100, step: 1)
//                    }
//                }
//                
//                Section (header: Text("Preferences")) {
//                    Toggle (isOn: $pushNotif){
//                        Text("Push Notifications")
//                    }
//                }
//                Button(action: {
//                    self.addMember = false
//                }, label: {
//                    HStack{
//                        Spacer()
//                        Text("Submit")
//                            .fontWeight(.semibold)
//                        Spacer()
//                    }
//                })
//                
//            }
//            .navigationBarTitle("Add New Member")
//            
//            
//            
//        }
//        
//    }
//}

//struct FormView_Previews: PreviewProvider {
//    static var previews: some View {
//        FormView(addMember: )
//    }
//}
