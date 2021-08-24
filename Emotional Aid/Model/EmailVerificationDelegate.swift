//
//  EmailVerificationDelegate.swift
//  Emotional Aid
//
//  Created by itay gervash on 23/08/2021.
//

import Foundation
import FirebaseAuth

protocol EmailVerificationDelegate {
    func didVerifyEmail(for user: User?)
}
