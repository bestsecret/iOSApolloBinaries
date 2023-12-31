import XCTest
import ApolloCore

extension ApolloExtension where Base: XCTestExpectation {
  /// Private API for accessing the number of times an expectation has been fulfilled.
  public var numberOfFulfillments: Int {
    base.value(forKey: "numberOfFulfillments") as! Int
  }
}

extension XCTestExpectation: ApolloCompatible {}

public extension XCTestCase {
  /// Record  the specified`error` as an `XCTIssue`.
  func record(_ error: Error, compactDescription: String? = nil, file: StaticString = #filePath, line: UInt = #line) {
    var issue = XCTIssue(type: .thrownError, compactDescription: compactDescription ?? String(describing: error))

    issue.associatedError = error

    let location = XCTSourceCodeLocation(filePath: file, lineNumber: line)
    issue.sourceCodeContext = XCTSourceCodeContext(location: location)

    record(issue)
  }
  
  /// Invoke a throwing closure, and record any thrown errors without rethrowing. This is useful if you need to run code that may throw
  /// in a place where throwing isn't allowed, like `measure` blocks.
  func whileRecordingErrors(file: StaticString = #file, line: UInt = #line, _ perform: () throws -> Void) {
    do {
      try perform()
    } catch {
      // Respect XCTestErrorUserInfoKeyShouldIgnore key that is used by XCTUnwrap, XCTSkip, and our own XCTFailure.
      let shouldIgnore = (((error as NSError).userInfo["XCTestErrorUserInfoKeyShouldIgnore"] as? Bool) == true)
      if !shouldIgnore {
        record(error, file: file, line: line)
      }
    }
  }
  
  /// Wrapper around `XCTContext.runActivity` to  allow for future extension.
  func runActivity<Result>(_ name: String, perform: (XCTActivity) throws -> Result) rethrows -> Result {
    return try XCTContext.runActivity(named: name, block: perform)
  }
}

@testable import Apollo

public extension XCTestCase {
  /// Make  an `AsyncResultObserver` for receiving results of the specified GraphQL operation.
  func makeResultObserver<Operation: GraphQLOperation>(for operation: Operation, file: StaticString = #filePath, line: UInt = #line) -> AsyncResultObserver<GraphQLResult<Operation.Data>, Error> {
    return AsyncResultObserver(testCase: self, file: file, line: line)
  }
}

public protocol StoreLoading {
  var defaultWaitTimeout: TimeInterval { get }
  var store: ApolloStore! { get }
}

extension StoreLoading where Self: XCTestCase {
  public func loadFromStore<Query: GraphQLQuery>(query: Query, file: StaticString = #filePath, line: UInt = #line, resultHandler: @escaping AsyncResultObserver<GraphQLResult<Query.Data>, Error>.ResultHandler) {
    let resultObserver = makeResultObserver(for: query, file: file, line: line)
        
    let expectation = resultObserver.expectation(description: "Loaded query from store", file: file, line: line, resultHandler: resultHandler)
    
    store.load(query: query, resultHandler: resultObserver.handler)
    
    wait(for: [expectation], timeout: defaultWaitTimeout)
  }
}
