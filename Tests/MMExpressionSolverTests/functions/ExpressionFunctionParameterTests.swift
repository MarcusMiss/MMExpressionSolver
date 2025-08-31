//
//  ExpressionFunctionParameterTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionFunctionParameter")
class ExpressionFunctionParameterTests {

    @Test("Initialization of ExpressionFunctionParameter")
    func validateInit() async throws {
        let p: ExpressionFunctionParameter = ExpressionFunctionParameter(name: "name", strictTypes: [.string, .null], isLazy: true, isVarArg: false)
        #expect(p.name == "name")
        #expect(p.strictTypes == [.string, .null])
        #expect(p.allowNull == true)
        #expect(p.isLazy == true)
        #expect(p.isVarArg == false)
        #expect(p == ExpressionFunctionParameter(name: "name" ,strictTypes: [.string, .null], isLazy: true, isVarArg: false))
        print("\(p.description)")
        print("\(p.debugDescription)")
        #expect(p.description.isEmpty == false)
        #expect(p.debugDescription.isEmpty == false)
    }

    @Test("Initialization of ExpressionFunctionParameter with Defaults")
    func validateDefaults() async throws {
        let p: ExpressionFunctionParameter = ExpressionFunctionParameter(name: "name")
        #expect(p.name == "name")
        #expect(p.strictTypes.isEmpty == true)
        #expect(p.allowNull == false)
        #expect(p.isLazy == false)
        #expect(p.isVarArg == false)
        print("\(p.description)")
        print("\(p.debugDescription)")
        #expect(p.description.isEmpty == false)
        #expect(p.debugDescription.isEmpty == false)
    }

}
