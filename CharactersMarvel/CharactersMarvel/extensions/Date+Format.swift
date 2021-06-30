//
//  Date+Format.swift
//  CharactersMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 28/06/21.
//

import Foundation

extension String {
    
    func dateFormat(formatTo : String, formatFrom : String) -> String {
        
        let GMTFormat = DateFormatter()
        GMTFormat.locale = Locale(identifier: "en_US_POSIX")
        GMTFormat.dateFormat = formatTo
        
        if let dateObject = GMTFormat.date(from: self) {
            let PTBRFormat = DateFormatter()
            PTBRFormat.locale = Locale(identifier: "pt_BR")
            PTBRFormat.dateFormat = formatFrom
            return PTBRFormat.string(from: dateObject)
        }
        
        return "-"
        
    }
}
