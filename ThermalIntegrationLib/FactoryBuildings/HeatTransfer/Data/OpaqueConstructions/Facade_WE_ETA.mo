within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.OpaqueConstructions;
record Facade_WE_ETA =
                  Buildings.HeatTransfer.Data.OpaqueConstructions.Generic (material={
        ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.MineralFoam_TUDa(x=0.3),
        ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.ConcreteReinf2pc(x=0.12)},
        final nLay=2) "Construction with 300 mm mineral foam, 120 mm reinforced concrete"
        annotation (defaultComponentPrefixes="parameter",defaultComponentName="datOpaCon");
