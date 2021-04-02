//
//  MemberCard.swift
//  SwiftChallenge
//
//  Created by Brian Seo on 3/19/21.
//

import SwiftUI

struct MemberCard: View {
    var member = Member(firstName: "Brian", lastName: "Seo", email: "brian.seo919@gmail.com", zipCode: "85286", age: 21, pushNotif: true)
    var body: some View {
        
        HStack(alignment: .center) {
            Image("portrait2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipShape(Circle())
                .padding(.init(top: 10, leading: 15, bottom: 10, trailing: 10))
            VStack (alignment: .leading, spacing: 8){
                Text("\(member.firstName) \(member.lastName)")
                    .font(.system(.title))
                    .fontWeight(.semibold)
                    .lineLimit(1)
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Text("\(member.age, specifier: "%.0f")")
                }
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.black)
                    Text("\(member.email)")
                        .lineLimit(1)
                }
                HStack {
                    Image(systemName: "location.fill")
                        .foregroundColor(.blue)
                    Text("\(member.zipCode)")
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
            .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 20))
            Spacer()
        }
        
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(red: 242, green: 243, blue: 244))
        .modifier(CardModifier())
        .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 1))
        .padding(.all, 10)
        
        
        
        
                    
    }
}

struct MemberCard_Previews: PreviewProvider {
    static var previews: some View {
        MemberCard()
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
//            .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 0)
    }
    
}
