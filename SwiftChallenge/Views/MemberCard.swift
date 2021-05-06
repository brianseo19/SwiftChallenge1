//
//  MemberCard.swift
//  SwiftChallenge
//
//  Created by Brian Seo on 3/19/21.
//

import SwiftUI

struct MemberCard: View {

    @Binding var member: Member
    var body: some View {
        HStack {
            Image(uiImage: member.profilePic)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80, alignment: .center)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                .shadow(radius: 5)
                .padding([.top, .bottom, .trailing], 10.0)
            VStack (alignment: .leading, spacing: 7) {
                Text("\(member.firstName) \(member.lastName)")
                    .font(.system(.title))
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Text("\(member.age, specifier: "%.0f")")
                }
                HStack {
                    if member.pushNotif {
                        Image(systemName: "checkmark.square.fill")
                            .foregroundColor(.green)
                    }
                    else {
                        Image(systemName: "xmark.square.fill")
                            .foregroundColor(.red)
                    }
                    Text("Push Notifications")
                }
            }
            .padding(.leading, 5)
        }
    }
}
struct MemberCard_Previews: PreviewProvider {
    static var previews: some View {
        MemberCard(member: .constant(Member(firstName: "Brian", lastName: "Seo", email: "brian.seo919@gmail.com", zipCode: "85286", age: 21, pushNotif: true, profilePic: UIImage(named: "portrait2")!)))
    }
}

