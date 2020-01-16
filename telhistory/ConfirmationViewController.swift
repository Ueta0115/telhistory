//
//  ConfirmationViewController.swift
//  telhistory
//
//  Created by USER on 2019/10/04.
//  Copyright © 2019 n1system. All rights reserved.
//
import UIKit
import RealmSwift
class ConfirmationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //セル設定
        TableView.delegate = self
        TableView.dataSource = self
    }
    //ポップアップメッセージ
    func popup(PopUp_T:String,PopUp_M:String)
    {
        let AlertMessage = UIAlertController(title: "\(PopUp_T)",message: "\(PopUp_M)",preferredStyle: UIAlertController.Style.alert)
        AlertMessage.addAction(UIAlertAction(title:"OK",style:UIAlertAction.Style.default,handler: nil))
        present(AlertMessage, animated: true, completion: nil)
    }
    //セルIndex付与
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let realm = try! Realm()
        let RealmData = realm.objects(RealmController.self)
        return RealmData.count
    }
    //セルの生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableCell" ,for:indexPath)
        let realm = try! Realm()
        let RealmData = realm.objects(RealmController.self)
        cell.textLabel!.text = ("\(RealmData[indexPath.row].Day)　\(RealmData[indexPath.row].Time)  \(RealmData[indexPath.row].Can_neme)")
        return cell
    }
    //選択した値の取得
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let realm = try! Realm()
        let RealmData = realm.objects(RealmController.self)
        performSegue(withIdentifier: "PassValue", sender: RealmData[indexPath.row].CountNumber)
    }
    //遷移先に値渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "PassValue")
        {
            let ViewCon = segue.destination as! ViewController
            ViewCon.rowNo = sender as? Int
        }
    }
    //配列の削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            let realm = try! Realm()
            let RealmData = realm.objects(RealmController.self)
            let Input_R = RealmData[indexPath.row]
            try! realm.write
            {
                realm.delete(Input_R)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    //戻る
    @IBAction func BackInputView(_ sender: Any)
    {
        performSegue(withIdentifier: "PassValue", sender: nil)
    }
    //クラスEND
}
