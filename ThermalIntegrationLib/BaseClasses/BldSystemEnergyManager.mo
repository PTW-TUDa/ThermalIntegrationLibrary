within ThermalIntegrationLib.BaseClasses;
model BldSystemEnergyManager "Manages energy flows of machines and factory building"
  extends ThermalIntegrationLib.BaseClasses.SystemEnergyManager(
                              useBuilding=false);

  //ThermalIntegrationLib.Internals.ElectricPowerPort[nPV] pvPowerPort;

  parameter Integer nBuildings=2 "Number of building versions to be compared";
  //parameter Integer nPV(min=0,max=nBuildings)=0 "Number of buildings with a PV plant";
  //parameter Integer idPV[nPV](min=1,max=nBuildings) "IDs of the buildings with PV plant" annotation(dialog(enable=nPV>0));
  //parameter Boolean feedInOnly=false "Set to true if no self usage of PV electricity is desired" annotation(dialog(enable=nPV>0));
  // Annual demands
  Modelica.Units.SI.Heat annualHeatDemand[nBuildings](displayUnit="MWh") "Annual space heating demand of the buildings";
  Modelica.Units.SI.Heat annualCoolDemand[nBuildings](displayUnit="MWh") "Annual space cooling demand of the buildings";
  Modelica.Units.SI.Energy annualElectricDemand[nBuildings](displayUnit="MWh") "Annual building related electrical energy demand";
  // Annual costs
  // Annual emissions
  // PV
  //Modelica.SIunits.Energy annualPVfeedin[nPV](displayUnit="MWh") "Annual feed in by PV";

protected
  parameter Real perMWhToPerJ = 1/(3600*10^6);
  parameter Real kgPerMWhToTonsPerJ = 1/(3600*10^9);
equation
  for i in 1:nBuildings loop
    // Annual demands
    der(annualHeatDemand[i]) = heatingPowerPort[i,1].Power*(-1);
    der(annualCoolDemand[i]) = coolingPowerPort[i,1].Power*(1);
    //der(annualElectricDemand[nPV+1:nBuildings]) = electricPowerPort[nPV+1:nBuildings].Power*(-1);
    der(annualElectricDemand[i]) = electricPowerPort[i].Power*(-1);
    resultSummary[i].annualHeatDemand=annualHeatDemand[i];
    resultSummary[i].annualCoolDemand=annualCoolDemand[i];
    resultSummary[i].annualElectricDemand=annualElectricDemand[i];
/*
    // PV
    for j in 1:nPV loop
      if i==idPV[j] then // if building has PV plant
        if feedInOnly then // feed all PV to grid
          der(annualElectricDemand[i]) = electricPowerPort[j].Power*(-1);
        else // use own PV electricity
          der(annualElectricDemand[i]) = electricPowerPort[j].Power*(-1) - pvPowerPort[j].Power*(-1);
        end if;
      end if;
    end for;
    */
    // Annual costs
    instantElectricityCost[i] = if electricPowerPort[i].Power*(-1)>0 then electricPowerPort[i].Power*(-1)*electricityPricePerJ else electricPowerPort[i].Power*(-1)*pvFeedinTariffPerJ;
    annualHeatingCost[i] = heatingPricePerJ*annualHeatDemand[i];
    annualCoolingCost[i] = coolingPricePerJ*annualCoolDemand[i];
    der(annualElectricityCost[i]) = instantElectricityCost[i];
    //annualElectricityCost[i] = electricityPricePerJ*annualElectricDemand[i];
    resultSummary[i].annualHeatingCost = annualHeatingCost[i];
    resultSummary[i].annualCoolingCost = annualCoolingCost[i];
    resultSummary[i].annualElectricityCost = annualElectricityCost[i];
    resultSummary[i].annualEnergyCost = annualHeatingCost[i] + annualCoolingCost[i] + annualElectricityCost[i];

    // Annual emissions
    annualHeatingEmissions[i] = heatingEmissionFactorPerJ*annualHeatDemand[i];
    annualCoolingEmissions[i] = coolingEmissionFactorPerJ*annualCoolDemand[i];
    annualElectricityEmissions[i] = electricityEmissionFactorPerJ*annualElectricDemand[i];
    resultSummary[i].annualHeatingEmissions = annualHeatingEmissions[i];
    resultSummary[i].annualCoolingEmissions = annualCoolingEmissions[i];
    resultSummary[i].annualElectricityEmissions = annualElectricityEmissions[i];
    resultSummary[i].annualEmissions = annualHeatingEmissions[i] + annualCoolingEmissions[i] + annualElectricityEmissions[i];
  end for;
/*
  // PV
  if nPV>0 then
    annualPVproduction[1:end] = pvPowerPort[1:end].power*(-1);
  end if;
*/
  annotation (
    defaultComponentName="sem",
    defaultComponentPrefixes="inner",
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    Documentation(info="<html>
<p>The BldSystemEnergyManager can be used to compare two versions of a building model to evaluate building related energy efficiency measures. Annual energy demands, costs and emissions are calculated and may be visualized running a prepared <a href=\"modelica://ThermalIntegrationLib/Scripts/plotSettingsBuildingComparison.mos\">script</a> after simulating.</p>
<p>For examples see <a href=\"modelica://ThermalIntegrationLib/FactoryBuildings/BuildingModels/Examples/package.mo\">BuildingModels/Examples</a>.</p>
</html>"));
end BldSystemEnergyManager;
