//
//  ViewController.swift
//  telhistory
//
//  Created by USER on 2019/10/03.
//  Copyright © 2019 n1system. All rights reserved.
//
import UIKit
import RealmSwift

class ViewController: UIViewController,UIPickerViewDelegate{

    //userDefaults保存
    let userDefaults = UserDefaults.standard
    //PickerView
    var datePicker_d = UIDatePicker()
    var datePicker_t = UIDatePicker()
    //Label
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
    //ボタン処理
    @IBOutlet weak var SaveAction: UIButton!
    @IBOutlet weak var DateInputButton: UIButton!
    @IBOutlet weak var EditButton: UIBarButtonItem!
    @IBOutlet weak var BackListView: UIBarButtonItem!
    //segue 値受取り
    var rowNo : Int?
    //Button押下カウント
    var Tap = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker_d.timeZone = NSTimeZone.local
        datePicker_d.datePickerMode = UIDatePicker.Mode.date
        datePicker_d.locale = Locale(identifier: "ja_JP")
        datePicker_t.timeZone = NSTimeZone.local
        datePicker_t.datePickerMode = UIDatePicker.Mode.time
        datePicker_t.locale = Locale(identifier: "ja_JP")
        Register_d.inputView = datePicker_d
        Register_t.inputView = datePicker_t
        //ツールバー生成
        let toolbar_D = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        //決定ボタン
        let spacelItem_D = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem_D = UIBarButtonItem(barButtonSystemItem: .done,  target: self, action: #selector(done_D))
        toolbar_D.setItems([spacelItem_D, doneItem_D], animated: true)
        //ツールバー時刻
        let toolbar_T = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem_T = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem_T = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done_T))
        toolbar_T.setItems([spacelItem_T, doneItem_T], animated: true)
        //PickerViewにツールバーの追加
        Register_d.inputView = datePicker_d
        Register_d.inputAccessoryView = toolbar_D
        Register_t.inputView = datePicker_t
        Register_t.inputAccessoryView = toolbar_T
        //時刻
        let RealTime = Date()
        Register_d.text = DateInput(Daydata:RealTime)
        Register_t.text = TimeInput(Timedata:RealTime)
        //編集ボタン無効化 & 非表示
        EditButton.isEnabled = false
        EditButton.tintColor = UIColor.clear
        //セルTap時処理
        if( rowNo != nil )
        {
            InputText()
        }
    }
    //日付・時刻　共通メソッド
     func DateInput(Daydata:Date) -> String
    {
        let Day_DF = DateFormatter()
        Day_DF.dateFormat = "yyyy/MM/dd"
        return Day_DF.string(from: Daydata)
    }
    func TimeInput(Timedata:Date) -> String
    {
        let Time_DF = DateFormatter()
        Time_DF.dateFormat = "hh:mm"
        return Time_DF.string(from: Timedata)
    }
    //PickerView設定
    @objc func done_D()
    {
        Register_d.text = DateInput(Daydata:datePicker_d.date)
        Register_d.endEditing(true)
    }
    @objc func done_T()
    {
        Register_t.text = TimeInput(Timedata: datePicker_t.date)
        Register_t.endEditing(true)
    }
    //タップ時・時刻日付に出力
    @IBAction func AutoInput(_: Any)
    {
        let RealTime = Date()
        Register_d.text = DateInput(Daydata:RealTime)
        Register_t.text = TimeInput(Timedata:RealTime)
    }
    //ホップアップ共通化
    func PopUp_M(PopTitle:String,PopName:String)
    {
        let alert = UIAlertController(title: "\(PopTitle)",message: "\(PopName)",preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title:"OK",style:UIAlertAction.Style.default,handler: nil))
        present(alert,animated:true,completion:nil)
    }
    //チェックボックス
    @IBAction func CanpanyCheck(_ sender: CheckMark)
    {
        //print(sender.isChecked)
    }
    @IBAction func ResponsibleCheck(_ sender: CheckMark)
    {
        //print(sender.isChecked)
    }
    @IBAction func ContentCheck(_ sender: CheckMark)
    {
        //print(sender.isChecked)
    }
    @IBAction func ReceptionCheck(_ sender: CheckMark)
    {
        //print(sender.isChecked)
    }
    //カウント実装
    func CountRegistration() -> Int
    {
        let realm = try! Realm()
        let RealmData = realm.objects(RealmController.self).sorted(byKeyPath: "CountNumber",ascending: false).first
        //カウント変数
        var CountData:Int
        //nil判定
        if(RealmData?.CountNumber == nil)
        {
            CountData = 1
        }
        else
        {
            CountData = RealmData!.CountNumber + 1
        }
        return CountData
    }
    //ボタンプッシュで登録・エラー処理
    @IBAction func SaveList()
    {
        if(Com_Name.text == "")
        {
            PopUp_M(PopTitle: "注意", PopName:"社名を入力してください。")
            return
        }
        if(Com_Menber.text == "")
        {
            PopUp_M(PopTitle: "注意", PopName:"担当を入力してください。")
            return
        }
        if(To_Name.text == "")
        {
            PopUp_M(PopTitle: "注意", PopName:"宛先を入力してください。")
            return
        }
        if(Content.text == "")
        {
            PopUp_M(PopTitle: "注意", PopName:"内容を入力してください。")
            return
        }
        if(Recepter.text == "")
        {
            PopUp_M(PopTitle: "注意", PopName:"受付者を入力してください。")
            return
        }
        //Realmインスタンス作成
        let realm_C = RealmController()
        var config = Realm.Configuration()
        config.deleteRealmIfMigrationNeeded = true
        let realm = try! Realm()
        //Realm保存
        realm_C.CountNumber = CountRegistration()
        realm_C.Day = Register_d.text!        //日付
        realm_C.Time = Register_t.text!       //時刻
        realm_C.Can_neme = Com_Name.text!     //社名
        realm_C.Com_Menber = Com_Menber.text! //担当
        realm_C.To_Name = To_Name.text!       //宛先
        realm_C.Content = Content.text!       //内容
        realm_C.Recepter = Recepter.text!     //受付
        //Realm永続化
        try! realm.write
        {
            realm.add(realm_C)
        }
        //登録完了アラート
        PopUp_M(PopTitle: "登録完了", PopName:"登録が完了しました。")
        //テキストフィールド初期化
        let RealTime = Date()
        Register_d.text = DateInput(Daydata:RealTime)
        Register_t.text = TimeInput(Timedata:RealTime)
        Com_Name.text = ""
        Com_Menber.text = ""
        To_Name.text = ""
        Content.text = ""
        Recepter.text = ""
    }
    //登録情報表示
    func InputText()
    {
        //編集ボタン表示
        EditButton.isEnabled = true
        EditButton.tintColor = UIColor.red
        //登録ボタン非表示
        SaveAction.isHidden = true
        SaveAction.tintColor = UIColor.blue
        //Realmインスタンス作成
        let realm = try! Realm()
        let RealmData = realm.objects(RealmController.self).filter("CountNumber == %@",rowNo!)
        //テキストに表示
        Register_d.text = RealmData.first!.Day
        Register_t.text = RealmData.first!.Time
        Com_Name.text = RealmData.first!.Can_neme
        Com_Menber.text = RealmData.first!.Com_Menber
        To_Name.text = RealmData.first!.To_Name
        Content.text = RealmData.first!.Content
        Recepter.text = RealmData.first!.Recepter
        //テキストロック
        Register_d.isEnabled = false
        Register_t.isEnabled = false
        Com_Name.isEditable = false
        Com_Menber.isEnabled = false
        To_Name.isEnabled = false
        Content.isEditable = false
        Recepter.isEnabled = false
    }
    //編集ボタンタップ時
    @IBAction func EditContent(_ sender: Any)
    {
        Tap += 1
        if(Tap == 1)
        {
            Register_d.isEnabled = true
            Register_t.isEnabled = true
            Com_Name.isEditable = true
            Com_Menber.isEnabled = true
            To_Name.isEnabled = true
            Content.isEditable = true
            Recepter.isEnabled = true
            EditButton.title = "完了"
            BackListView.title = "キャンセル"
        }
        else
        {
            Register_d.isEnabled = false
            Register_t.isEnabled = false
            Com_Name.isEditable = false
            Com_Menber.isEnabled = false
            To_Name.isEnabled = false
            Content.isEditable = false
            Recepter.isEnabled = false
            //Realmインスタンス作成
            let realm = try! Realm()
            let RealmData = realm.objects(RealmController.self).filter("CountNumber == %@",rowNo!)
            //Realm永続化
            try! realm.write
            {
                RealmData.first!.Day = Register_d.text!
                RealmData.first!.Time = Register_t.text!
                RealmData.first!.Can_neme = Com_Name.text!
                RealmData.first!.Com_Menber = Com_Menber.text!
                RealmData.first!.To_Name = To_Name.text!
                RealmData.first!.Content = Content.text!
                RealmData.first!.Recepter = Recepter.text!
            }
            Tap = 0
            let popup = UIAlertController(title: "登録完了", message: "登録が完了しました。", preferredStyle: UIAlertController.Style.alert)
            //ポップアップまで表示を行い、画面遷移のメソッドを呼び出す
            let OK = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{(action: UIAlertAction!) in
                //アラート表示後遷移
                self.performSegue(withIdentifier: "NEXT.CheckView", sender: nil)
            })
            popup.addAction(OK)
            present(popup, animated: true, completion: nil)
        }
    }
    //ページ遷移
    @IBAction func HistoryView(_ sender: Any)
    {
        if (Tap != 1)
        {
            performSegue(withIdentifier: "NEXT.CheckView", sender: nil)
        }
        else
        {
            //テキストフィールドのフォーカスを外す
            Register_d.resignFirstResponder()
            Register_t.resignFirstResponder()
            Com_Name.resignFirstResponder()
            Com_Menber.resignFirstResponder()
            To_Name.resignFirstResponder()
            Content.resignFirstResponder()
            Recepter.resignFirstResponder()
            //Button処理
            BackListView.title = "一覧"
            EditButton.title = "編集"
            Tap = 0
        }
    }
//クラスEND
}
