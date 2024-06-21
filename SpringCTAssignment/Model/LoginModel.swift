//
//  LoginModel.swift
//  SpringCTAssignment
//
//  Created by Moumita Paul Ghosh on 21/06/24.
//

import Foundation

struct LoginModel: Decodable {
    let page:Int?
    let per_page:Int?
    let total:Int?
    let total_pages: Int?
    let data: [UserModel]

}
struct UserModel:Decodable{
    let id: Int
    let name: String
    let year: Int
    let color :String
    let pantone_value: String
}
