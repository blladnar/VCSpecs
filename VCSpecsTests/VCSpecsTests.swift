import XCTest
@testable import VCSpecs

class VCSpecsTests: VCSpec {
    override func spec() {
        let subject = UIViewController()
        
        testViewController(subject) {
            viewAppears {
                vc("should load") {
                    XCTAssert(true)
                }
                
                vc("should have something on the screen") {
                    XCTAssert(true)
                }
            }
            
            viewDisappears {
                vc("should unload") {
                    XCTAssert(true)
                }
            }
        }
    }
}
