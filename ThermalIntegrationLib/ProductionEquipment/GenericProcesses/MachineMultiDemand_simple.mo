within ThermalIntegrationLib.ProductionEquipment.GenericProcesses;
model MachineMultiDemand_simple
  extends ThermalIntegrationLib.BaseClasses.BaseProductionEquipment(
    heatDemands=0,
    coolDemands=1,
    electricDemands=2,
    operationModes=2,
    tableOperationMode=[0,0; 25200,0; 25200,2; 36000,2; 36000,1; 57600,1; 57600,2; 64800,2; 64800,0; 86400,0]);

equation

  electricDemand[1].Power[1] = 4.5e4;
  electricDemand[1].Power[2] = 3.3e4;

  electricDemand[2].Power[1] = 2.2e4;
  electricDemand[2].Power[2] = 1.1e4;

  coolDemand[1].Q_flow[1] = semPowerPort.electricPower*0.35;
  coolDemand[1].T_in[1] = 298.15;
  coolDemand[1].T_out[1] = 323.15;

  coolDemand[1].Q_flow[2] = semPowerPort.electricPower*0.45;
  coolDemand[1].T_in[2] = 303.15;
  coolDemand[1].T_out[2] = 313.15;

  0.0 = dissipationFlowRate + 150 * (T-surroundingTemperature);

 annotation (Documentation(info="<html>
 <p>Machine with multiple constant demands and two operation modes.</p>
<p>
To calculate the dissipation flow rate the <span style=\"font-family: Courier New;\">surroundingTemperature</span> is used. 
</p>
</html>"),Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end MachineMultiDemand_simple;
