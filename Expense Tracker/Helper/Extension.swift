//
//  Extension.swift
//  Expense Tracker
//
//  Created by ITRENTALINDIA on 26/09/22.
//

import Foundation
extension Date {
    
    //MARK: returning date in milliseconds
    var millisecondsSince1970: Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    //MARK: converting date into milliseconds
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    //MARK: returning current date
    var currentDate : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy" //"MM/dd/yyyy"
        let date = formatter.string(from: Date())
        return date
    }
}
