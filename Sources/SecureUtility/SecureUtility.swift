//
//  File.swift
//  
//
//  Created by aaronkim.ns on 7/12/24.
//

import Foundation
import MachO
import UIKit

open class SecureUtility {
    
    public func hasJailbreak() -> Bool {
        
        guard let cydiaUrlScheme = NSURL(string: "cydia://package/com.example.package") else { return false }
        if UIApplication.shared.canOpenURL(cydiaUrlScheme as URL) {
            return true
        }
        
        guard let url = URL(string: "sileo://") else { return false }
        if UIApplication.shared.canOpenURL(url) {
            return true
        }

#if arch(i386) || arch(x86_64)
        return false
    #endif
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: "/Applications/Dopamine.app") ||
            fileManager.fileExists(atPath: "/Applications/Sileo.app") ||
            fileManager.fileExists(atPath: "/Applications/Cydia.app") ||
            fileManager.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
            fileManager.fileExists(atPath: "/bin/bash") ||
            fileManager.fileExists(atPath: "/usr/sbin/sshd") ||
            fileManager.fileExists(atPath: "/etc/apt") ||
            fileManager.fileExists(atPath: "/usr/bin/ssh") ||
            fileManager.fileExists(atPath: "/private/var/lib/apt") ||
            fileManager.fileExists(atPath: "/var/mobile/Library/Preferences/ABPattern") || // A-Bypass
            fileManager.fileExists(atPath: "/usr/lib/ABDYLD.dylib") || // A-Bypass
            fileManager.fileExists(atPath: "/usr/lib/ABSubLoader.dylib") { // A-Bypass
            return true
        }
        
        if canOpen(path: "/Applications/Dopamine.app") ||
            canOpen(path: "/Applications/Sileo.app") ||
            canOpen(path: "/Applications/Cydia.app") ||
            canOpen(path: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
            canOpen(path: "/bin/bash") ||
            canOpen(path: "/usr/sbin/sshd") ||
            canOpen(path: "/etc/apt") ||
            canOpen(path: "/usr/bin/ssh") {
            return true
        }
        
        if !checkDYLD() {
            return true
        }
        
        let path = "/private/" + NSUUID().uuidString
        do {
            try "anyString".write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            try fileManager.removeItem(atPath: path)
            return true
        } catch {
            return false
        }
    }

    private func checkDYLD() -> Bool {

           let suspiciousLibraries = [
               "SubstrateLoader.dylib",
               "SSLKillSwitch2.dylib",
               "SSLKillSwitch.dylib",
               "MobileSubstrate.dylib",
               "TweakInject.dylib",
               "CydiaSubstrate",
               "cynject",
               "CustomWidgetIcons",
               "PreferenceLoader",
               "RocketBootstrap",
               "WeeLoader",
               "/.file", // HideJB (2.1.1) changes full paths of the suspicious libraries to "/.file"
               "libhooker",
               "SubstrateInserter",
               "SubstrateBootstrap",
               "ABypass",
               "FlyJB",
               "Substitute",
               "Cephei",
               "Electra",
           ]

           for libraryIndex in 0..<_dyld_image_count() {

               // _dyld_get_image_name returns const char * that needs to be casted to Swift String
               guard let loadedLibrary = String(validatingUTF8: _dyld_get_image_name(libraryIndex)) else { continue }

               for suspiciousLibrary in suspiciousLibraries {
                   if loadedLibrary.lowercased().contains(suspiciousLibrary.lowercased()) {
                       return false
                   }
               }
           }
        
           return true
       }


    private func canOpen(path: String) -> Bool {
        let file = fopen(path, "r")
        guard file != nil else { return false }
        fclose(file)
        return true
    }
}
