object FrameMostCategory: TFrameMostCategory
  Left = 0
  Top = 0
  Width = 623
  Height = 567
  TabOrder = 0
  object G1: TcxGrid
    Left = 0
    Top = 0
    Width = 623
    Height = 567
    Align = alClient
    TabOrder = 0
    object G1V1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnFocusedRecordChanged = G1V1FocusedRecordChanged
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      object G1V1CategoryID: TcxGridDBColumn
        Caption = 'No:'
        DataBinding.FieldName = 'CategoryID'
        Options.Editing = False
        Options.Focusing = False
        Width = 122
      end
      object G1V1CategoryName: TcxGridDBColumn
        Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103
        DataBinding.FieldName = 'CategoryName'
        Options.Editing = False
        Options.Focusing = False
        Width = 499
      end
    end
    object G1L1: TcxGridLevel
      GridView = G1V1
    end
  end
  object qryCategory: TmySQLQuery
    Left = 488
    Top = 48
  end
  object dsCategory: TDataSource
    Left = 568
    Top = 48
  end
end
