//
//  ViewController.swift
//  Demo
//
//  Created by volivesolutions on 09/07/18.
//  Copyright © 2018 volivesolutions. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController,UITextFieldDelegate,UNUserNotificationCenterDelegate{
    
    @IBOutlet weak var numTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let family = "👩\u{200D}👩\u{200D}👧\u{200D}👦"  // 👩‍👩‍👧‍👦
        let boy = "👦"
        
        let charactersToSkip = family + boy
        
        let string = boy + family + "foobar"  // 👦👩‍👩‍👧‍👦foobar
        
        let scanner = MyScanner(string)
        scanner.skip(charactersIn: charactersToSkip)
        print(scanner.remains)
        
        let data  = "RamiReddy"
        for i in 0..<data.count-1 {
            print(i)
             
        }

        
        //Remove some punctuation in given string
        var removePunctuationString = "how ! are you"
        print(removePunctuationString.capitalizeFirstLetter())
        removePunctuationString = removePunctuationString.components(separatedBy: CharacterSet.punctuationCharacters).joined()
        print(removePunctuationString)
        
        //color changes of font in givin string
        
        let attributes = [[NSAttributedStringKey.foregroundColor:UIColor.red], [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17)]]
        numTF.attributedText = "This is a text".highlightWordsIn(highlightedWords: "is a text", attributes: attributes)
        
        //Request for Loacl Notification authtication
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (allow, err) in
            
        }
 
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        print(newString.length)
        if newString.length == 1 || newString.length == 4 || newString.length == 5{
            let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            return (string == filtered)
        }else if newString.length == 2 || newString.length == 3 || newString.length == 6 || newString.length == 7{
            let ACCEPTABLE_CHARACTERS = "1234567890"
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            return (string == filtered)
        }
        
        return newString.length <= maxLength
        
        
        
       
        
//        for (int i=0; i< data.length; i++) {
//
//            NSString*str=[data substringWithRange:NSMakeRange(i,1)];
//            [self.array addObject:str];
//
//        }
//
//
//
//        NSCountedSet *countedSet = [[NSCountedSet alloc] initWithArray:self.array];
//
//        dictArray = [NSMutableArray array];
//        [countedSet enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
//        [self->dictArray addObject:@{@"object": obj,
//        @"count": @([countedSet countForObject:obj])}];
//        }];
        
        
    }
    //displaying the ios local notification when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        completionHandler([.alert, .badge, .sound])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Generate Local Notification Alert
    @IBAction func generateNotificationBtn_Action(_ sender: Any) {
        //creating the notification content
        let content = UNMutableNotificationContent()
        
        //adding title, subtitle, body and badge
        content.title = "Welcome to RamiReddy IOS Online Classes"
        content.subtitle = "iOS learning Easy "
        content.body = " ******************************* We are learning about iOS Local Notification !👍🍎 *************************************"
        content.badge = 1
        
        //getting the notification trigger
        //it will be called after 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        //getting the notification request
        let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().delegate = self
        
        //adding the notification to notification center
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

    }
    
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension String {
    
    func highlightWordsIn(highlightedWords: String, attributes: [[NSAttributedStringKey: Any]]) -> NSMutableAttributedString {
        let range = (self as NSString).range(of: highlightedWords)
        let result = NSMutableAttributedString(string: self)
        
        for attribute in attributes {
            result.addAttributes(attribute, range: range)
        }
        
        return result
    }
}
