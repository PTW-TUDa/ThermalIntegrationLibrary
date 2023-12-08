within ThermalIntegrationLibrary.BaseClasses;
model SystemEnergyManager "Manages energy flows of machines and factory building"
  extends ThermalIntegrationLibrary.BaseClasses.Icons.SystemEnergyManager;

  //global time offset for all table based operation mode definitions
  parameter Real timeOffset = 0 "Global time offset";

  //temperatures for inside and outside
  parameter Boolean useBuilding = false "true, if building model is used in System";

  parameter SI.Temperature fixedInsideTemperature = 298.15 annotation(Dialog(enable = not useBuilding));
  parameter SI.Temperature fixedOutsideTemperature = 283.15 annotation(Dialog(enable = not useBuilding));

  SI.Temperature insideTemperature;
  SI.Temperature outsideTemperature;

  //basic information for pinch analysis [10]-->ID, [3]-->operating modes
  ThermalIntegrationLibrary.BaseClasses.Internals.ElectricPowerPort[10] electricPowerPort;
  ThermalIntegrationLibrary.BaseClasses.Internals.DissipationPowerPort[10] dissipationPowerPort;
  ThermalIntegrationLibrary.BaseClasses.Internals.CoolingPowerPort[10,5] coolingPowerPort;
  ThermalIntegrationLibrary.BaseClasses.Internals.HeatingPowerPort[10,5] heatingPowerPort;
  ThermalIntegrationLibrary.BaseClasses.Internals.BuildingPort buildingPort;

  SI.HeatFlowRate totalHeatingPower;
  SI.HeatFlowRate totalCoolingPower;
  SI.Power totalElectricPower;
  SI.HeatFlowRate totalDissipationFlowRate;

equation
  if useBuilding == true then
    insideTemperature = buildingPort.insideTemperature;
    outsideTemperature = buildingPort.outsideTemperature;
  else
    insideTemperature = fixedInsideTemperature;
    outsideTemperature = fixedOutsideTemperature;
  end if;

  totalHeatingPower = sum(heatingPowerPort[1:end,1:end].Power)*(-1);
  totalCoolingPower = sum(coolingPowerPort[1:end,1:end].Power)*(-1);
  totalElectricPower = sum(electricPowerPort[1:end].Power)*(-1);
  totalDissipationFlowRate = sum(dissipationPowerPort[1:end].Power)*(1);

  annotation (
    defaultComponentName="sem",
    defaultComponentPrefixes="inner",
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end SystemEnergyManager;
