//
//  ExpressionValue+compareTestsswift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionValue compare-Operators Tests")
class ExpressionValueCOmpareOperatorsTests {

    let past: Date = Date.distantPast
    let now: Date = Date.now

    @Test("Validate ==")
    func validateEqual() async throws {
        #expect((ExpressionValue.ofNil() == ExpressionValue.ofNil()) == true)
        #expect((ExpressionValue.of(100) == ExpressionValue.of(100)) == true)
        #expect((ExpressionValue.of("Lorem") == ExpressionValue.of("Lorem")) == true)
        #expect((ExpressionValue.of(false) == ExpressionValue.of(false)) == true)
        #expect((ExpressionValue.of(false) == ExpressionValue.of(true)) == false)
        #expect((ExpressionValue.of(true) == ExpressionValue.of(false)) == false)
        #expect((ExpressionValue.of(true) == ExpressionValue.of(true)) == true)
        #expect((ExpressionValue.of(now) == ExpressionValue.of(now)) == true)
        #expect((ExpressionValue.of(FooStruct()) == ExpressionValue.of(FooStruct())) == true)
        #expect((ExpressionValue.of("") == ExpressionValue.of(false)) == false)
    }

    @Test("Validate !=")
    func validateNotEqual() async throws {
        #expect((ExpressionValue.ofNil() != ExpressionValue.of(true)) == true)
        #expect((ExpressionValue.of(false) != ExpressionValue.ofNil()) == true)
        #expect((ExpressionValue.of("Lorem") != ExpressionValue.of("Ipsum")) == true)
        #expect((ExpressionValue.of(false) != ExpressionValue.of(false)) == false)
        #expect((ExpressionValue.of(false) != ExpressionValue.of(true)) == true)
        #expect((ExpressionValue.of(true) != ExpressionValue.of(false)) == true)
        #expect((ExpressionValue.of(true) != ExpressionValue.of(true)) == false)
        #expect((ExpressionValue.of(now) != ExpressionValue.of(past)) == true)
        #expect((ExpressionValue.of(FooStruct()) != ExpressionValue.of(FooClazz())) == true)
        #expect((ExpressionValue.of("") != ExpressionValue.of(false)) == true)
    }

    @Test("Validate >=")
    func validateEqualGreat() async throws {
        #expect((ExpressionValue.ofNil() >= ExpressionValue.ofNil()) == true)
        #expect((ExpressionValue.of(200) >= ExpressionValue.of(100)) == true)
        #expect((ExpressionValue.of(200) >= ExpressionValue.of(200)) == true)
        #expect((ExpressionValue.of("Lorem") >= ExpressionValue.of("Ipsum")) == true)
        #expect((ExpressionValue.of("Lorem") >= ExpressionValue.of("Lorem")) == true)
        #expect((ExpressionValue.of(false) >= ExpressionValue.of(false)) == true)
        #expect((ExpressionValue.of(false) >= ExpressionValue.of(true)) == false)
        #expect((ExpressionValue.of(true) >= ExpressionValue.of(false)) == true)
        #expect((ExpressionValue.of(true) >= ExpressionValue.of(false)) == true)
        #expect((ExpressionValue.of(now) >= ExpressionValue.of(past)) == true)
        #expect((ExpressionValue.of(now) >= ExpressionValue.of(now)) == true)
        #expect((ExpressionValue.of(FooStruct())! >= ExpressionValue.of(FooStruct())!) == true)
        #expect((ExpressionValue.of("Lorem") >= ExpressionValue.of(10)) == false)
    }

    @Test("Validate <=")
    func validateEqualLess() async throws {
        #expect((ExpressionValue.ofNil() <= ExpressionValue.ofNil()) == true)
        #expect((ExpressionValue.of(100) <= ExpressionValue.of(200)) == true)
        #expect((ExpressionValue.of(200) <= ExpressionValue.of(200)) == true)
        #expect((ExpressionValue.of("Ipsum") <= ExpressionValue.of("Lorem")) == true)
        #expect((ExpressionValue.of("Lorem") <= ExpressionValue.of("Lorem")) == true)
        #expect((ExpressionValue.of(false) <= ExpressionValue.of(false)) == true)
        #expect((ExpressionValue.of(false) <= ExpressionValue.of(true)) == true)
        #expect((ExpressionValue.of(true) <= ExpressionValue.of(false)) == false)
        #expect((ExpressionValue.of(true) <= ExpressionValue.of(false)) == false)
        #expect((ExpressionValue.of(past) <= ExpressionValue.of(now)) == true)
        #expect((ExpressionValue.of(now) <= ExpressionValue.of(now)) == true)
        #expect((ExpressionValue.of(FooStruct())! <= ExpressionValue.of(FooStruct())!) == true)
        #expect((ExpressionValue.of("Lorem") <= ExpressionValue.of(10)) == false)
    }

    @Test("Validate >")
    func validateGreat() async throws {
        #expect((ExpressionValue.ofNil() > ExpressionValue.ofNil()) == false)
        #expect((ExpressionValue.of(200) > ExpressionValue.of(100)) == true)
        #expect((ExpressionValue.of(200) > ExpressionValue.of(200)) == false)
        #expect((ExpressionValue.of("Lorem") > ExpressionValue.of("Ipsum")) == true)
        #expect((ExpressionValue.of("Lorem") > ExpressionValue.of("Lorem")) == false)
        #expect((ExpressionValue.of(false) > ExpressionValue.of(false)) == false)
        #expect((ExpressionValue.of(false) > ExpressionValue.of(true)) == false)
        #expect((ExpressionValue.of(true) > ExpressionValue.of(false)) == true)
        #expect((ExpressionValue.of(true) > ExpressionValue.of(true)) == false)
        #expect((ExpressionValue.of(now) > ExpressionValue.of(past)) == true)
        #expect((ExpressionValue.of(now) > ExpressionValue.of(now)) == false)
        #expect((ExpressionValue.of(FooStruct())! > ExpressionValue.of(FooStruct())!) == false)
    }

    @Test("Validate <")
    func validateLess() async throws {
        #expect((ExpressionValue.ofNil() < ExpressionValue.ofNil()) == false)
        #expect((ExpressionValue.of(100) < ExpressionValue.of(200)) == true)
        #expect((ExpressionValue.of(200) < ExpressionValue.of(200)) == false)
        #expect((ExpressionValue.of("Ipsum") < ExpressionValue.of("Lorem") ) == true)
        #expect((ExpressionValue.of("Lorem") < ExpressionValue.of("Lorem")) == false)
        #expect((ExpressionValue.of(false) < ExpressionValue.of(false)) == false)
        #expect((ExpressionValue.of(false) < ExpressionValue.of(true)) == true)
        #expect((ExpressionValue.of(true) < ExpressionValue.of(false)) == false)
        #expect((ExpressionValue.of(true) < ExpressionValue.of(true)) == false)
        #expect((ExpressionValue.of(past) < ExpressionValue.of(now)) == true)
        #expect((ExpressionValue.of(now) < ExpressionValue.of(now)) == false)
        #expect((ExpressionValue.of(FooStruct())! < ExpressionValue.of(FooStruct())!) == false)
    }

}
