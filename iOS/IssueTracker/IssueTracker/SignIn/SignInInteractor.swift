//
//  SignInInteractor.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/10/27.
//

import Foundation
import Alamofire

struct User: Codable {
    let userID: String
    let password: String
}

protocol SignInInteractorProtocol {
    
}

final class SignInInteractor: SignInInteractorProtocol {
    
    // Id pw -> network
    // Id pw 검증 받아서 -> 결과값
    
}

/*
 Use case
 1. 로그인
    id/pw -> vc -> interactor -> network manager -> ala -> server
    response -> 성공/실패 test -> (presenter/VM) -> VC -> View

 USE CASE endpoint마다
 url / HTTPMethod / body
 
 case signIn
 // get (id, pw)
 case signUp
 // post (user 정보)
 case issueList
 // get
 case label
 // get
 case milestone
 // get

*/
