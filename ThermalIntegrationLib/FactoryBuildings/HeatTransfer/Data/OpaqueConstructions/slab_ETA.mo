within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.OpaqueConstructions;
record Slab_ETA = Buildings.HeatTransfer.Data.OpaqueConstructions.Generic (material={
        ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.FoamGlassGranulate(x=0.33),
        ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.ConcreteBlinding(x=0.1),
        ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.ConcreteReinf2pc(x=0.2)},
        final nLay=3) "Construction with 330 mm foam glass granulate, 100 mm blinding concrete, 200 mm reinforced concrete"
        annotation (defaultComponentPrefixes="parameter",defaultComponentName="datOpaCon");
