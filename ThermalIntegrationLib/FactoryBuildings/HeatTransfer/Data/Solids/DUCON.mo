within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids;
record DUCON =            Buildings.HeatTransfer.Data.Solids.Generic (
    k=5.0,
    d=2500,
    c=1100) "ductile concrete (k=5.0)"
  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datSol");
