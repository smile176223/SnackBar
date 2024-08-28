import XCTest
@testable import SnackBar

final class SnackBarParametersTests: XCTestCase {
    
    func test_updateParameters_successfully() {
        let parameters = SnackBarParameters()
        
        let updateParameters = parameters
            .position(.top)
            .animation(.easeIn)
            .padding(30)
        
        XCTAssertEqual(updateParameters.position, .top)
        XCTAssertEqual(updateParameters.animation, .easeIn)
        XCTAssertEqual(updateParameters.padding, 30)
    }
}
