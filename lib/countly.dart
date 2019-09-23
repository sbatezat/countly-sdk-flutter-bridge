import 'dart:async';

import 'package:flutter/services.dart';

class Countly {
  static const MethodChannel _channel =
      const MethodChannel('countly');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> init(String serverUrl, String appKey, [String deviceId]) async {
    List <String> arg = [];
    arg.add(serverUrl);
    arg.add(appKey);
    if(deviceId != null){
      arg.add(deviceId);
    }
    final String result = await _channel.invokeMethod('init', <String, dynamic>{
        'data': json(arg)// '["https://try.count.ly", "0e8a00e8c01395a0af8be0e55da05a404bb23c3e"]',
      });
    print(result);
    return result;
  }
  

  static Future<String> sendEvent( Map<String, Object> options) async {
    List <String> arg = [];
    var args = [];
    var eventType = "event"; //event, eventWithSum, eventWithSegment, eventWithSumSegment
    var segments = {};

    if(options["eventSum"])
        eventType = "eventWithSum";
    if(options["segments"])
        eventType = "eventWithSegment";
    if(options["segments"] && options["eventSum"])
        eventType = "eventWithSumSegment";

    args.add(eventType);

    if(options["eventName"])
        args.add(options["eventName"].toString());
    if(options["eventCount"]){
        args.add(options["eventCount"].toString());
    }else{
        args.add("1");
    }
    if(options["eventSum"]){
        args.add(options["eventSum"].toString());
    }

    if(options["segments"]){
        segments = options["segments"];
    }
    for (var event in ["segments"]) {
        args.add(event);
        args.add(segments[event]);
    }

    final String result = await _channel.invokeMethod('event', <String, dynamic>{
        'data': json(arg)
      });
    print(result);
    return result;
  }


  ////// 001
  static Future<String> recordViewHome() async {
    List <String> arg = [];
    final String result = await _channel.invokeMethod('recordView', <String, dynamic>{
        'data': json(arg)
    });
    print(result);
    return result;
  }
  static Future<String> recordViewDashboard() async {
    List <String> arg = [];
    final String result = await _channel.invokeMethod('recordView', <String, dynamic>{
        'data': json(arg)
    });
    print(result);
    return result;
  }
///
static Future<String> setUserData(Map<String, Object> options) async {
    List <String> arg = [];
     var args = [];
    if(options["name"] == null){
      options["name"] = "";
    }
    args.add(options["name"]);
    args.add(options["username"] || "");
    args.add(options["email"] || "");
    args.add(options["organization"] || "");
    args.add(options["phone"] || "");
    args.add(options["picture"] || "");
    args.add(options["picturePath"] || "");
    args.add(options["gender"]);
    args.add(options["byear"]);

    
    final String result = await _channel.invokeMethod('setUserData', <String, dynamic>{
        'data': json(arg)
    });
    print(result);
    return result;
  }
static Future<String> sendPushToken(Map<String, Object> options) async {
    List <String> arg = [];
    var args = [];
    args.add(options["token"] || "");
    args.add(options["messagingMode"] || Countly.messagingMode["PRODUCTION"]);
    

    final String result = await _channel.invokeMethod('sendPushToken', <String, dynamic>{
        'data': json(arg)
    });
    print(result);
    return result;
  }


static Future<String> start() async {
    List <String> arg = [];
    final String result = await _channel.invokeMethod('start', <String, dynamic>{
        'data': json(arg)
    });
    print(result);
    return result;
  }

  static Future<String> stop() async {
    List <String> arg = [];
    final String result = await _channel.invokeMethod('stop', <String, dynamic>{
        'data': json(arg)
    });
    print(result);
    return result;
  }

static Future<String> setOptionalParametersForInitialization(Map<String, Object> options) async {
    List <String> arg = [];
     var args = [];
    String latitude = options["latitude"];
    options["latitude"] = options["latitude"].toString();
    options["longitude"] = options["longitude"].toString();
    if(options["latitude && !options.latitude"].match('\\.')){
        options["latitude"] =   + ".00";
    }
    if(optionslongitude && !options.longitude.match('\\.')){
        options["longitude"] = latitude + ".00";
    }

    args.add(options["city"] || "");
    args.add(options["country"] || "");
    args.add(options["latitude"] || "0.0");
    args.add(options["longitude"] || "0.0");
    args.add(String(options.ipAddress) || "0.0.0.0");
    final String result = await _channel.invokeMethod('setOptionalParametersForInitialization', <String, dynamic>{
        'data': json(arg)
    });
    print(result);
    return result;
  }

static Future<String> changeDeviceId(String newDeviceID ,bool onServer) async {
    List <String> arg = [];
    if(onServer == false){
        onServer = "0";
    }else{
        onServer = "1";
    }
    newDeviceID = newDeviceID.toString();
    final String result = await _channel.invokeMethod('changeDeviceId', <String, dynamic>{
        'data': json(arg)
    });
    print(result);
    return result;
  }

static Future<String> addCrashLog(Map<String, Object> newDeviceID) async {
    List <String> arg = [];
   
    final String result = await _channel.invokeMethod('addCrashLog', <String, dynamic>{
        'data': json(arg)
    });
    print(result);
    return result;
  }

  static String json(List <String> list){
    String j = '[';
    int i = 0;
    list.forEach((v){
      j+= '"' +v.replaceAll('"', '\\"') +'"';
      i++;
      if(list.length != i){
        j+=',';
      }
    });
    j+=']';
    return j;
  }
}
