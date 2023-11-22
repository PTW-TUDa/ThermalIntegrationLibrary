within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.OpaqueConstructions;
record InteriourWall_ETA =
                  Buildings.HeatTransfer.Data.OpaqueConstructions.Generic (material={
        ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.ConcreteReinf2pc(x=0.2)},
        final nLay=1) "Construction with 200 mm reinforced concrete"
        annotation (defaultComponentPrefixes="parameter",defaultComponentName="datOpaCon");
