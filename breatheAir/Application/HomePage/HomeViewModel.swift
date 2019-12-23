//
//  HomeViewModel.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-24.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation
import RxSwift


enum StatusType: String {
    case healthy
    case sensetive
    case unhealthy
    case veryUnhealthy
    case hazardious
}

struct HomeInput {
    let data: Variable<Location>
}
struct HomeOutput {
    let result: Variable<LocationBasedResponse>
    let err: Variable<Error>
    let currentCity: PublishSubject<String> = PublishSubject<String>()
    let valueToShow: PublishSubject<String> = PublishSubject<String>()
    let typeToShow: PublishSubject<StatusType> = PublishSubject<StatusType>()
    let offerTodo: PublishSubject<[OfferToDo]> = PublishSubject<[OfferToDo]>()
    let homeViewColor: PublishSubject<String> = PublishSubject()
}
struct HomeViewModel: ViewModel {
    typealias Input = HomeInput
    typealias Output = HomeOutput
    private let service: HomeService
    private let input: Input
    let output: Output
    
    init(input: Input) {
        self.input = input
        self.output = HomeOutput(result: Variable<LocationBasedResponse>(LocationBasedResponse()),
                                 err: Variable<Error>(NSError()))
        
        self.service = HomeService(data: input.data.value,
                                   result: self.output.result,
                                   err: self.output.err)
    }
}
