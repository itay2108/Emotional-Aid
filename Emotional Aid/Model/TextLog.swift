//
//  TextLog.swift
//  Emotional Aid
//
//  Created by itay gervash on 08/09/2021.
//

import Foundation

struct TextLog: TextOutputStream {
    
    var path: URL?
    
    /// Appends the given string to the stream.
    mutating func write(_ string: String) {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask)
        let documentDirectoryPath = paths.first!
        let log = documentDirectoryPath.appendingPathComponent("log.txt")
        path = log
        
        do {
            let logInput = "\(Date()): \(string)\n"
            let handle = try FileHandle(forWritingTo: log)
            handle.seekToEndOfFile()
            handle.write(logInput.data(using: .utf8)!)
            handle.closeFile()
        } catch {
            print(error.localizedDescription)
            do {
                try string.data(using: .utf8)?.write(to: log)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    mutating func clean() {
        if let log = path {
            do {
                let emptyString = ""
                try emptyString.write(to: log, atomically: false, encoding: .utf8)
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
        
    }
}
