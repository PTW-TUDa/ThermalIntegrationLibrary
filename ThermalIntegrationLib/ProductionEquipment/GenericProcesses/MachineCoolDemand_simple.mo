within ThermalIntegrationLib.ProductionEquipment.GenericProcesses;
model MachineCoolDemand_simple
  extends ThermalIntegrationLib.BaseClasses.BaseProductionEquipment(
    heatDemands=0,
    coolDemands=1,
    electricDemands=0,
    operationModes=1,
    tableOperationMode=[0,1; 86400,1]);

equation
  coolDemand[1].Q_flow[1] = 5000;
  coolDemand[1].T_in[1] = 363.15;
  coolDemand[1].T_out[1] = 373.15;

  0.0 = dissipationFlowRate + 300 * (T-293.15);

 annotation (Documentation(info="<html>
 <p>Machine with a single constant cool demand.</p>
<p>
To fulfill the energy balance the dissipation flow rate is directed into the machine. The energy will be taken from the building inside air volume (constant temperature).
</p>
</html>"),Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end MachineCoolDemand_simple;
