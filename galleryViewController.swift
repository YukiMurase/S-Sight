//
//  galleryViewController.swift
//  さるぼぼと歩く飛騨の観光地
//
//  Created by mc-mac14 on 2017/08/18.
//  Copyright © 2017年 mc-mac14. All rights reserved.
//

import UIKit

class galleryViewController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBAction func BackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    let photos = ["しぶきの湯・遊湯館","さるぼぼ","ひだ荘川連獅子","ぶり街道祭り１","キッチン飛騨","タルマかねこおりライトアップ１","二四三屋","年の瀬市１","渋草焼１","高山陣屋１","トランブルー","ライトアップ新穂高","丸明飛騨高山店飛騨牛","刀彫",
    "千光寺","在郷料理０２","城山公園","小糸焼","山中和紙","山桜神社絵巻市","市政記念館","年の瀬市","江名子川七夕飾り１","甚五郎ラーメン","酒蔵めぐり","金蔵獅子","飛騨牛こって牛握り寿司","飛騨一宮水無神社","飛騨コロッケ","高山市役所庁舎","鮎の塩焼き０２"]
    
    var steps = 0
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if steps / 100 <= photos.count && steps/100 != 0 {
            count = steps/100
        }
        else if steps < 100 {
            count = 0
        }
        else {
            count = photos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        // Cell はストーリーボードで設定したセルのID
        let testCell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        // Tag番号を使ってImageViewのインスタンス生成
        let imageView = testCell.contentView.viewWithTag(1) as! UIImageView
        // 画像配列の番号で指定された要素の名前の画像をUIImageとする
        let cellImage = UIImage(named: photos[(indexPath as NSIndexPath).row])
        // UIImageをUIImageViewのimageとして設定
        imageView.image = cellImage
        
        
        return testCell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // section数は１つ
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 要素数を入れる、要素以上の数字を入れると表示でエラーとなる
        return count ;
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
