//
//  HomeViewController+Binder.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-25.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation
import RxSwift


extension HomeViewController {
    func binder() {
        self.bindCityLabel()
        self.bindStatus()
        self.bindIndexLabel()
        self.bindIndex2Label()
        self.bindIndex3Label()
        self.bindOfferLabel()
        self.bindBackgroundColor()
        self.bindErrorMessage()
        self.bindLastDate()
        self.bindImageView()
    }
    
    private func bindCityLabel() {
        self
            .getVm()
            .output
            .currentCity
            .asObservable()
            .map { $0 }
            .bind(to: self.cityLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func bindIndexLabel() {
        self
            .getVm()
            .output
            .valueTo1Show
            .asObservable()
            .map { $0 }
            .bind(to: self.indexLabel.rx.text)
            .disposed(by: disposeBag)
        self
        .getVm()
        .output
        .valueTo1Show
        .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                data in
                self.reloadButton.loadingIndicator(false, 1010)
            })
        .disposed(by: disposeBag)
    }
    
    private func bindIndex2Label() {
        self
            .getVm()
            .output
            .valueTo2Show
            .asObservable()
            .map { $0 }
            .bind(to: self.index2Label.rx.text)
            .disposed(by: disposeBag)
    }
    private func bindIndex3Label() {
        self
            .getVm()
            .output
            .valueTo3Show
            .asObservable()
            .map { $0 }
            .bind(to: self.index3Label.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func bindStatus() {
        self
            .getVm()
            .output
            .typeToShow
            .asObservable()
            .map {$0.rawValue}
            .bind(to: self.status.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func bindBackgroundColor() {
        self
            .getVm()
            .output
            .homeViewColor
            .asObservable()
            .map{ UIColor(hexStr: $0)}
            .bind(to: self.view.rx.backgroundColor)
            .disposed(by: disposeBag)
    }
    
    private func bindOfferLabel() {
        self
            .getVm()
            .output
            .offerTodo.map { $0.text }
            .asObservable()
            .bind(to: self.offerTodo.rx.text)
            .disposed(by: disposeBag)
       
    }
    
    private func bindErrorMessage() {
        self
            .getVm()
            .output
            .errorMessage
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{
                data in
                self.view.makeToast(data)
                self.reloadButton.loadingIndicator(false, 1010)
            }).disposed(by: disposeBag)
    }
    
    private func bindLastDate() {
        self
            .getVm()
            .output
            .lastDate
            .asObservable()
            .bind(to: self.resultHourLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func bindImageView() {
        self
            .getVm()
            .output
            .imageAssets
            .asObservable()
            .bind(to: self.statusIcon.rx.image)
            .disposed(by: disposeBag)
    }
    
    
}
