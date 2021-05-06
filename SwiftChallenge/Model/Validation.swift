//
//  Validation.swift
//  SwiftChallenge
//
//  Created by Brian Seo on 4/25/21.
//

import Foundation

class Validate {
    
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

}
