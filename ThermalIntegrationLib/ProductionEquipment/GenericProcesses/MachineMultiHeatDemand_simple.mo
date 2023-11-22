within ThermalIntegrationLib.ProductionEquipment.GenericProcesses;
model MachineMultiHeatDemand_simple
  extends ThermalIntegrationLib.BaseClasses.BaseProductionEquipment(
    heatDemands=2,
    coolDemands=0,
    electricDemands=0,
    operationModes=1,
    tableOperationMode=[0,1; 86400,1]);

equation
  heatDemand[1].Q_flow[1] = 3000;
  heatDemand[1].T_in[1] = 353.15;
  heatDemand[1].T_out[1] = 323.15;

  heatDemand[2].Q_flow[1] = 8000;
  heatDemand[2].T_in[1] = 333.15;
  heatDemand[2].T_out[1] = 323.15;

  0.0 = dissipationFlowRate + semPowerPort.heatingPower + semPowerPort.electricPower - semPowerPort.coolingPower;

 annotation (Documentation(info="<html>
 <p>Machine with a single constant heat demand.</p>
<p>
To calculate the dissipation flow rate a static energy balance is used. 
</p>
</html>"),Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end MachineMultiHeatDemand_simple;
