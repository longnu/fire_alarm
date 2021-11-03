#include <Wire.h>
#include <SoftwareSerial.h>
#include <DFPlayer_Mini_Mp3.h>
#include <ArduinoJson.h>

// 모바일 HostSpot의 ID와 패스워드 (변경할 부분)
const String SSID = "Moon";
const String PASSWORD = "12345678";
// 서버주소와 포트 (변경할 부분)
const String SERVER_IP = "172.30.1.50";
const String SERVER_PORT = "8081";

// AT 명령 저장
String cmd = "";
// 전송 데이터 저장
String sendData = "";
// WiFi 접속 실패 여부
boolean FAIL_8266 = false;

// TX, RX
SoftwareSerial esp(3, 2);
SoftwareSerial mySerial(10, 11);   

void setup() {
  Wire.begin();
  mySerial.begin(9600);
  Serial.begin (9600);
  mp3_set_serial (mySerial);  //set Serial for DFPlayer-mini mp3 module 
  delay(1);  //wait 1ms for mp3 module to set volume
  mp3_set_volume (30);
  Serial.println("Start module connection");
  do {
    Serial.begin(9600);
    esp.begin(9600);
    // ESP8266 모듈 재시작
    esp.println("AT+RST");
    delay(1000);
    // 만약 재시작되었다면
    if (esp.find("ready")) {
      Serial.println("Module ready");
      // ESP8266 모듈의 모드를 듀얼모드로 설정 (클라이언트)
      esp.println("AT+CWMODE=1");
      delay(2000);
      // AP에 접속되면
      if (cwJoinAP()) {
        Serial.println("AP successful");
        FAIL_8266 = false;
        delay(5000);
        Serial.println("Start buffer initialization");
        while (esp.available() > 0) {
          char a = esp.read();
          Serial.write(a);
        }
        Serial.println();
        Serial.println("Buffer initialization terminated");
      } else {
        Serial.println("AP connection failure");
        delay(500);
        FAIL_8266 = true;
      }
    } else {
      Serial.println("Module connection failure");
      delay(500);
      FAIL_8266 = true;
    }
  } while (FAIL_8266);
  Serial.println("Module connection complete");
}

boolean a = true;
String message = "";

void loop() {
    
 

    sendDataToServer();
    Serial.println("result : " + message);
//    DynamicJsonBuffer jsonBuffer;
    StaticJsonDocument<200> doc;
    deserializeJson (doc, message);
    int mp3 = doc["mp3"];
    int led = doc["led"];
    Serial.print("mp3 : ");
    Serial.println(mp3);
    Serial.print("led : ");
    Serial.println(led);
    mp3_set_volume(50);
    mp3_play(1);
    
     delay(8000);
    mp3_play(mp3);              
//     while(digitalRead(A0) == LOW);
     delay(8000);
    

Wire.beginTransmission(1);
//1번은 화재 발생 시 무조건 출력
  if (mp3==1){
    Wire.write("a");
  }
  //2번은 오른쪽으로 유도
  else if (mp3==2){
  Wire.write("b");
  }
  //3번은 왼쪽으로 유도
  else if (mp3==3){
  Wire.write("c");
  }
 
  Wire.endTransmission();
  delay(250);
 
}


void sendDataToServer() {
  Serial.println("Start the data transfer part");
  cmd = "AT+CIPSTART=\"TCP\",\"" + SERVER_IP + "\"," + SERVER_PORT + "\r\n";
  Serial.println("Attempt to connect to server");
  esp.println(cmd);
  // 웹 서버에 접속되면
  if (esp.find("OK")) {
    Serial.println("Server connection successful");
  } else {
    Serial.println("Server connection failed");
  }

  // 서버로 GET 메시지 전송
  cmd = "GET /DPproject_sms/ExitArduinoServiceCon";
  cmd += "\r\nConnection: close\r\n\r\n";

  Serial.println(cmd);
  esp.print("AT+CIPSEND=");
  esp.println(cmd.length());
  if (esp.find("OK")) {
    Serial.println("Ready to send to server");
  } else {
    Serial.println("Failed to prepare to send to server");
  }
  esp.println(cmd);
  
  //데이터 전송이 완료되면
  if (esp.find("OK")) {
    Serial.println("Data transfer successful");
    Serial.println();
    delay(5000);
    Serial.println("Attempt to receive data");
    
    boolean state = false;
    while (esp.available()) {
      char c = esp.read();
      Serial.write(c);
    
    if (c == '/') {
        state = !state;
      } else if (state == true) {
        message += c;
      }
        
    }
    Serial.println();
    Serial.println("End Receiving Data");
  } else {
    Serial.println("Data transfer failed");
    sendDataToServer();
  }
}

boolean cwJoinAP() {
  String cmd = "AT+CWJAP=\"" + SSID + "\",\"" + PASSWORD + "\"";
  esp.println(cmd);
  if (esp.find("OK")) {
    return true;
  } else {
    return false;
  }
}
