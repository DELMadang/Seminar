object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'REST Client'
  ClientHeight = 550
  ClientWidth = 630
  Color = clBtnFace
  Font.Charset = HANGEUL_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #47569#51008' '#44256#46357
  Font.Style = []
  TextHeight = 15
  object DBGrid1: TDBGrid
    Left = 8
    Top = 55
    Width = 609
    Height = 305
    DataSource = dsCustomer
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = HANGEUL_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = #47569#51008' '#44256#46357
    TitleFont.Style = []
  end
  object btnQuery: TButton
    Left = 8
    Top = 24
    Width = 75
    Height = 25
    Caption = #51312#54924
    TabOrder = 1
    OnClick = btnQueryClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 366
    Width = 609
    Height = 171
    Caption = #49324#50857#51088' '#49345#49464#51221#48372
    TabOrder = 2
    object Label1: TLabel
      Left = 23
      Top = 32
      Width = 76
      Height = 15
      Caption = #49324#50857#51088' '#50500#51060#46356
    end
    object Label2: TLabel
      Left = 23
      Top = 61
      Width = 24
      Height = 15
      Caption = #46321#44553
    end
    object Label3: TLabel
      Left = 23
      Top = 90
      Width = 64
      Height = 15
      Caption = #49324#50857#51088' '#49457#47749
    end
    object eUserID: TDBEdit
      Left = 128
      Top = 29
      Width = 460
      Height = 23
      DataField = 'USR_ID'
      DataSource = dsCustomer
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 128
      Top = 58
      Width = 460
      Height = 23
      DataField = 'USR_LVL'
      DataSource = dsCustomer
      TabOrder = 1
    end
    object DBEdit3: TDBEdit
      Left = 128
      Top = 87
      Width = 460
      Height = 23
      DataField = 'USR_NM'
      DataSource = dsCustomer
      TabOrder = 2
    end
    object Button2: TButton
      Left = 432
      Top = 128
      Width = 75
      Height = 25
      Caption = #51200#51109
      TabOrder = 3
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 513
      Top = 128
      Width = 75
      Height = 25
      Caption = #52712#49548
      TabOrder = 4
    end
  end
  object btnInsert: TButton
    Left = 88
    Top = 24
    Width = 75
    Height = 25
    Caption = #46321#47197
    TabOrder = 3
    OnClick = btnInsertClick
  end
  object btnDelete: TButton
    Left = 250
    Top = 24
    Width = 75
    Height = 25
    Caption = #49325#51228
    TabOrder = 4
    OnClick = btnDeleteClick
  end
  object btnEdit: TButton
    Left = 169
    Top = 24
    Width = 75
    Height = 25
    Caption = #49688#51221
    TabOrder = 5
    OnClick = btnEditClick
  end
  object mtCustomer: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'USR_ID'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'USR_PW'
        DataType = ftString
        Size = 64
      end
      item
        Name = 'USR_NM'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 64
    Top = 216
  end
  object dsCustomer: TDataSource
    DataSet = mtCustomer
    Left = 64
    Top = 304
  end
end
