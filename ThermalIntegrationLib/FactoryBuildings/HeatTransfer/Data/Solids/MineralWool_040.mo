within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids;
record MineralWool_040 = Buildings.HeatTransfer.Data.Solids.Generic (
    k=0.04,
    d=60,
    c=1000) "Mineral wool (k=0.04)"
  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datSol");
