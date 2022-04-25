//
//  Poke+String.swift
//  ProjectMVVM
//
//  Created by MAC17 on 23/04/22.
//

import Foundation

class HelperString{
    static func getIdFromUrl(url:String)-> String{
        return url.components(separatedBy: "/").filter({ $0 != ""}).last!
    }		
}
