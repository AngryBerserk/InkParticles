object Form1: TForm1
  Left = 436
  Top = 237
  BorderStyle = bsNone
  Caption = 'Form1'
  ClientHeight = 538
  ClientWidth = 669
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnKeyDown = FormKeyDown
  OnMouseMove = FormMouseMove
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object tmr1: TTimer
    Interval = 1
    OnTimer = tmr1Timer
  end
end
