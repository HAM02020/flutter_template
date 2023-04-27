//
//  ZKPermissionMC.swift
//  Runner
//
//  Created by sheng on 2023/4/27.
//

import Foundation
import Flutter
import AVFoundation

class ZKPermissionMC{
    private lazy var handler: FlutterMethodCallHandler = {
        { call, result in
            switch call.method{
            case "ZKCameraPermission":
                self.onZKCameraPermissionCall { granted in
                    result(granted)
                }
            case "ZKMicrophonePermission":
                self.onZKMicrophonePermissionCall { granted in
                    result(granted)
                }
            default:
                break
            }
            
        }
    }()
    init(_ controller:FlutterViewController) {
        let channel = FlutterMethodChannel(name: "ZKPermission", binaryMessenger: controller.binaryMessenger)
        channel.setMethodCallHandler(handler)
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
            
            //2. 跳转到设置页
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
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
            
            //2. 跳转到设置页
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        case .authorized://用户同意
            completion(true)
        default:
            break
        }
    }
    
    
}
