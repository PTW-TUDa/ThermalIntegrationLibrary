within ThermalIntegrationLib.FactoryBuildings;
record ResultSummaryBldSEM "Record that is used for summary of the results"
  Modelica.SIunits.Heat annualHeatDemand(displayUnit="MWh") "Annual space heating demand of the buildings";
  Modelica.SIunits.Heat annualCoolDemand(displayUnit="MWh") "Annual space cooling demand of the buildings";
  Modelica.SIunits.Energy annualElectricDemand(displayUnit="MWh") "Annual building related electrical energy demand";
  Types.Money annualHeatingCost "Annual heating costs";
  Types.Money annualCoolingCost "Annual cooling costs";
  Types.Money annualElectricityCost "Annual electricity costs";
  Types.GHGemissions annualHeatingEmissions "Annual GHG emissions from heating";
  Types.GHGemissions annualCoolingEmissions "Annual GHG emissions from cooling";
  Types.GHGemissions annualElectricityEmissions "Annual GHG emissions from electricity";
  Types.Money annualEnergyCost "Annual total costs";
  Types.GHGemissions annualEmissions "Annual total emissions";

 annotation (
   Documentation(info=
"<html>
<p>
Record that is used for reference results.</p>
</html>",
revisions="<html>
<ul>
<li>
July 12, 2012, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end ResultSummaryBldSEM;
