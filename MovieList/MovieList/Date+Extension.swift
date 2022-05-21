//
//  Date+Extension.swift
//  MovieList
//
//  Created by Jiawei on 2022/5/14.
//

import Foundation

extension Date {
    func getWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // OR "dd-MM-yyyy"

        let currentDateString: String = dateFormatter.string(from: self)
        print("Current date is \(currentDateString)")
        return String(currentDateString.prefix(3))
    }
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd" // OR "dd-MM-yyyy"

        let currentDateString: String = dateFormatter.string(from: self)
        print("Current date is \(currentDateString)")
        return currentDateString
    }
    
    func getMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM" // OR "dd-MM-yyyy"

        let currentDateString: String = dateFormatter.string(from: self)
        print("Current date is \(currentDateString)")
        return currentDateString
    }
    
    func addADay() -> Date {
        let mutableDay = Calendar.current.date(byAdding: .day, value: 1, to: self)!
        return mutableDay
    }
    
    func deleteADay() -> Date {
        let mutableDay = Calendar.current.date(byAdding: .day, value: -1, to: self)!
        return mutableDay
    }
    
    func appendDay(date_dis: Int) -> Date {
        let mutableDay = Calendar.current.date(byAdding: .day, value: date_dis, to: self)!
        return mutableDay
    }

    func format(str: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = str
        let currentDateString: String = dateFormatter.string(from: self)
        return currentDateString
    }
}
