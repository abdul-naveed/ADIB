import UIKit

/** CODE REVIEW COMMENTS
 ** THE LOGIC MENTIONED THE CODE IS INCORRECT FOR CONVERTING ROMAN NUMBERS
 ** ADDING THE CONSTANTS TO SYMBOL MAP AND ITERATING WOULD BE FASTER
 ** RATHER CREATING A CLASS WE COULD HAVE EXTENDED THE NUMBER EXTENSION
 ** SO THAT THE SAME COULD HAVE BEEN USED ACROSS THE PROJECT OR THE SOURCE.
 **/
func convertToRomanNumber(number:Int) -> String {
    var roman = ""
    var numericalInt = number
    let symbolMap: [(Int, String)] = [(1000, "M"), (900, "CM"), (500, "D"), (400, "CD"), (100, "C"), (90, "XC"), (50, "L"), (40, "XL"), (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")]
    for i in symbolMap where (numericalInt >= i.0) {
        while (numericalInt >= i.0) {
            numericalInt -= i.0
            roman.append(contentsOf: i.1)
        }
    }
    return roman
}

let romanNm = convertToRomanNumber(number: 1234)
print(romanNm)

