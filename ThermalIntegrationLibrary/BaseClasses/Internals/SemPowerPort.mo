within ThermalIntegrationLibrary.BaseClasses.Internals;
model SemPowerPort

  SI.HeatFlowRate coolingPower=sum(coolingPowerPort[1:end].Power);
  SI.HeatFlowRate heatingPower=sum(heatingPowerPort[1:end].Power);
  SI.Power electricPower=sum(electricPowerPort[1:end].Power);

  ThermalIntegrationLibrary.BaseClasses.Internals.ElectricPowerPort[5] electricPowerPort;
  ThermalIntegrationLibrary.BaseClasses.Internals.HeatingPowerPort[5] heatingPowerPort;
  ThermalIntegrationLibrary.BaseClasses.Internals.CoolingPowerPort[5] coolingPowerPort;
  ThermalIntegrationLibrary.BaseClasses.Internals.DissipationPowerPort dissipationPowerPort;
  ThermalIntegrationLibrary.BaseClasses.Internals.BuildingPort buildingPort;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end SemPowerPort;
