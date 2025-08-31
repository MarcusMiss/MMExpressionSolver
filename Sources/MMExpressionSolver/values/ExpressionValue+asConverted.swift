//
//  ExpressionValue+asConverted.swift
//  MMExpressionSolver
//

import Foundation

public extension ExpressionValue {

    /// Convert Value to Int-value if possible.
    /// - Returns: Int-value
    func asConvertedIntegerNumber() -> Optional<Int> {
        if self.type == .int {
            return Optional.some(self.value as! Int)
        } else if self.type == .float {
            return Optional.some(Int((self.value as! Float).rounded(.toNearestOrEven)))
        } else if self.type == .double {
            return Optional.some(Int((self.value as! Double).rounded(.toNearestOrEven)))
        } else if self.type == .decimal {
            return Optional.some(Int((self.value as! Decimal).toInt()))
        }
        return Optional.none
    }
    
    /// Convert Value to Double-value if possible.
    /// - Returns: Double-value
    func asConvertedDoubleNumber() -> Optional<Double> {
       if self.type == .int {
           return Optional.some(Double(self.value as! Int))
       } else if self.type == .float {
           return Optional.some(Double(self.value as! Float))
       } else if self.type == .double {
           return Optional.some(self.value as! Double)
       } else if self.type == .decimal {
           return Optional.some((self.value as! Decimal).toDouble())
       }
       return Optional.none
   }
    
    /// Convert Value to Float-value if possible.
    /// - Returns: Float-value
    func asConvertedFloatNumber() -> Optional<Float> {
        if self.type == .int {
            return Optional.some(Float(self.value as! Int))
        } else if self.type == .float {
            return Optional.some(self.value as! Float)
        } else if self.type == .double {
            return Optional.some(Float(self.value as! Double))
        } else if self.type == .decimal {
            return Optional.some(Float((self.value as! Decimal).toDouble()))
        }
        return Optional.none
    }
    
    /// Convet value to Decimal-value if possible.
    /// - Returns: Decimal-value
    func asConvertedDecimalNumber() -> Optional<Decimal> {
        if self.type == .int {
            return Optional.some(Decimal(self.value as! Int))
        } else if self.type == .float {
            return Optional.some(Double(self.value as! Float).toDecimal())
        } else if self.type == .double {
            return Optional.some(self.value as! Double)?.toDecimal()
        } else if self.type == .decimal {
            return Optional.some(self.value as! Decimal)
        }
        return Optional.none
    }

}
