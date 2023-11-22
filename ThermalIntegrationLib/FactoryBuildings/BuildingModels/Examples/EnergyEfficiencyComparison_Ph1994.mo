within ThermalIntegrationLib.FactoryBuildings.BuildingModels.Examples;
model EnergyEfficiencyComparison_Ph1994 "Comparison of an existing and refurbished factory building"
  extends Modelica.Icons.Example;
  FactoryBuilding_productionHall1994 factoryBuilding_productionHall1994(compareBuildings=true) annotation (Placement(transformation(extent={{-60,8},{-40,28}})));
  inner ThermalIntegrationLib.BaseClasses.BldSystemEnergyManager sem(
    heatingEmissionFactor=1.1*240,
    coolingEmissionFactor=1.1*240,
    electricityEmissionFactor=485,
    pvFeedinTariff=7.21*10^(-6)) annotation (Placement(transformation(extent={{36,10},{56,30}})));
  FactoryBuilding_productionHall1994_eff factoryBuilding_productionHall1994_eff(ID=2, compareBuildings=true)
                                                                                      annotation (Placement(transformation(extent={{-28,-32},{-8,-12}})));
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
end EnergyEfficiencyComparison_Ph1994;
