
@objc(VCTest)
class VCTest: NSObject {
    init(name: String, _ test: @escaping ()->()) {
        self.test = test
        self.name = name
    }
    
    func run() {
        test()
    }
    
    private var test: ()->()
    var name: String
}

public func vc(_ description: String, _ test:@escaping ()->()) {
    VCTestHolder.shared.add(test: VCTest(name:description, test))
}

public func viewAppears(_ test:@escaping ()->()) {
    VCTestHolder.shared.addAppear()
    test()
}

public func viewDisappears(_ test:@escaping ()->()) {
    VCTestHolder.shared.addDisappear()
    test()
}

public func testViewController(_ viewController: UIViewController, _ test: ()->()) {
    VCTestHolder.shared.currentViewController = viewController
    test()
}
