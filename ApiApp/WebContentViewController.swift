//
//  WebContentViewController.swift
//  ApiApp
//
//  Created by 北川 海渡 on 2021/04/27.
//

import UIKit
import WebKit

class WebContentViewController: UIViewController {
    //変数受け取る
    var url: String!
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        openURL(url)
    }
    
    private func openURL(_ string: String?) {
        guard let urlStr = string else { return }
        let url = URL(string: urlStr)!
        let request = URLRequest(url: url)
        webView.load(request)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
