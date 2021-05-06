//
//  ContentView.swift
//  SwiftChallenge
//
//  Created by Brian Seo on 3/19/21.
//

import SwiftUI

struct FormView: View {
    //environment for modal and array of members
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var memberStore: MemberStore
    
    //text field state variables
    @State var fName: String = ""
    @State var lName: String = ""
    @State var email: String = ""
    @State var zipCode: String = ""
    @State var age: Double = 0
    @State var pushNotif: Bool = true
    @State var emailValid: Bool = false
    @State var zipValid: Bool = false
    
    //validation methods and variables
    let validate = Validate()
    var validation: Bool {
        fName.isEmpty || lName.isEmpty || age == 0
    }
    
    //image picker variables
    @State var image: UIImage?
    @State var showActionSheet = false
    @State var showImagePicker = false
    @State var sourceType:UIImagePickerController.SourceType = .camera
    
    var body: some View {
        NavigationView {
            VStack {
                if (image != nil) {
                    Image(uiImage: image!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 90, height: 90, alignment: .center)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        .shadow(radius: 3)
                        .padding(.top, 5.0)
                }
                else {
                    Image("portrait2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 90, height: 90, alignment: .center)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        .shadow(radius: 3)
                        .padding(.top, 5.0)
                }
                Button(action: {
                    self.showActionSheet.toggle()
                }, label: {
                    Text("Edit")
                }).actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(title: Text("Add a profile picture"), message: nil, buttons: [
                        .default(Text("Camera"), action: {
                            self.showImagePicker = true
                            self.sourceType = .camera
                        }),
                        .default(Text("Photo Library"), action: {
                            self.showImagePicker = true
                            self.sourceType = .photoLibrary
                        }),
                        .cancel()
                    ])
                }.sheet(isPresented: $showImagePicker) {
                    imagePicker(image: self.$image, showImagePicker: self.$showImagePicker, sourceType: self.sourceType)
                }
                
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
                                if(validate.isValidEmailAddress(emailAddressString: value))
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
                                if(validate.isValidZip(zipString: value))
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
                        if image != nil
                        {
                            let newMem = Member(firstName: fName, lastName: lName, email: email, zipCode: zipCode, age: age, pushNotif: pushNotif, profilePic: image!)
                            memberStore.members.append(newMem)
                        }
                        else {
                            let newMem = Member(firstName: fName, lastName: lName, email: email, zipCode: zipCode, age: age, pushNotif: pushNotif, profilePic: UIImage(named: "portrait2")!)
                            memberStore.members.append(newMem)
                        }
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
                .navigationBarTitle("Add New Member")
                .navigationBarItems(trailing: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
            }))
            }
        }
        
    }
}


struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
