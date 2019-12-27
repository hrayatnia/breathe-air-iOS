//
//  MapPageViewModel.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-28.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation
import RxSwift
import CoreLocation

struct MapPageInput {
    
}

struct MapPageOutput {
    let annotations: PublishSubject<[Artwork]>
    let response: Variable<MapPageResponse> = Variable<MapPageResponse>(MapPageResponse(uuid: "",
                                                                                                date: Date(),
                                                                                                error: nil,
                                                                                                data: []))
    let err: Variable<Error> = Variable<Error>(NSError())
}


struct MapPageViewModel: ViewModel {
    typealias Input = MapPageInput
    
    typealias Output = MapPageOutput
    
    let output:MapPageViewModel.Output
    
    private let disposeBag = DisposeBag()
    private let service: MapPageService
    
    init(input: Input) {
        self.output = MapPageOutput(annotations: PublishSubject())
        self.service = MapPageService(result:self.output.response ,
                                      err: self.output.err)
        
        self.responseListener()
        self.errorListener()
        self.service.run_request()
    }
    
    private func responseListener() {
        self
            .output
            .response
            .asObservable()
            .skip(1)
            .subscribe(onNext: {
                response in
                self.processResponse(response: response)
            }).disposed(by: disposeBag)
    }
    
    private func errorListener() {
        self
            .output
            .err
            .asObservable()
            .skip(1)
            .subscribe(onNext: {
                error in
            }).disposed(by: disposeBag)
    }
    
    private func processResponse(response: MapPageResponse) {
        var data:[Artwork] = []
        response.data.map {
           _ = data.append(Artwork(title: $0.name, locationName: ("AQI Index: \($0.AQI)"), discipline: "", coordinate: CLLocationCoordinate2D(latitude: $0.lat,longitude: $0.lon) , type: .healthy))
        }
        self.output.annotations.onNext(data)
    }
    
    
}
