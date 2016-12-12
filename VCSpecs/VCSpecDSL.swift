
public class VCTest: NSObject {
    init(name: String, _ test: @escaping ()->()) {
        self.test = test
        self.name = name
    }
    
    public func run() {
        test()
    }
    
    private var test: ()->()
    public var name: String
}

func vc(_ description: String, _ test:@escaping ()->()) {
    VCTestHolder.shared.add(test: VCTest(name:description, test))
}

func viewAppears(_ test:@escaping ()->()) {
    VCTestHolder.shared.addAppear()
    test()
}

func viewDisappears(_ test:@escaping ()->()) {
    VCTestHolder.shared.addDisappear()
    test()
}

func testViewController(_ viewController: UIViewController, _ test: ()->()) {
    VCTestHolder.shared.currentViewController = viewController
    test()
}
