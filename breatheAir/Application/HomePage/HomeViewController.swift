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

class HomeViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var indexLabel: UILabel!
    
    @IBOutlet weak var index2Label: UILabel!
    
    @IBOutlet weak var index3Label: UILabel!
    
    @IBOutlet weak var offerTodo: UILabel!
    
    @IBOutlet weak var resultHourLabel: UILabel!
    
    @IBOutlet weak var reloadButton: UIButton!
    
    @IBOutlet weak var statusIcon: UIImageView!
    
    private var vm: HomeViewModel!
    
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initVM()
        self.binder()
       // offerTable.register(UINib(nibName: "OfferToDoTableViewCell", bundle: nil), forCellReuseIdentifier: OfferToDoTableViewCell.Identifier)
       
       // self.offerTable.layer.backgroundColor = UIColor.clear.cgColor
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.vm.run()
    }
    
    private func initVM() {
        self.vm = HomeViewModel(input: HomeViewModel.Input(data:
            Variable<Location>(LocationManager
            .shared
            .currentLocationRequest())))
    }
    
    private func style() {
        
    }
    
   
    @IBAction func refreshAction(_ sender: Any) {
        self.reloadButton.loadingIndicator(true, 1010)
        LocationManager.shared.locationManager.startUpdatingLocation()
        self.vm.run()
    }
    
    func getVm() -> HomeViewModel {
        return self.vm
    }
}

