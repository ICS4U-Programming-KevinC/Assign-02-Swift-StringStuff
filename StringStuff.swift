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
    // Convert input string into an array.
    let lineArr = Array(str)

    // Initialize variable.
    var output = ""

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
    // Initialize array from the string.
    let lineArr = Array(str)

    // Initialize variables
    var maxRun = 0
    var currentRun = 1
    var lastChar = lineArr[0]

    // Loop through every character in the array
    for i in 1..<lineArr.count {
        // Check if the last character is the same as the current character.
        if lastChar == lineArr[i] {
            // Increment current run length.
            currentRun += 1
        } else {
            // Check if the current run has surpassed the previous max run.
            if currentRun > maxRun {
                // Set the max run to the current run.
                maxRun = currentRun
            }
            // Reset current run and set last char to the current char.
            currentRun = 1
            lastChar = lineArr[i]
        }
    }
    return maxRun
}

// Shrink method.
func shrink(_ str: String) -> String {
    // Initialize array from the string.
    let lineArr = Array(str)

    // Initialize variables.
    var output = ""
    var currentRun = 0
    var currentChar = lineArr[0]

    // Loop through every character in the array
    for i in 1..<lineArr.count {
        // Check if the previous character is the same as the current.
        if currentChar == lineArr[i] {
            // Increment the current run length.
            currentRun += 1
        } else {
            // Ensure the current run is not 0.
            if currentRun != 0 {
                // Add the run length and the character to the string eg. '3f'.
                output.append("\(currentRun)\(currentChar)")
            } else {
                // Add just the current character to the string.
                output.append(currentChar)
            }
            // Reset current run and set the current char to the current char.
            currentRun = 0
            currentChar = lineArr[i]
        }
    }
    // Run the if block one more time to get the last letter.
    if currentRun != 0 {
        // Add the run length and the character to the string eg. '3f'.
        output.append("\(currentRun)\(currentChar)")
    } else {
        // Add just the current character to the string.
        output.append(currentChar)
    }
    return output
}

// Call the main function
StringStuff.main()
