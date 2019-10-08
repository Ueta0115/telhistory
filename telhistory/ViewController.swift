//
//  ViewController.swift
//  telhistory
//
//  Created by USER on 2019/10/03.
//  Copyright © 2019 n1system. All rights reserved.
//
import UIKit
class ViewController: UIViewController,UIPickerViewDelegate{
    //Label
    @IBOutlet var MaineTitle: UILabel!
    @IBOutlet weak var DayLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var CanpanyNameLabel: UILabel!
    @IBOutlet weak var ResponsibleLabel: UILabel!
    @IBOutlet weak var DestinationLabel: UILabel!
    @IBOutlet weak var ContentLabel: UILabel!
    @IBOutlet weak var ReceptionLabel: UILabel!
    //テキストフィールド
    @IBOutlet weak var Register_d: UITextField!
    @IBOutlet weak var Register_t: UITextField!
    @IBOutlet weak var Com_Name: UITextView!
    @IBOutlet weak var Com_Menber: UITextField!
    @IBOutlet weak var To_Name: UITextField!
    @IBOutlet weak var Content: UITextView!
    @IBOutlet weak var Recepter: UITextField!
    //ボタン
    @IBOutlet weak var AutoInputAccessory: UIButton!
    @IBOutlet weak var GoNextAccessory: UIButton!
    //
    let userDefaults = UserDefaults.standard
    let date:Date = Date()
    var datePicker = UIDatePicker()
    var dP = UIDatePicker()
   
    let a = true
    let b = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Register_d.layer.borderColor = UIColor.black.cgColor
        Register_t.layer.borderColor = UIColor.black.cgColor
        Com_Name.layer.borderColor = UIColor.black.cgColor
        Com_Menber.layer.borderColor = UIColor.black.cgColor
        To_Name.layer.borderColor = UIColor.black.cgColor
        Content.layer.borderColor = UIColor.black.cgColor
        Recepter.layer.borderColor = UIColor.black.cgColor
        // 枠の幅
        Com_Name.layer.borderWidth = 1.0
        Register_d.layer.borderWidth = 1.0
        Register_t.layer.borderWidth = 1.0
        Com_Name.layer.borderWidth = 1.0
        Com_Menber.layer.borderWidth = 1.0
        To_Name.layer.borderWidth = 1.0
        Content.layer.borderWidth = 1.0
        Recepter.layer.borderWidth = 1.0
        //ラベルタイトル
        MaineTitle.text = "受電入力"
        DayLabel.text = "日付"
        TimeLabel.text = "時刻"
        CanpanyNameLabel.text = "社名"
        ResponsibleLabel.text = "担当"
        DestinationLabel.text = "宛先"
        ContentLabel.text = "内容"
        ReceptionLabel.text = "受付人"
        //ラベル装飾
        MaineTitle.layer.borderWidth = 1
        //ボタン装飾
        AutoInputAccessory.setTitle("現在日付時刻", for: UIControl.State.normal)
        AutoInputAccessory.setTitleColor(UIColor.black, for: UIControl.State.normal)
        AutoInputAccessory.layer.borderWidth = 1
        GoNextAccessory.setTitle("登録", for: UIControl.State.normal)
        GoNextAccessory.setTitleColor(UIColor.red, for: UIControl.State.normal)
        GoNextAccessory.layer.borderColor = UIColor.black.cgColor
        GoNextAccessory.layer.borderWidth = 1
        
        //PickerView作成
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale(identifier: "ja_JP")
        Register_d.inputView = datePicker
       
        dP.datePickerMode = UIDatePicker.Mode.time
        dP.timeZone = NSTimeZone.local
        dP.locale = Locale(identifier: "ja_JP")
        Register_t.inputView = dP
        //ツールバー作成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        //PickerViewにツールバーの追加
        Register_d.inputView = datePicker
        Register_d.inputAccessoryView = toolbar
        Register_t.inputView = dP
        Register_t.inputAccessoryView = toolbar
        //userdefaults読み込み
        UserDefaults.standard.string(forKey:"Day")
        Register_d.text = UserDefaults.standard.string(forKey:"Day")
        UserDefaults.standard.string(forKey:"Time")
        Register_t.text = UserDefaults.standard.string(forKey:"Time")
    }
    //datePicker 出力
    @objc func done() {
        let formatter = DateFormatter()
        //キーボードを閉じる
        Register_d.endEditing(true)
        Register_t.endEditing(true)
        //日付
        formatter.dateFormat = "平成yy年M月d日"
        Register_d.text = "\(formatter.string(from: datePicker.date))"
        //時間
        formatter.dateFormat = ("HH:mm")
        Register_t.text = "\(formatter.string(from: dP.date))"
    }
    //ボタンタップで日時更新
    @IBAction func AutoInput(_ sender: Any)
    {
        let DayDate = DateFormatter()
        let TimeDate = DateFormatter()
        DayDate.dateFormat = "平成yy年M月d日"
        TimeDate.dateFormat = "HH:mm"
        let D_Day = DayDate.string(from: date)
        let T_Time = TimeDate.string(from: date)
        Register_d.text = D_Day
        Register_t.text = T_Time
        //userDefaults保存
        //UserDefaults.standard.set(Register_d.text,forKey: "Day")
        //UserDefaults.standard.set(Register_t.text,forKey: "Time")
    }
    
    @IBAction func CanpanyCheck(_ sender: CheckMark)
    {
        print(sender.isChecked)
    }
    @IBAction func ResponsibleCheck(_ sender: CheckMark)
    {
        print(sender.isChecked)
    }
    @IBAction func ContentCheck(_ sender: CheckMark)
    {
        print(sender.isChecked)
    }
    @IBAction func ReceptionCheck(_ sender: CheckMark)
    {
        print(sender.isChecked)
    }
    
    //ページ遷移
    @IBAction func GoNextPage(_ sender: Any)
    {
    //チェックボックスにチェック全てに入っていればページ遷移
    //performSegue(withIdentifier: "NEXT.CheckView", sender: nil)
            print("NEXT")
    }

    
    
//クラスEND
}
