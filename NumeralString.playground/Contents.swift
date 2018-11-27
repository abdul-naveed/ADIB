import UIKit

// Code Review[Comments on Brief] :
// PLEASE REMOVE FUNCTION TIMES, IT ISN"T EFFICIENT USE AN ARRAY INSTEAD WHICH WILL HAVE SET OF SYMBOLS WITH THERE BASE VALUES
// Code Review[Comments] : Why do we need a seprate class called RomanNumber
//                         We can add extension to the Number itself rather creating a seprate class
//                         So that it could have been used with number it self.
class RomanNumber {
    
    // Code Review[Comments] : Why is MAX_VALUE?
    let MAX_VALUE = 3000
    
    // Code Review[Comments] : Why is minValue?
    let minValue = 0
    
    // Code Review[Comments] : Looks like we set and convert the number only when its greater than 3000?
    var number: Int {
        didSet {
            if (number > MAX_VALUE) {
                number = MAX_VALUE
            }
        }
    }
    
    init(value: Int) {
        self.number = value
    }
    
    // Lets simplify it
    // [Code Changes] : Pre-defined values, to avoid iteration
    private let M:[String] = ["", "M", "MM", "MMM"]
    private let C:[String] = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"]
    private let X:[String] = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"]
    private let I:[String] = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]
    
    
    // Code Review[Comments] : Why are we dividing each number by 1000 followed by 100,10 and..
    //                         This is not a right logic, this will end up with prefixing with 'M' always!
    func convert() -> String {
        // var result = ""
        
        // Code Review[Comments] : For example : 9 => IX, Here 9 / 1000
        //                         times(0,M)
        // Code Changes[Comments] added the base value for each line
        // Converting to roman
        let thousands = M[number / 1000]
        let hundereds = C[(number % 1000) / 100]
        let tens =  X[(number % 100) / 10]
        let ones = I[number % 10]
        let result = thousands + hundereds + tens + ones;
        return result
        
        //        let thousands = number / 1000
        //        result += times(thousands, character: "M")
        //        let hundreds = number / 100 % 10
        //        result += times(hundreds, o: "C", f: "D", t: "M")
        //        let tens = number / 10 % 10
        //        result += times(tens, o: "X", f: "L", t: "C")
        //        let ones = number % 10
        //        result += times(ones, o: "I", f: "V", t: "X")
        //        return result
    }
    
    // Code Review[Comments] : Is this even needed???, Running in a loop, Hmm! Less efficient
    // Please remove the above lines & define an array of variable to read roman values
    private func times(_ value: Int, character: String) -> String {
        var result = ""
        
        // BTW
        // Code Review[Comments] : For example : 9 => IX, Here 9 / 1000
        //                         times(0,M), value == 0, This will take one iteration atleast
        // Code Changed[Comments] : Code Changed from [for _ in (0...value)] to [for _ in (0..<value)]
        for _ in (0..<value) {
            result += character
        }
        return result
    }
    
    // Code Review[Comments] : Is this even needed???, Running in a loop, Hmm! Less efficient
    // Please remove the above lines & define an array of variable to read roman values
    private func times(_ value: Int, o: String, f: String, t: String) -> String {
        guard value < 10 else {
            print("Only single digits allowed - not " + String(number))
            return ""
        }
        
        switch value {
        case 0: return ""
        case 1: break
        case 2: break
        case 3: return times(value, character: o);
        case 4: return o + f
        case 5: break
        case 6: break
        case 7: break
        case 8: return f + times(number - 5, character: o)
        case 9: return o + t
        default : break
        }
        return ""
    }
}

var number = RomanNumber(value:2000)
let converted = number.convert()
print(converted)

