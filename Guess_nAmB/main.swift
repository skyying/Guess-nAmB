//
//  main.swift
//  somethingFun
//
//  Created by skyying on 2020/8/21.
//  Copyright © 2020 skyying. All rights reserved.
//

import Foundation

// play a game of xAxB

print("Start gussing")
var answer = Int.random(in: 1000...10000)
var input = 0
var stillGussing = true

func isValidateInput(s: String) -> Bool {
    for char in s {
        let charASCII = char.asciiValue ?? 0
        if charASCII < 48 || charASCII > 57 {
            return false
        }
    }
    return s.count == 4
}


// will return xAxB which A means matched char are in exactly postion
// and B is that it contain in the string
func getComparedOutput(input: String) -> String {
    let _ans = String(answer)
    var exact_count: Int = 0
    var fuzz_count: Int = 0
    //var m = 0
    var tmp: [Character] = []
    var ans_tmp_list : [Character] = []
    for (n, _) in input.enumerated() {
        let idx = input.index(input.startIndex, offsetBy: n)
        let ans_idx = _ans.index(_ans.startIndex, offsetBy: n)
        
        let char: Character = input[idx]
        let ans_char: Character = _ans[ans_idx]
        
        if char == ans_char {
            exact_count += 1
        } else {
            tmp.append(char)
            ans_tmp_list.append(ans_char)
        }
    }
    
    for i in (0..<tmp.count) {
        let idx = ans_tmp_list.firstIndex(of: tmp[i])
        if idx != nil {
            fuzz_count += 1
            ans_tmp_list.remove(at: idx ?? 0)
        }
    }
    
    return "\(exact_count)A\(fuzz_count)B\n----"
}


func readFromInput() -> Int {
    var _input = String(bytes: FileHandle.standardInput.availableData, encoding: .utf8)!
    _input = _input.trimmingCharacters(in: .whitespacesAndNewlines)
    let isvalid: Bool = isValidateInput(s: _input)
    if !isvalid {
        print("You Input an Invalid value, input 4 digits to continue gussing")
        return 0
    }
    let output = getComparedOutput(input: _input)
    print(output)
    return Int(_input) ?? 0
}

while stillGussing {
    if input != answer {
        input = readFromInput()
    } else {
        stillGussing = false
    }
}

print("Wow!! You slove the puzzle!")
