//  StringStuff.swift
//
//  Created by Kevin Csiffary
//  Created on 2024-04-17
//  Version 1.0
//  Copyright (c) Kevin Csiffary. All rights reserved.
//
//  Does string stuff.
import Foundation

// This is the main method.
func main() {
    // Initialize all of the file paths.
    let inputFile = "input.txt"
    let blowUpOutputFile = "blowUp.txt"
    let maxRunOutputFile = "maxRun.txt"
    let shrinkOutputFile = "shrink.txt"

    // Read input file.
    guard let input = FileHandle(forReadingAtPath: inputFile) else {
        print("Could not open input file!")
        exit(1)
    }

    // Setup output files.
    guard let blowUpOutput = FileHandle(forWritingAtPath: blowUpOutputFile) else {
        print("Could not open output file at path: \(blowUpOutputFile)")
        exit(1)
    }
    guard let maxRunOutput = FileHandle(forWritingAtPath: maxRunOutputFile) else {
        print("Could not open output file at path: \(maxRunOutputFile)")
        exit(1)
    }
    guard let shrinkOutput = FileHandle(forWritingAtPath: shrinkOutputFile) else {
        print("Could not open output file at path: \(shrinkOutputFile)")
        exit(1)
    }

    // Read input file.
    let inputData = input.readDataToEndOfFile()

    // Convert input data to string.
    guard let inputString = String(data: inputData, encoding: .utf8) else {
        print("Can't convert input data to string!")
        exit(1)
    }

    // Separate input string into lines.
    let inputLines = inputString.components(separatedBy: .newlines)

    // Calculate and write all of the results to the files.
    for line in inputLines {
        let blowUpData: Data = (blowUp(line) + "\n").data(using: .utf8) ?? Data()
        blowUpOutput.write(blowUpData)
        let maxRunData: Data = (String(maxRun(line)) + "\n").data(using: .utf8) ?? Data()
        maxRunOutput.write(maxRunData)
        let shrinkData: Data = (shrink(line) + "\n").data(using: .utf8) ?? Data()
        shrinkOutput.write(shrinkData)
    }
}

// Blow Up method.
func blowUp(_ str: String) -> String {
    // Initialize variable.
    var output = ""
    // Convert input string into an array.
    let lineArr = Array(str)

    // Loop through every character in the array
    for i in 0..<lineArr.count {
        // Check if the current character is a number.
        if lineArr[i].isNumber {
            // Set the number of copies to make to the number in the string.
            let numCopies = Int(String(lineArr[i])) ?? 0
            // Check if i + 1 is within the bounds of the array
            if i + 1 < lineArr.count {
                // Copy the next letter that amount of time.
                for _ in 0..<numCopies {
                    // Add the next letter to the output.
                    output.append(lineArr[i + 1])
                }
            }
        } else {
            // Add the current character to the output.
            output.append(lineArr[i])
        }
    }
    return output
}

// Max Run method.
func maxRun(_ str: String) -> Int {
    var maxRun = 0
    var currentRun = 1
    let lineArr = Array(str)

    var lastChar = lineArr[0]

    // Loop through every character in the array
    for i in 1..<lineArr.count {
        if lastChar == lineArr[i] {
            currentRun += 1
        } else {
            if currentRun > maxRun {
                maxRun = currentRun
            }
            currentRun = 1
            lastChar = lineArr[i]
        }
    }
    return maxRun
}

// Shrink method.
func shrink(_ str: String) -> String {
    var output = ""
    var currentRun = 0
    let lineArr = Array(str)

    var currentChar = lineArr[0]

    // Loop through every character in the array
    for i in 1..<lineArr.count {
        if currentChar == lineArr[i] {
            currentRun += 1
        } else {
            if currentRun != 0 {
                output.append("\(currentRun)\(currentChar)")
            } else {
                output.append(currentChar)
            }
            currentRun = 0
            currentChar = lineArr[i]
        }
    }
    if currentRun != 0 {
        output.append("\(currentRun)\(currentChar)")
    } else {
        output.append(currentChar)
    }
    return output
}

// Call the main function
StringStuff.main()
