//
//  Futures.swift
//  GrippedAthletics
//
//  Created by Andrew Mclean on 12/8/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import Result

public struct AnyError: Error {
    public let cause: Error
    
    public init(cause: Error) {
        self.cause = cause
    }
}

extension AnyError: ErrorProtocolConvertible {
    
    public static func error(from error: Swift.Error) -> AnyError {
        return AnyError(cause: error)
    }
}

