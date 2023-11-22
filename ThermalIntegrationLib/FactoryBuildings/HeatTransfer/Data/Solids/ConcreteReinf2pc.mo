within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids;
record ConcreteReinf2pc = Buildings.HeatTransfer.Data.Solids.Generic (
    k=2.5,
    d=2400,
    c=1000) "Reinforced concrete 2% steel (k=2.5)"
  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datSol");
