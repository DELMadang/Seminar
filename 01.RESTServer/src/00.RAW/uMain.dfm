object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'RAW '#49436#48260
  ClientHeight = 51
  ClientWidth = 378
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object ePort: TEdit
    Left = 8
    Top = 16
    Width = 121
    Height = 23
    TabOrder = 0
    Text = '8080'
  end
  object btnStart: TButton
    Left = 135
    Top = 15
    Width = 75
    Height = 25
    Caption = #49884#51089
    TabOrder = 1
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 216
    Top = 15
    Width = 75
    Height = 25
    Caption = #51473#51648
    TabOrder = 2
    OnClick = btnStopClick
  end
  object btnExecute: TButton
    Left = 296
    Top = 16
    Width = 75
    Height = 25
    Caption = #48652#46972#50864#51200
    TabOrder = 3
    OnClick = btnExecuteClick
  end
end
