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
    
    enum UIAA : String {
        case I = "I"
        case II = "II"
        case III = "III"
        case IVm = "IV-"
        case IV = "IV"
        case IVp = "IV+"
        case Vm = "V-"
        case V = "V"
        case Vp = "V+"
        case VIm = "VI-"
        case VI = "VI"
        case VIp = "VI+"
        case VIIm = "VII-"
        case VII = "VII"
        case VIIp = "VII+"
        case VIIIm = "VIII-"
        case VIII = "VIII"
        case VIIIp = "VIII+"
        case IXm = "IX-"
        case IX = "IX"
        case IXp = "IX+"
        case Xm = "X-"
        case X = "X"
        case Xp = "X+"
        case XIm = "XI-"
        case XI = "XI"
        case XIp = "XI+"
        case XIIm = "XII-"
    }
    
    struct NorthAmerica {
        
        struct FullGrade {
            var difficultyClass : Class
            var subgrade : Subgrade?
        }
        
        enum Class : String {
            case Five0     = "5.0"
            case Five1     = "5.1"
            case Five2     = "5.2"
            case Five3     = "5.3"
            case Five4     = "5.4"
            case Five5     = "5.5"
            case Five6     = "5.6"
            case Five7     = "5.7"
            case Five8     = "5.8"
            case Five9     = "5.9"
            case Five10    = "5.10"
            case Five11    = "5.11"
            case Five12    = "5.12"
            case Five13   = "5.13"
            case Five14  = "5.14"
            case Five15   = "5.15"
        }
        
        enum Subgrade : String {
            
            case plus = "+"
            case minus = "-"
            case a = "a"
            case ab = "a/b"
            case b = "b"
            case bc = "b/c"
            case c = "c"
            case cd = "c/d"
            case d = "d"
            
        }
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
    
    enum Hueco : String {
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
        
//        m.append(Grade(a: .Three, na: .Five0, f: .FourA, h: .VB))
        
        return m
    }
    
    struct Grade {
        var australian: Australian
        var northAmerican: NorthAmerica
        var french: French
        var hueco: Hueco
        
        init(a:Australian, na:NorthAmerica, f: French, h:Hueco) {
            self.australian = a
            self.northAmerican = na
            self.french = f
            self.hueco = h
        }
    }

}

