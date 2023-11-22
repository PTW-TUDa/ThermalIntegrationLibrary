within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.OpaqueConstructions;
record Concrete400 =
    Buildings.HeatTransfer.Data.OpaqueConstructions.Generic (
      material={Buildings.HeatTransfer.Data.Solids.Concrete(x=0.4)},
      final nLay=1) "Construction with 400mm concrete"
  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datOpaCon");
