import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(DPColorfulTags_SwiftTests.allTests),
    ]
}
#endif
