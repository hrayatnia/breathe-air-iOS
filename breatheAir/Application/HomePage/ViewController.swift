//
//  ViewController.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-23.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var offerTable: UITableView!
    
    @IBOutlet weak var resultHourLabel: UILabel!
    
    private var vm: HomeViewModel!
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initVM()
        
        offerTable.register(UINib(nibName: "OfferToDoTableViewCell", bundle: nil), forCellReuseIdentifier: OfferToDoTableViewCell.Identifier)
        
        self.binder()
        
    }
    
    private func initVM() {
        self.vm = HomeViewModel(input: HomeViewModel.Input(data:
            Variable<Location>(LocationManager
            .shared
            .currentLocationRequest())))
    }
    
    private func style() {
        
    }
    
    private func binder() {
        self.bindCityLabel()
        self.bindStatus()
        self.bindIndexLabel()
        self.bindOfferTable()
        self.bindBackgroundColor()
        self.bindErrorMessage()
        self.bindLastDate()
    }
    
    private func bindCityLabel() {
        self
            .vm
            .output
            .currentCity
            .asObservable()
            .map { $0 }
            .bind(to: self.cityLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func bindIndexLabel() {
        self
           .vm
           .output
           .valueToShow
           .asObservable()
           .map { $0 }
           .bind(to: self.cityLabel.rx.text)
           .disposed(by: disposeBag)
    }
    
    private func bindStatus() {
        self
            .vm
            .output
            .typeToShow
            .asObservable()
            .map {$0.rawValue}
            .bind(to: self.status.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func bindBackgroundColor() {
        self
            .vm
            .output
            .homeViewColor
            .asObservable()
            .map{ UIColor(hexStr: $0)}
            .bind(to: self.view.rx.backgroundColor)
            .disposed(by: disposeBag)
    }
    
    private func bindOfferTable() {
        self
        .vm
        .output
         .offerTodo
         .asObservable().bind(to:
             offerTable
                 .rx
                 .items(cellIdentifier: OfferToDoTableViewCell.Identifier,
               cellType: OfferToDoTableViewCell.self)) {  (row,data,cell) in
         
             cell.cellData = data
         }
        .disposed(by: disposeBag)
        
    }
    
    private func bindErrorMessage() {
        self
            .vm
            .output
            .errorMessage
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{
                data in
                self.view.makeToast(data)
            }).disposed(by: disposeBag)
    }
    
    private func bindLastDate() {
        self
            .vm
            .output
            .lastDate
            .asObservable()
            .bind(to: self.resultHourLabel.rx.text)
            .disposed(by: disposeBag)
    }


}

