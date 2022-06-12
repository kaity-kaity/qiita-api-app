//
//  ViewController.swift
//  ApiApp
//
//  Created by 北川 海渡 on 2021/04/27.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate{
    
    

    @IBOutlet weak var tableView: UITableView!
    
    private let refreshCtl = UIRefreshControl()
    private var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CustomCell")
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
          
        super.viewDidLoad()
        title = "新着記事"
        tableView.dataSource = self
        
        APIClient.fetchArticle { (articles) in
            self.articles = articles
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
        
        tableView.refreshControl = refreshCtl
            refreshCtl.addTarget(self, action: #selector(ViewController.refresh(sender:)), for: .valueChanged)
    }
    
    @objc func refresh(sender: UIRefreshControl) {
            
        APIClient.fetchArticle { (articles) in
            self.articles = articles
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
        
            sender.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
    
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    //cell作成メソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        
        let article = articles[indexPath.row]
       
        cell.titleLabel.text = article.title
        cell.titleLabel.numberOfLines = 0
       
        cell.idLabel.text = article.user.id
        cell.iconView.image = getImageByUrl(url: article.user.iconUrl)

        
        return cell
        
    }
    //タップ後の動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebContentViewController") as! WebContentViewController
        webContentViewController.url = articles[indexPath.row].url
        self.present(webContentViewController, animated: true, completion: nil)
        
    }
    
    func getImageByUrl(url: String) -> UIImage{
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            return UIImage(data: data)!
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        return UIImage()
    }
    
    

}


