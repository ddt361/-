//
//  ListTTableViewController.swift
//  贷贷通
//
//  Created by iMac on 16/3/7.
//  Copyright © 2016年 wujunbao. All rights reserved.
//

import UIKit
class ListTableViewCell : UITableViewCell{
    var proTitle = UILabel()
    var button = UIButton()
    override func awakeFromNib() {
        super.awakeFromNib()
                // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        proTitle = UILabel(frame: CGRectMake(0, 0, 200, 20))
        proTitle.backgroundColor = UIColor.blueColor()
        self.contentView.addSubview(proTitle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct listDate{
    //项目名称
    var name:String?
    //项目进度（百分比）
    var baiwenbi:Double?
    //项目年化收益率
    var nianhua:Double?
    //项目期限
    var qixian:Double?
    //项目规模
    var guimo:Double?
    //状态
    var zhuangtai:Int?
}

class ListTTableViewController: UITableViewController {
    
    var textdc = ["text":0,"cc":2,"bb":3]
    func testJson(){
        let url = ddtUrl + "/getAppindex.action"
        posthttp(url)
    }
    
//会话请求
    func httpRequest(urlString:String){
        // 创建NSURL对象
        let url = NSURL(string: urlString)
        //配置存储到磁盘
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        //超时时间
        config.timeoutIntervalForRequest = 10
        //建立会话
        let session = NSURLSession(configuration: config)
        //会话任务
        
        let task = session.dataTaskWithURL(url!){(data, _, error) -> Void in
            if error == nil{
            //链接没有错误处理数据
                
                let json = try! NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments) as! String
                
                print(json)
                
            }else{
                print(error.debugDescription)
            }
        }
        //执行任务
        task.resume()
    }
//json请求
//func json(urlString:String){
//    let url = NSURL(string: urlString)
//    let request = NSURLRequest(URL: url!)
//    
//    let session = NSURLSession.sharedSession()
//    let task = session.dataTaskWithRequest(request) { (data, _, error) -> Void in
//        let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
//        print(json)
//    }
//    task.resume()
//    
//}
//被弃用的方法
//    func posthttp(urlString:String){
//        let url = NSURL(string: urlString)
//        let req = NSMutableURLRequest(URL: url!)
//        req.HTTPMethod = "POST"
//        let str:NSString = "type=focus-c"
//        let date:NSData = str.dataUsingEncoding(NSUTF8StringEncoding)!
//        req.HTTPBody = date
//        let received:NSData = try! NSURLConnection.sendSynchronousRequest(req, returningResponse: nil)
//        let str2:NSString = NSString(data:received, encoding: NSUTF8StringEncoding)!
//        print(str2)
//    }
    func posthttp(urlString:String){
        let url:NSURL! = NSURL(string:urlString)
        //创建请求对象
        let request:NSURLRequest = NSURLRequest(URL: url)
        
        let session = NSURLSession.sharedSession()
        
        let semaphore = dispatch_semaphore_create(0)
        
        let dataTask = session.dataTaskWithRequest(request,
            completionHandler: {(data, response, error) -> Void in
                if error != nil{
                    print(error?.code)
                    print(error?.description)
                }else{
                    var str = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
                    
                    str = str.stringByReplacingOccurrencesOfString("\\\"", withString: "\"", options: NSStringCompareOptions.LiteralSearch, range:nil)
                    str = str.stringByReplacingOccurrencesOfString("\\/", withString: "/", options: NSStringCompareOptions.LiteralSearch, range:nil)
                    str.removeAtIndex(str.startIndex)
                    str.removeAtIndex(str.endIndex.predecessor())
                    let da = str.dataUsingEncoding(NSUTF8StringEncoding)
                    let jsonDC  = try! NSJSONSerialization.JSONObjectWithData(da!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                  
                    print(jsonDC)
                   
                    
                }
                
                dispatch_semaphore_signal(semaphore)
        }) as NSURLSessionTask
        
        //使用resume方法启动任务
        dataTask.resume()
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        print("数据加载完毕！")
        //继续执行其他代码.......
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.registerClass(ListTableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorColor = UIColor.redColor()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        testJson()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ListTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let tt = self.textdc["text"]
        cell.proTitle.text = "\(tt)"
        UITableViewCellSeparatorStyle.None
        
        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
       

    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }

}


