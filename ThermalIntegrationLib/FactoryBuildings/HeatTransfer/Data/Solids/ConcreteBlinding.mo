within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids;
record ConcreteBlinding = Buildings.HeatTransfer.Data.Solids.Generic (
    k=2.5,
    d=2240,
    c=840) "blinding concrete (k=2.5)"
  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datSol");
