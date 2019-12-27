//
//  HomeViewModel.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-24.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation
import RxSwift





struct HomeInput {
    let data: Variable<Location>
}
struct HomeOutput {
    let result: Variable<LocationBasedResponse>
    let err: Variable<Error>
    let currentCity: PublishSubject<String> = PublishSubject<String>()
    let valueTo1Show: PublishSubject<String> = PublishSubject<String>()
    let valueTo2Show: PublishSubject<String> = PublishSubject<String>()
    let valueTo3Show: PublishSubject<String> = PublishSubject<String>()
    let lastDate: PublishSubject<String> = PublishSubject<String>()
    let typeToShow: PublishSubject<StatusType> = PublishSubject<StatusType>()
    let offerTodo: PublishSubject<OfferToDo> = PublishSubject<OfferToDo>()
    let imageAssets: PublishSubject<UIImage> = PublishSubject()
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
            self.service.run_request()
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
                print(err.localizedDescription)
                self
                    .output
                    .errorMessage
                    .onNext("Network_Error".localized())
            })
            .disposed(by: disposeBag)
    }
    
    private func publish(data value: LocationBasedResponse) {
        self.output.offerTodo.onNext(value.offerToDo.first!)
        self.output.currentCity.onNext(value.location.name)
        self.output.valueTo1Show.onNext("PM2.5 :    \(value.data.pm2) AQI")
        self.output.valueTo2Show.onNext("PM10 :     \(value.data.pm10) AQI")
        self.output.valueTo3Show.onNext("CO :       \(value.data.co2) AQI")
        let type = StatusType.getType(by: value.data.AQIIndex)
        self.output.typeToShow.onNext(type)
        self.output.imageAssets.onNext(type.getImageAsset(type: type))
        self.output.homeViewColor.onNext(type.getColor(type: type))
        self.output.lastDate.onNext("\(timeAgoSince(value.date))")
        
    }
}
