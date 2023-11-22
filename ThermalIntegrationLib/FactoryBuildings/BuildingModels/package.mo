within ThermalIntegrationLib.FactoryBuildings;
package BuildingModels "Building models which can be used as model for the factory building"
  extends Modelica.Icons.VariantsPackage;

annotation (Documentation(info="<html>
<p>This sub-package contains some building models ready to use in the whole factory model or for the evaluation of building related energy efficiency measures. Each thermal zone is assigned a heat demand, cool demand and electricity demand (see <a href=\"modelica://ThermalIntegrationLib/FactoryBuildings/BaseClasses/BaseFactoryBuilding.mo\">BaseFactoryBuilding</a>).</p>
<p>Each building needs a unique ID.</p>
<p>If two building versions are to be compared:</p>
<ul>
<li>No machine models are present, i.e. machine waste heat can be only included as load profiles.</li>
<li>The <a href=\"modelica://ThermalIntegrationLib/FactoryBuildings/BaseClasses/BaseFactoryBuilding.mo\">BaseFactoryBuilding</a> parameter <b>compareBuildings</b> should be true.</li>
<li>The <a href=\"modelica://ThermalIntegrationLib/FactoryBuildings/BldSystemEnergyManager.mo\">BldSystemEnergyManager</a> parameter <b>useBuildings</b> should be false.</li>
<li>Examples can be found in <a href=\"modelica://ThermalIntegrationLib/FactoryBuildings/BuildingModels/Examples/package.mo\">ThermalIntegrationLib/FactoryBuildings/BuildingModels/Examples</a>.</li>
<li>If you have many zones or variants to test you should consider saving the reference results and loading them from a file instead of simulating the reference building every time.</li>
</ul>
<p><br>If a whole factory model is to be simulated:</p>
<ul>
<li>Only one &quot;building model&quot; may be present along with the machine models. The thermal zones don&apos;t have to be connected though, so it&apos;s possible to include a location with several buildings within one model. For the sake of simplicity we still call them building models.</li>
<li>The <a href=\"modelica://ThermalIntegrationLib/FactoryBuildings/BaseClasses/BaseFactoryBuilding.mo\">BaseFactoryBuilding</a> parameter <b>compareBuildings</b> should be false.</li>
<li>The <a href=\"modelica://ThermalIntegrationLib/FactoryBuildings/BldSystemEnergyManager.mo\">BldSystemEnergyManager</a> parameter <b>useBuildings</b> should be true.</li>
<li>Examples can be found in <a href=\"modelica://ThermalIntegrationLib/Examples/package.mo\">ThermalIntegrationLib/Examples</a>.</li>
</ul>
</html>"));
end BuildingModels;
