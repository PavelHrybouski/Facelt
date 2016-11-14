//
//  FacialExpression.swift
//  Facelt
//
//  Created by Pavel Hrybouski on 13.11.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

import Foundation
struct FacialExpression {
    enum Eyes: Int {
        case Open
        case Closed
        case Squinting
    }
    enum EyeBrows: Int {
        case Relaxed
        case Normal
        case Furrowed
        func moreRalaxedBrow() -> EyeBrows {
            return EyeBrows(rawValue: hashValue - 1) ?? .Relaxed
        }
        func moreFurrowedBrow() -> EyeBrows {
            return EyeBrows(rawValue: hashValue + 1) ?? .Furrowed
        }
    }
    
    enum Mouth: Int {
        case Frown
        case Smirk
        case Neutral
        case Grin
        case Smile
        func sadderMouth() -> Mouth {
            return Mouth(rawValue: hashValue - 1) ?? .Frown
        }
        func happierMouth() -> Mouth {
            return Mouth(rawValue: hashValue + 1) ?? .Smile
        }
    }
    var mouth: Mouth
    var eyes: Eyes
    var eyeBrows: EyeBrows
    
}
