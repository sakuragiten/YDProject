//
//  SliderSheetController.swift
//  StevenNash
//
//  Created by louxunmac on 2019/4/11.
//  Copyright © 2019 gongsheng. All rights reserved.
//

import UIKit

@objc public class SliderAction : NSObject {
    
    public var title: String
    public var maxValue: Float = 1.0
    public var minValue: Float = 0.0
    
    init(title: String) {
        self.title = title
    }
    init(title: String, maxValue: Float, minValue: Float) {
        self.title = title
        self.maxValue = maxValue
        self.minValue = minValue
    }
}

private class SliderActionCell: UITableViewCell {

    var action: SliderAction? {
        didSet {
            guard let newAction = action else { return}
            titleLabel.text = newAction.title
            self.slider.maximumValue = newAction.maxValue
            self.slider.minimumValue = newAction.minValue
        }
    }
    var rx_sliderValue: ControlProperty<Float>?
    
    private let titleLabel = UILabel()
    private let slider = UISlider()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addLayout()
    }
    
    private func setupUI() {
//        backgroundColor = .clear
//        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        titleLabel.textColor = .gray
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textAlignment = .center
        
        slider.maximumValue = 1.0
        slider.minimumValue = 0.0
        slider.value = 0.0
        
        
        rx_sliderValue = slider.rx.value
        
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(slider)
        
    
    }
    
    private func addLayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(0)
        }
        slider.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.right.equalTo(-10)
            make.left.equalTo(titleLabel.snp.right).offset(10)
            make.width.equalTo(titleLabel).multipliedBy(3.6)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




@objc public class SliderSheetController: UIViewController {
    
    
    @objc public var sliderProgress : ((Int, CGFloat) -> Void)?
    @objc public var sliderTitle: String? {
        didSet {
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: pg_screenW, height: 40))
            titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
            titleLabel.textAlignment = .center
            titleLabel.textColor = .darkGray
            titleLabel.text = sliderTitle
            self.tableView.tableHeaderView = titleLabel
        }
    }
    
    fileprivate lazy var actions = [SliderAction]()
    
    fileprivate let tableView = UITableView()
    
    fileprivate let disposeBag = DisposeBag()
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.\
        setupUI()
    }
    
    @objc public init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .clear //UIColor(r: 0, g: 0, b: 0, a: 0.3)
        modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc public class func slider(title: String, actionNames: [String]) -> SliderSheetController {
        let slider = SliderSheetController()
        slider.sliderTitle = title
        slider.actions = actionNames.map { (actionName) -> SliderAction in
            return SliderAction(title: actionName)
        }
        
        return slider
    }
    
    
    
    private func setupUI() {
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(SliderActionCell.self, forCellReuseIdentifier: "SliderCell")
//        let footer = UIView(frame: CGRect(x: 0, y: 0, width: pg_screenW, height: 60));
        let footerBtn = UIButton(frame: CGRect(x: 0, y: 0, width: pg_screenW, height: 80))
        footerBtn.setTitle("取 消", for: .normal)
        footerBtn.setTitleColor(.red, for: .normal)
        footerBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        footerBtn.rx.tap.subscribe(onNext: { _ in
            self.dismiss(animated: true, completion: nil)
        }, onError: nil,
           onCompleted: nil,
           onDisposed: nil)
            .disposed(by: disposeBag)
        tableView.tableFooterView = footerBtn
        
//        if let title = self.sliderTitle {
//
//        }
        
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(300)
        }
        tableView.rx.observe(CGSize.self, "contentSize").map { (size) -> CGFloat in
            return (size?.height)!
            }.distinctUntilChanged()
            .subscribe(onNext: { (value) in
                self.tableView.snp.updateConstraints({ (make) in
                    make.height.equalTo(value)
                })
                self.tableView.isScrollEnabled = value > pg_screenH * 0.8
            }).disposed(by: disposeBag)
    }
    
}


extension SliderSheetController {
    
    @objc public func addAction(action: SliderAction) {
        
        actions.append(action)
    }
}

extension SliderSheetController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SliderCell") as! SliderActionCell
        cell.action = actions[indexPath.row]
        cell.rx_sliderValue?
            .distinctUntilChanged().subscribe({ (value) in
              self.sliderProgress?(indexPath.row, CGFloat(value.element ?? 0))
            }).disposed(by: disposeBag)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}





