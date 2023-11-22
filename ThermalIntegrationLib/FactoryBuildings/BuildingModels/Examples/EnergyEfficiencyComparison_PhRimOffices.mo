within ThermalIntegrationLib.FactoryBuildings.BuildingModels.Examples;
model EnergyEfficiencyComparison_PhRimOffices "Comparison of an existing and refurbished factory building"
  extends Modelica.Icons.Example;
  inner ThermalIntegrationLib.BaseClasses.BldSystemEnergyManager sem(
    useBuilding=false,
    heatingEmissionFactor=1.1*240,
    coolingEmissionFactor=1.1*240,
    electricityEmissionFactor=485) annotation (Placement(transformation(extent={{36,10},{56,30}})));
  FactoryBuilding_productionHallRimOffices factoryBuilding_productionHallRimOffices(compareBuildings=true) annotation (Placement(transformation(extent={{-46,2},{-26,22}})));
  FactoryBuilding_productionHallRimOffices_eff factoryBuilding_productionHallRimOffices_eff(ID=2, compareBuildings=true) annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false), graphics={Text(
          extent={{36,90},{82,64}},
          lineColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textString="Building models:
compareBuildings = true
System Energy Manager:
useBuilding = false
"),
  Text(   extent={{-66,-72},{-20,-98}},
          lineColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textString="A script with convinient plot settings can be found here:
ThermalIntegrationLib\\Scripts\\plotSettingsBuildingComparison.mos
(In the Simulation tab choose Run Script after simulating)")}),
    experiment(StopTime=31500000, __Dymola_Algorithm="Cvode"),
    __Dymola_experimentSetupOutput);
end EnergyEfficiencyComparison_PhRimOffices;
