within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids;
record MineralWool_035 = Buildings.HeatTransfer.Data.Solids.Generic (
    k=0.035,
    d=60,
    c=1000) "Mineral wool (k=0.035)"
  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datSol");
