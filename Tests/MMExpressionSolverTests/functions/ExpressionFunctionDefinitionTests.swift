//
//  ExpressionFunctionDefinitionTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionFunctionDefinition")
class ExpressionFunctionDefinitionTests {

    @Test("ExpressionFunctionDefinition without Parameters")
    func validateInitWithoutParameters() async throws {
        let fd: ExpressionFunctionDefinition = ExpressionFunctionDefinition(name: "FUNC1", parameters: [])
        #expect(fd.name == "FUNC1")
        #expect(fd.parameters.isEmpty == true)
        #expect(fd.hasVarsArgs == false)
        print("\(fd.description)")
        print("\(fd.debugDescription)")
        //#expect(p.description == "")
        //#expect(p.debugDescription == "")
    }

    @Test("Initialization with Parameters")
    func validateInitParameters() async throws {
        let fd: ExpressionFunctionDefinition = ExpressionFunctionDefinition(name: "FUNC2", parameters: [
            ExpressionFunctionParameter(name: "P1", strictTypes: [.string])
        ])
        #expect(fd.name == "FUNC2")
        #expect(fd.parameters.isEmpty == false)
        #expect(fd.hasVarsArgs == false)
        print("\(fd.description)")
        print("\(fd.debugDescription)")
        //#expect(p.description == "")
        //#expect(p.debugDescription == "")
    }

    @Test("Initialization with Parameters (2)")
    func validateInitParameters2() async throws {
        let fd: ExpressionFunctionDefinition = ExpressionFunctionDefinition(name: "FUNC3", parameters: [
            ExpressionFunctionParameter(name: "P1", strictTypes: [.decimal]),
            ExpressionFunctionParameter(name: "P2", strictTypes: [.decimal], isVarArg: true)
        ])
        #expect(fd.name == "FUNC3")
        #expect(fd.parameters.isEmpty == false)
        #expect(fd.hasVarsArgs == true)
        print("\(fd.description)")
        print("\(fd.debugDescription)")
        //#expect(p.description == "")
        //#expect(p.debugDescription == "")
    }

}
