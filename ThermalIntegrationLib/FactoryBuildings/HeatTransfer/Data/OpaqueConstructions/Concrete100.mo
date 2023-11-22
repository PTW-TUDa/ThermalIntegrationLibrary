within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.OpaqueConstructions;
record Concrete100 =
    Buildings.HeatTransfer.Data.OpaqueConstructions.Generic (
      material={Buildings.HeatTransfer.Data.Solids.Concrete(x=0.1)},
      final nLay=1) "Construction with 100mm concrete"
  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datOpaCon");
