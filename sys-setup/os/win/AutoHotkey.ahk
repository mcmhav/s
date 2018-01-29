#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, Force
#Persistent
#InstallKeybdHook

;DIMMER
Abrighten:="F6", Adim:="F5", LCDBrightness:= 100, Screenrate:= 10
   
LCDBrightness(Brightness)
   {
   hLCD := DllCall("CreateFile"
   , Str, "\\.\LCD"
   , UInt, 0x80000000 | 0x40000000
   , UInt, 0x1 | 0x2
   , UInt, 0
   , UInt, 0x3
   , UInt, 0, UInt, 0)
   if hLCD <> -1
      {
         FILE_DEVICE_VIDEO := 0x00000023, METHOD_BUFFERED := 0, FILE_ANY_ACCESS := 0
         VarSetCapacity(DISPLAY_BRIGHTNESS, 3, 0)
         NumPut(0x03, DISPLAY_BRIGHTNESS, 0, "UChar")
         NumPut(Brightness, DISPLAY_BRIGHTNESS, 1, "UChar")
         NumPut(Brightness, DISPLAY_BRIGHTNESS, 2, "UChar")
            . DllCall("DeviceIoControl"
               , UInt, hLCD
               , UInt, (FILE_DEVICE_VIDEO<<16 | 0x127<<2 | METHOD_BUFFERED<<14 | FILE_ANY_ACCESS)
               , UInt, &DISPLAY_BRIGHTNESS, UInt, 3
               , UInt, 0, UInt, 0
               , UIntP, dwBytesReturned
               , UInt, 0) "`nErrorLevel:`t`t" ErrorLevel "`nLastError:`t`t" A_LastError
         DllCall("CloseHandle", UInt, hLCD)
      }
   }


HotKey, %ABrighten%, Brighten
HotKey, %ADim%, Dim

Brighten:
if (LCDBrightness=100){
   return
} 
LCDBrightness:= LCDBrightness + ScreenRate
if (LCDBrightness>99){
   LCDBrightness=100
}
LCDBrightness(LCDBrightness)
Return

Dim:
if (LCDBrightness=0){
   return
}
LCDBrightness:= LCDBrightness - ScreenRate
if (LCDBrightness<1){
   LCDBrightness=0
}
LCDBrightness(LCDBrightness)
Return



$F10::Send {Volume_Mute}
$F11::Send {Volume_Down}
$F12::Send {Volume_Up}

$F7::Send {Media_Prev}
$F8::Send {Media_Play_Pause}
$F9::Send {Media_Next}