//
//  ZKPermissionMC.swift
//  Runner
//
//  Created by sheng on 2023/4/27.
//

import Foundation
import Flutter
import AVFoundation
import Photos
import CoreBluetooth


class ZKPermissionMC : NSObject{
    var bluetoothManager:CBCentralManager?
    private lazy var handler: FlutterMethodCallHandler = {
        { call, result in
            switch call.method{
            case "GotoSetting":
                self.onGotoSettingCall()
            case "ZKCameraPermission":
                self.onZKCameraPermissionCall { granted in
                    result(granted)
                }
            case "ZKMicrophonePermission":
                self.onZKMicrophonePermissionCall { granted in
                    result(granted)
                }
            case "ZKNotificationUsagePermission":
                self.onZKNotificationUsagePermissionCall { granted in
                    result(granted)
                }
            case "ZKLocationUsagePermission":
                self.onZKLocationUsagePermissionCall { granted in
                    result(granted)
                }
            case "ZKBluetoothUsagePermission":
                if #available(iOS 13.1, *) {
                    self.onZKBluetoothUsagePermissionCall { granted in
                        result(granted)
                    }
                } else {
                    
                }
            case "ZKPhotoLibraryUsagePermission":
                if #available(iOS 14, *) {
                    self.onZKPhotoLibraryUsagePermissionCall { granted in
                        result(granted)
                    }
                }
            case "ZKPhotoLibraryAddUsagePermission":
                if #available(iOS 14, *) {
                    self.onZKPhotoLibraryAddUsagePermissionCall { granted in
                        result(granted)
                    }
                }
            case "ZKLocalNetworkAuthorization":
                self.onZKLocalNetworkAuthorizationCall()
            default:
                break
            }
            
        }
    }()
    
    init(_ controller:FlutterViewController) {
        super.init()
        let channel = FlutterMethodChannel(name: "ZKPermission", binaryMessenger: controller.binaryMessenger)
        channel.setMethodCallHandler(handler)
    }
    
    private func onGotoSettingCall(){
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
    /// 处理相机权限
    /// - Parameter completion: 是否有权限
    private func onZKCameraPermissionCall(_ completion: @escaping (Bool)->Void){
        let cameraAuthStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch cameraAuthStatus {
        case .notDetermined://未询问
            AVCaptureDevice .requestAccess(for: .video) { granted in
                completion(granted)
            }
        case .restricted, .denied://1. 未授权, 家长限制 2. 用户拒绝
            //1. 弹窗询问用户要不要授权
            
            onGotoSettingCall()
        case .authorized://用户同意
            completion(true)
        default:
            break
        }
        
    }
    private func onZKMicrophonePermissionCall(_ completion: @escaping (Bool)->Void){
        let microphoneAuthStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        print(microphoneAuthStatus)
        switch microphoneAuthStatus {
        case .notDetermined://未询问
            AVCaptureDevice .requestAccess(for: .audio) { granted in
                completion(granted)
            }
        case .restricted, .denied://1. 未授权, 家长限制 2. 用户拒绝
            //1. 弹窗询问用户要不要授权
            
            onGotoSettingCall()
        case .authorized://用户同意
            completion(true)
        default:
            break
        }
    }
    @available(iOS 14, *)
    private func onZKPhotoLibraryUsagePermissionCall(_ completion: @escaping (Bool)->Void){
        let photoLibraryUsageAuthStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)

        switch photoLibraryUsageAuthStatus {
        case .limited://有限访问
            completion(true)
        case .notDetermined://未询问
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                guard status == .authorized || status == .limited else{
                    completion(false)
                    return
                }
                completion(true)
            }
            
        case .restricted, .denied://1. 未授权, 家长限制 2. 用户拒绝
            //1. 弹窗询问用户要不要授权
            
            onGotoSettingCall()
        case .authorized://用户同意
            completion(true)
        default:
            break
        }
    }
    @available(iOS 14, *)
    private func onZKPhotoLibraryAddUsagePermissionCall(_ completion: @escaping (Bool)->Void){
        let photoLibraryUsageAuthStatus = PHPhotoLibrary.authorizationStatus(for: .addOnly)

        switch photoLibraryUsageAuthStatus {
        case .limited://有限访问
            completion(true)
        case .notDetermined://未询问
            PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
                guard status == .authorized || status == .limited else{
                    completion(false)
                    return
                }
                completion(true)
            }
            
        case .restricted, .denied://1. 未授权, 家长限制 2. 用户拒绝
            //1. 弹窗询问用户要不要授权
            
            onGotoSettingCall()
        case .authorized://用户同意
            completion(true)
        default:
            break
        }
    }
    private func onZKNotificationUsagePermissionCall(_ completion: @escaping (Bool)->Void){
        
        UIApplication.shared.registerForRemoteNotifications()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]){ granted, _ in
            completion(granted)
        }

        
        
        
    }
    private func onZKLocationUsagePermissionCall(_ completion: @escaping (Bool)->Void){
        let locationManager = CLLocationManager()
        let locationUsageAuthStatus = CLLocationManager.authorizationStatus()

        switch locationUsageAuthStatus {
        case .notDetermined://未询问
            locationManager.requestAlwaysAuthorization()
            completion(true)
        case .restricted, .denied://1. 未授权, 家长限制 2. 用户拒绝
            //1. 弹窗询问用户要不要授权
            
            onGotoSettingCall()
        case .authorized://用户同意
            completion(true)
        default:
            break
        }
    }
    @available(iOS 13.1, *)
    private func onZKBluetoothUsagePermissionCall(_ completion: @escaping (Bool)->Void){
        bluetoothManager = CBCentralManager(delegate: self, queue: nil)
        
    }
    private func onZKLocalNetworkAuthorizationCall(){
//        let string = "https://www.google.com"
//        
//        guard let url = URL(string: string) else {
//            fatalError("wrong url")
//        }
//        var request = URLRequest.init(url:url)
//        request.httpMethod = "get"
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            print(error)
//        }
//        task.resume()
        // 本地网络权限
        if #available(iOS 14.0, *) {
            let localNS = LocalNetworkAuthorization()
            localNS.requestAuthorization { isAgree in
                debugPrint("是否同意\(isAgree)")
            }
        } else {
            
        }
    }
    
}

extension ZKPermissionMC:CBCentralManagerDelegate{
    func startScanning() -> Void {
      // Start Scanning
        bluetoothManager?.scanForPeripherals(withServices: [CBUUIDs.BLEService_UUID])
    }
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
         switch central.state {
              case .poweredOff:
                  print("Is Powered Off.")
              case .poweredOn:
                  print("Is Powered On.")
                  startScanning()
              case .unsupported:
                  print("Is Unsupported.")
              case .unauthorized:
              print("Is Unauthorized.")
              case .unknown:
                  print("Unknown")
              case .resetting:
                  print("Resetting")
              @unknown default:
                print("Error")
              }
      }
    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        
    }
    
    
}
struct CBUUIDs{

    static let kBLEService_UUID = "6e400001-b5a3-f393-e0a9-e50e24dcca9e"
    static let kBLE_Characteristic_uuid_Tx = "6e400002-b5a3-f393-e0a9-e50e24dcca9e"
    static let kBLE_Characteristic_uuid_Rx = "6e400003-b5a3-f393-e0a9-e50e24dcca9e"

    static let BLEService_UUID = CBUUID(string: kBLEService_UUID)
    static let BLE_Characteristic_uuid_Tx = CBUUID(string: kBLE_Characteristic_uuid_Tx)//(Property = Write without response)
    static let BLE_Characteristic_uuid_Rx = CBUUID(string: kBLE_Characteristic_uuid_Rx)// (Property = Read/Notify)

}
