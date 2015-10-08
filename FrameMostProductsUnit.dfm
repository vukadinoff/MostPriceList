object FrameMostProducts: TFrameMostProducts
  Left = 0
  Top = 0
  Width = 702
  Height = 573
  TabOrder = 0
  object G1: TcxGrid
    Left = 0
    Top = 0
    Width = 702
    Height = 573
    Align = alClient
    TabOrder = 0
    object G1V1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsProducts
      DataController.DetailKeyFieldNames = 'ProductID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      object G1V1ProductID: TcxGridDBColumn
        Caption = 'No:'
        DataBinding.FieldName = 'ProductID'
        Width = 55
      end
      object G1V1ProductName: TcxGridDBColumn
        Caption = #1055#1088#1086#1076#1091#1082#1090
        DataBinding.FieldName = 'ProductName'
        Width = 219
      end
      object G1V1Price1: TcxGridDBColumn
        Caption = #1062#1077#1085#1072' 1'
        DataBinding.FieldName = 'Price1'
        OnCustomDrawCell = G1V1Price1CustomDrawCell
        Width = 67
      end
      object G1V1Price2: TcxGridDBColumn
        Caption = #1062#1077#1085#1072' 2'
        DataBinding.FieldName = 'Price2'
        Width = 69
      end
      object G1V1Price2lv: TcxGridDBColumn
        Caption = #1062#1077#1085#1072' 2 '#1074' '#1083#1074'. '#1073#1077#1079' '#1044#1044#1057
        DataBinding.FieldName = 'Price2lv'
        Width = 150
      end
      object G1V1Price2lvDDS: TcxGridDBColumn
        Caption = #1062#1077#1085#1072' 2 '#1074' '#1083#1074'. '#1089' '#1044#1044#1057
        DataBinding.FieldName = 'Price2lvDDS'
        Width = 140
      end
    end
    object G1L1: TcxGridLevel
      GridView = G1V1
    end
  end
  object dsProducts: TDataSource
    DataSet = qrProducts
    Left = 456
    Top = 64
  end
  object qrProducts: TmySQLQuery
    Left = 400
    Top = 64
  end
end
