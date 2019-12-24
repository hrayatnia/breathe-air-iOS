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
    case healthy = "healthy"
    case moderate = "moderate"
    case sensetive = "sensetive"
    case unhealthy = "unhealthy"
    case veryUnhealthy = "veryUnhealthy"
    case hazardious = "hazardious"
    static func getType(by value: Double) -> StatusType {
        if value > 0 && value < 51 {
            return StatusType.healthy
        }else if value < 101 {
            return StatusType.moderate
        }else if value < 151 {
            return StatusType.sensetive
        }else if value < 200 {
            return StatusType.unhealthy
        }else if value < 300 {
            return StatusType.veryUnhealthy
        } else {
            return StatusType.hazardious
        }
    }
    func getColor(type: StatusType) -> String {
        switch type {
        case .healthy:
            return "#2E7F18"
        case .moderate:
            return "#45731E"
        case .sensetive:
            return "#675E24"
        case .unhealthy:
            return "#8D472B"
        case .veryUnhealthy:
            return "#B13433"
        case .hazardious:
            return "#C82538"
            
        }
    }
}

struct HomeInput {
    let data: Variable<Location>
}
struct HomeOutput {
    let result: Variable<LocationBasedResponse>
    let err: Variable<Error>
    let currentCity: PublishSubject<String> = PublishSubject<String>()
    let valueToShow: PublishSubject<String> = PublishSubject<String>()
    let lastDate: PublishSubject<String> = PublishSubject<String>()
    let typeToShow: PublishSubject<StatusType> = PublishSubject<StatusType>()
    let offerTodo: PublishSubject<[OfferToDo]> = PublishSubject<[OfferToDo]>()
    let homeViewColor: PublishSubject<String> = PublishSubject()
    let errorMessage: PublishSubject<String> = PublishSubject()
}
struct HomeViewModel: ViewModel {
    typealias Input = HomeInput
    typealias Output = HomeOutput
    private var service: HomeService
    private let input: Input
    private let disposeBag = DisposeBag()
    let output: Output
    
    init(input: Input) {
        self.input = input
        self.output = HomeOutput(result: Variable<LocationBasedResponse>(LocationBasedResponse()),
                                 err: Variable<Error>(NSError()))
        
        self.service = HomeService(data: input.data.value,
                                   result: self.output.result,
                                   err: self.output.err)
        
        self.responseListener()
        self.errorListener()
        self.locationListener()
    }
    
    public mutating func run() {
        self.service.data = LocationManager.shared.currentLocationRequest()
        self.service.run_request()
    }
    
    private func locationListener() {
        LocationManager.shared.locationUpdated.asObservable().subscribe(onNext: {
            location in
            self.output.currentCity.onNext(LocationManager.shared.city ?? "")
        }).disposed(by: disposeBag)
    }
    
    private func responseListener() {
        self
            .output
            .result
            .asObservable()
            .skip(1)
            .subscribe(onNext: {
            data in
                self.publish(data: data)
            }).disposed(by: disposeBag)
    }
    
    private func errorListener() {
        self
            .output
            .err
            .asObservable()
            .skip(1)
            .subscribe(onNext: {
                err in
                self
                    .output
                    .errorMessage
                    .onNext("Network_Error".localized())
            })
            .disposed(by: disposeBag)
    }
    
    private func publish(data value: LocationBasedResponse) {
        self.output.offerTodo.onNext(value.offerToDo)
        self.output.currentCity.onNext(value.location.name)
        self.output.valueToShow.onNext("\(value.data.pm10)")
        let type = StatusType.getType(by: value.data.pm10)
        self.output.typeToShow.onNext(type)
        self.output.homeViewColor.onNext(type.getColor(type: type))
        
    }
}
