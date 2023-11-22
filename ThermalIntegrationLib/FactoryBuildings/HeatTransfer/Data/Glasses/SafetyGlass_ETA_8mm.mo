within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Glasses;
record SafetyGlass_ETA_8mm =
               Buildings.HeatTransfer.Data.Glasses.Generic (
    x=0.008,
    k=1.0,
    tauSol={0.32},
    rhoSol_a={0.075},
    rhoSol_b={0.075},
    tauIR=0,
    absIR_a=0.84,
    absIR_b=0.84) "Safety glass 8mm"
  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datGla");
