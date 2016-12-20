//
//  ClimbingGrades.swift
//  GrippedAthletics
//
//  Created by Andrew Mclean on 12/19/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import Foundation

struct Grades {
    
    enum Australian : String {
        case One = "1"
        case Two = "2"
        case Three = "3"
        case Four = "4"
        case Five = "5"
        case Six = "6"
        case Seven = "7"
        case Eight = "8"
        case Nine = "9"
        case Ten = "10"
        case Eleven = "11"
        case Twelve = "12"
        case Thirteen = "13"
        case Fourteen = "14"
        case Fiveteen = "15"
        case Sixteen = "16"
        case Seventeen = "17"
        case Eighteen = "18"
        case Nineteen = "19"
        case Twenty = "20"
        case TwentyOne = "21"
        case TwentyTwo = "22"
        case TwentyThree = "23"
        case TwentyFour = "24"
        case TwentyFive = "25"
        case TwentySix = "26"
        case TwentySeven = "27"
    }
    
    enum Yosemite : String {
        
        case Five0     = "5.0"
        case Five1     = "5.1"
        case Five2     = "5.2"
        case Five3     = "5.3"
        case Five4     = "5.4"
        case Five5     = "5.5"
        case Five6     = "5.6"
        
        case Five7m    = "5.7-"
        case Five7     = "5.7"
        case Five7p    = "5.7+"
        
        case Five8m    = "5.8-"
        case Five8     = "5.8"
        case Five8p    = "5.8+"
        
        case Five9m    = "5.9-"
        case Five9     = "5.9"
        case Five9p    = "5.9+"
        
        case Five10m   = "5.10-"
        case Five10    = "5.10"
        case Five10p   = "5.10+"
        case Five10a   = "5.10a"
        case Five10ab  = "5.10a/b"
        case Five10b   = "5.10b"
        case Five10bc  = "5.10b/c"
        case Five10c   = "5.10c"
        case Five10cd  = "5.10c/d"
        case Five10d   = "5.10d"
        
        case Five11m   = "5.11-"
        case Five11    = "5.11"
        case Five11p   = "5.11+"
        case Five11a   = "5.11a"
        case Five11ab  = "5.11a/b"
        case Five11b   = "5.11b"
        case Five11bc  = "5.11b/c"
        case Five11c   = "5.11c"
        case Five11cd  = "5.11c/d"
        case Five11d   = "5.11d"
        
        case Five12m   = "5.12-"
        case Five12    = "5.12"
        case Five12p   = "5.12+"
        case Five12a   = "5.12a"
        case Five12ab  = "5.12a/b"
        case Five12b   = "5.12b"
        case Five12bc  = "5.12b/c"
        case Five12c   = "5.12c"
        case Five12cd  = "5.12c/d"
        case Five12d   = "5.12d"
        
        case Five13a   = "5.13a"
        case Five13ab  = "5.13a/b"
        case Five13b   = "5.13b"
        case Five13bc  = "5.13b/c"
        case Five13c   = "5.13c"
        case Five13cd  = "5.13c/d"
        case Five13d   = "5.13d"
        
        case Five14a   = "5.14a"
        case Five14ab  = "5.14a/b"
        case Five14b   = "5.14b"
        case Five14bc  = "5.14b/c"
        case Five14c   = "5.14c"
        case Five14cd  = "5.14c/d"
        case Five14d   = "5.14d"
        
        case Five15a   = "5.15a"
        case Five15ab  = "5.15a/b"
        case Five15b   = "5.15b"
        case Five15bc  = "5.15b/c"
        case Five15c   = "5.15c"
        case Five15cd  = "5.15c/d"
        case Five15d   = "5.15d"
    }
    
    enum French : String {
        case FourA = "4a"
        case FourB = "4b"
        case FourC = "4c"
        case FourD = "4d"
        case FiveA = "5a"
        case FiveB = "5b"
        case FiveC = "5c"
        case FiveD = "5d"
        case SixA = "6a"
        case SixB = "6b"
        case SixC = "6c"
        case SixD = "6d"
        case SevenA = "7a"
        case SevenB = "7b"
        case SevenC = "7c"
        case SevenD = "7d"
        case EightA = "8a"
        case EightB = "8b"
        case EightC = "8c"
        case EightD = "8d"
        case NineA = "9a"
        case NineB = "9b"
        case NineC = "9c"
        case NineD = "9d"
    }
    
    enum VGrade : String {
        case VB = "VB"
        case V0 = "V0"
        case V1 = "V1"
        case V2 = "V2"
        case V3 = "V3"
        case V4 = "V4"
        case V5 = "V5"
        case V6 = "V6"
        case V7 = "V7"
        case V8 = "V8"
        case V9 = "V9"
        case V10 = "V10"
        case V11 = "V11"
        case V12 = "V12"
        case V13 = "V13"
        case V14 = "V14"
        case V15 = "V15"
        case V16 = "V16"
    }
    
    static var matrix : [Grade] {
        var m = [Grade]()
        
        m.append(Grade(a: .One, y: .Five0, f: .FourA, v: .VB))
        
        return m
    }
    
    struct Grade {
        var australian: Australian
        var yosemite: Yosemite
        var french: French
        var v: VGrade
        
        init(a:Australian, y:Yosemite, f: French, v:VGrade) {
            self.australian = a
            self.yosemite = y
            self.french = f
            self.v = v
        }
    }

}

