//
//  ProfileView.swift
//  SwiftChallenge
//
//  Created by Brian Seo on 4/19/21.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var memberStore: MemberStore
    @State private var editMember: Bool = false
    @Binding var member: Member
    
    var body: some View {
        
        VStack {
            Image(uiImage: member.profilePic)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200, alignment: .center)
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
                    Text("Push Notifcations").font(.headline)
                    Text(member.pushNotif ? "On" : "Off")
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
            }.sheet(isPresented: $editMember) {
                EditView(member: $member)
            }
        )
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(member: .constant(Member(firstName: "Brian", lastName: "Seo", email: "brian.seo919@gmail.com", zipCode: "85286", age: 21, pushNotif: true, profilePic: UIImage(named:"portrait2")!)))
    }
}




