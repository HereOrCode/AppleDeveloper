//
//  File.swift
//  AppleDeveloper
//
//  Created by Apple on 2021/4/30.
//

import Foundation

func printLog<T>(_ message: T,
                 file: String = #file,
                 method: String = #function,
                 line: Int = #line)
{
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}
