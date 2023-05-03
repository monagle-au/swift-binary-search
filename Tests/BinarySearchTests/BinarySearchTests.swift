import XCTest
@testable import BinarySearch

class BinarySearchTests: XCTestCase {
    //             0  1  2  3  4   5   6   7   8   9   10  11  12  13  14  15  16  17  18
    let numbers = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]
    
    func testBinarySearchIndex() {
        XCTAssertEqual(numbers.binarySearchIndex { $0 <= 1 }, 0)
        XCTAssertEqual(numbers.binarySearchIndex { $0 < 35 }, 11)
        XCTAssertEqual(numbers.binarySearchIndex { $0 <= 35 }, 11)
        XCTAssertEqual(numbers.binarySearchIndex { $0 < 23 }, 8)
        XCTAssertEqual(numbers.binarySearchIndex { $0 <= 23 }, 9)
    }
    
    func testBinarySearchMatchingValue() {
        XCTAssertNil(numbers.binarySearch(\.self, matching: 1))
        XCTAssertNil(numbers.binarySearch(\.self, matching: 35))
        XCTAssertEqual(numbers.binarySearch(\.self, matching: 23), 23)
        XCTAssertEqual(numbers.binarySearch(\.self, matching: 67), 67)
        XCTAssertNil(numbers.binarySearch(\.self, matching: 68))
    }

    func testBinarySearchNearestValue() {
        XCTAssertEqual(numbers.binarySearch(\.self, nearest: 1), 2)
        XCTAssertEqual(numbers.binarySearch(\.self, nearest: 35), 37)
        XCTAssertEqual(numbers.binarySearch(\.self, nearest: 23), 23)
        XCTAssertEqual(numbers.binarySearch(\.self, nearest: 67), 67)
        XCTAssertNil(numbers.binarySearch(\.self, nearest: 68))
    }

    func testBinarySlice() {
        let sliceFrom2 = numbers.binarySlice(from: 2)
        XCTAssertEqual(sliceFrom2.count, 19)
        XCTAssertEqual(sliceFrom2[0], 2)

        let sliceFrom13 = numbers.binarySlice(from: 13)
        XCTAssertEqual(sliceFrom13.count, 14)
        XCTAssertEqual(sliceFrom13[0], 13)

        let sliceFrom15 = numbers.binarySlice(from: 15)
        XCTAssertEqual(sliceFrom15.count, 13)
        XCTAssertEqual(sliceFrom15[0], 17)

        let sliceFrom80 = numbers.binarySlice(from: 80)
        XCTAssertEqual(sliceFrom80.count, 0)

        let sliceFrom17Until17 = numbers.binarySlice(from: 17, until: 18)
        XCTAssertEqual(sliceFrom17Until17.count, 1)
        XCTAssertEqual(sliceFrom17Until17[0], 17)

        let sliceFrom17Until100 = numbers.binarySlice(from: 17, until: 100)
        XCTAssertEqual(sliceFrom17Until100.count, 13)
        XCTAssertEqual(sliceFrom17Until100.last, 67)
        
        let sliceUntil30 = numbers.binarySlice(until: 30)
        XCTAssertEqual(sliceUntil30.count, 10)
        XCTAssertEqual(sliceUntil30.last, 29)

        let sliceUntil31 = numbers.binarySlice(until: 31)
        XCTAssertEqual(sliceUntil31.count, 10)
        XCTAssertEqual(sliceUntil31.last, 29)

        let sliceUntil31Inclusive = numbers.binarySlice(until: 31, inclusive: true)
        XCTAssertEqual(sliceUntil31Inclusive.count, 11)
        XCTAssertEqual(sliceUntil31Inclusive.last, 31)

        let sliceUntil100Inclusive = numbers.binarySlice(until: 100, inclusive: true)
        XCTAssertEqual(sliceUntil100Inclusive.count, 19)
        XCTAssertEqual(sliceUntil100Inclusive.last, 67)
    }
    
    func testBinarySortedInsert() {
        var newNumbers = numbers
        newNumbers.binarySortedInsert(44, on: \.self)
        XCTAssertEqual(newNumbers.count, 20)
        XCTAssertEqual(newNumbers[14], 44)
        newNumbers.binarySortedInsert(117, on: \.self)
        XCTAssertEqual(newNumbers.count, 21)
        XCTAssertEqual(newNumbers.last, 117)
        newNumbers.binarySortedInsert(0, on: \.self)
        XCTAssertEqual(newNumbers.count, 22)
        XCTAssertEqual(newNumbers.first, 0)
        print(newNumbers)
    }
}
