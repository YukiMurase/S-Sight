//
//  ViewController.swift
//  さるぼぼと歩く飛騨の観光地
//
//  Created by mc-mac14 on 2017/08/18.
//  Copyright © 2017年 mc-mac14. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var steps:Int = 0
    var count = 0
    let photos = ["しぶきの湯・遊湯館", "さるぼぼ","ひだ荘川連獅子","ぶり街道祭り１","キッチン飛騨","タルマかねこおりライトアップ１","二四三屋","年の瀬市１","渋草焼１","高山陣屋１"]
    
    @IBAction func Gallary(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goGallerly", sender: self)
    }
    @IBAction func startButtion(_ sender: UIButton) {
        // CMPedometerの確認
        if(CMPedometer.isStepCountingAvailable()){
            
            self.pedometer.startUpdates(from: NSDate() as Date) {
                (data: CMPedometerData?, error) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    if(error == nil){
                        // 歩数
                        self.steps = Int(data!.numberOfSteps) + self.userDefaults.integer(forKey: "step")
                        self.myLabel.text = " \(self.steps)"
                        if self.steps / 100 < self.photos.count && self.steps/100 != 0 {
                            self.count = self.steps/100
                            self.myLabel2.text = self.photos[self.count-1]
                        }
                        else if self.steps < 100 {
                            self.count = 0
                        }
                        else {
                            self.count = self.photos.count
                        }
                        
                    }
                })
            }
        }
        
    }
    
    let userDefaults = UserDefaults.standard
    @IBAction func StopButton(_ sender: UIButton) {
        self.pedometer.stopUpdates()
        userDefaults.set(steps, forKey: "step")
    }
    
    
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myLabel2: UILabel!
    
    @IBAction func discriptionPop(_ sender: Any) {
        
        //  カスタムポップアップ
        let popupView:DescriptionView = UINib(nibName: "DescriptionView", bundle: nil).instantiate(withOwner: self,options: nil)[0] as! DescriptionView

        // ポップアップビュー背景色（グレーの部分）
        let viewColor = UIColor.black
        // 半透明にして親ビューが見えるように。透過度はお好みで。
        popupView.backgroundColor = viewColor.withAlphaComponent(0.5)
        // ポップアップビューを画面サイズに合わせる
        popupView.frame = self.view.frame

        // ダイアログ背景色（白の部分）
        let baseViewColor = UIColor.white
        // ちょっとだけ透明にする
        popupView.baseView.backgroundColor = baseViewColor.withAlphaComponent(0.7)
        // 角丸にする
        popupView.baseView.layer.cornerRadius = 8.0

        // 貼り付ける
        self.view.addSubview(popupView)
    }
    
    // メンバー変数でないと動作しないので注意
    let pedometer = CMPedometer()
    var player:AVAudioPlayer!
    var player2:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myLabel.layer.borderColor = UIColor.black.cgColor
        myLabel.layer.borderWidth = 1
        myLabel2.layer.borderColor = UIColor.black.cgColor
        myLabel2.layer.borderWidth = 1
        let sound1 = NSDataAsset(name: "title1")
        let sound2 = NSDataAsset(name: "title2")
        do {
//            let path = Bundle.main.path(forResource: "title1", ofType: "wav")
//            let path2 = Bundle.main.path(forResource: "title2", ofType: "wav")
//            try player = AVAudioPlayer(contentsOf: URL(string: path!)!)
//            try player2 = AVAudioPlayer(contentsOf: URL(string: path2!)!)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(data: sound1!.data, fileTypeHint: AVFileType.wav.rawValue)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            player2 = try AVAudioPlayer(data: sound2!.data, fileTypeHint: AVFileType.wav.rawValue)
            
            //音楽をバッファに読み込んでおく
            player.prepareToPlay()
            
            //デリゲート先に自分を設定する。
            player.delegate = self
        } catch {
            print(error)
        }
        player.play()
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        player2.prepareToPlay()
        player2.numberOfLoops = -1
        player2.play()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    // MARK: - 画面遷移する直前に呼ばれる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goGallerly" {
            var resultViewController = segue.destination as! galleryViewController
            resultViewController.steps = Int(self.steps)
        }
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
}

