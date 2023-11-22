within ThermalIntegrationLib.FactoryBuildings.ThermalZones;
record ResultSummaryZone "Record that is used for summary of the results"
 extends Internals.PartialSummary;
 Modelica.SIunits.Temperature T_room(displayUnit="degC") "Room air temperature";
 Modelica.SIunits.Temperature T_operative(displayUnit="degC") "Operative room temperature";
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
end ResultSummaryZone;
