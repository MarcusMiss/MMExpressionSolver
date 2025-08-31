//
//  MockTypes.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

class FooClazz: Hashable, Equatable {
    
    var attribute1: String = ""
    var attribute2: Int = 100

    init() {
    }

    init(attribute1: String, attribute2: Int) {
        self.attribute1 = attribute1
        self.attribute2 = attribute2
    }

    // MARK: - Protocol Equatable

    public static func == (lhs: FooClazz, rhs: FooClazz) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    // MARK: - Protocol Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.attribute1)
        hasher.combine(self.attribute2)
    }

}

struct FooStruct: Hashable, Equatable {

    var attribute1: String = ""
    var attribute2: Int = 100

    init() {
    }

    init(attribute1: String, attribute2: Int) {
        self.attribute1 = attribute1
        self.attribute2 = attribute2
    }

    // MARK: - Protocol Equatable

    public static func == (lhs: FooStruct, rhs: FooStruct) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    // MARK: - Protocol Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.attribute1)
        hasher.combine(self.attribute2)
    }

}

struct TypeDStruct {
    var d1: Int = 0
    var d2: String = ""
    var d3: (String, Int, String, Bool) = ("", 0, "", false)
}

struct TypeCStruct {
    var c1: Int = 0
    var c2: String = ""
    var c3: TypeDStruct
}

struct TypeBStruct {
    var b1: Int = 0
    var b2: String = ""
    var b3: TypeCStruct
}

struct TypeAStruct {
    var a1: Int = 0
    var a2: String = ""
    var a3: TypeBStruct
}
