//
//  ViewController.swift
//  TcpTest
//
//  Created by SunDiz on 16/4/13.
//  Copyright © 2016年 SunDiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController,AsyncSocketDelegate {
    
    var socket:AsyncSocket?
    var isConnected = false

    override func viewDidLoad() {
        super.viewDidLoad()
        socket = AsyncSocket(delegate: self)
        socket?.disconnect()
        let host = "192.168.1.103"
        let port:UInt16 = 6000
        do{
            try socket?.connectToHost(host, onPort: port, withTimeout: 5)
        }
        catch{
            print("连接错误！")
        }
        let str = "Hello I'm ios!  \n"
        let utf8Str = str.dataUsingEncoding(NSUTF8StringEncoding)
        socket?.writeData(utf8Str!, withTimeout: -1, tag: 0)

        print(utf8Str!)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func onSocket(sock: AsyncSocket!, didConnectToHost host: String!, port: UInt16) {
        self.isConnected = true
        print("连接成功！")
    }

    func onSocketDidDisconnect(sock: AsyncSocket!) {
        self.isConnected = false
        print("连接断开！")
    }
    
    func onSocket(sock: AsyncSocket!, didReadData data: NSData!, withTag tag: Int) {
        if let dataRecive = data {
            print("rev:\(dataRecive)")
        }
    }
    
    func onSocket(sock: AsyncSocket!, didWriteDataWithTag tag: Int) {
//        print("didWriteDataWithTag:\(tag)")
    }
}

