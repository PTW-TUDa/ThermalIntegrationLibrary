within ThermalIntegrationLib.BaseClasses;
partial model BaseProductionEquipment
  extends ThermalIntegrationLib.BaseClasses.Icons.BaseProductionEquipment;
protected
  outer ThermalIntegrationLib.BaseClasses.SystemEnergyManager sem "System energy manager";
  ThermalIntegrationLib.Internals.SemPowerPort semPowerPort;

public
  parameter Integer ID = 1 "Unique ID";
  parameter Integer heatDemands = 1 "Number of heat demands";
  parameter Integer coolDemands = 1 "Number of cool demands";
  parameter Integer electricDemands = 1 "Number of electric demands";
  parameter Integer operationModes = 2 "Operation modes 0: off, 1: ..., 2:...";

  //define demands
  ThermalIntegrationLib.Internals.Q_flowDemand[heatDemands] heatDemand(each final operationModes=operationModes);
  ThermalIntegrationLib.Internals.Q_flowDemand[coolDemands] coolDemand(each final operationModes=operationModes);
  ThermalIntegrationLib.Internals.ElectricDemand[electricDemands] electricDemand(each final operationModes=operationModes);

  //define operation mode vs. time
  parameter Real tableOperationMode[:, 2] = [0, 0; 1, 0]
    "Table matrix (time = first column; operationMode = second column)";

  Modelica.Blocks.Sources.IntegerTable timeTable(table=tableOperationMode, startTime=sem.timeOffset, extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic);
  Integer operationMode = integer(timeTable.y);

 SI.HeatFlowRate dissipationFlowRate;
 SI.Temperature T;
 parameter SI.Temperature TInitial = 273.15+20 "Initial temperature of machine" annotation(Dialog(tab="Thermal",group="General"));
 parameter SI.SpecificHeatCapacity cp = 500 "Specific heat capacity of machine" annotation(Dialog(tab="Thermal",group="General"));
 parameter SI.Mass m = 1000 "Mass of machine" annotation(Dialog(tab="Thermal",group="General"));

 //get the surrounding temperature from outer sim object
 SI.Temperature surroundingTemperature = sem.insideTemperature;

initial equation
  T=TInitial;
equation
 //dynamic energy balance
 der(T) = (sum(semPowerPort.heatingPowerPort[1:end].Power)-sum(semPowerPort.coolingPowerPort[1:end].Power)+sum(semPowerPort.electricPowerPort[1:end].Power)+dissipationFlowRate)/(m*cp);

 //pass demands to the port and connect ports to outer sim
 if heatDemands > 0 then
  for i in 1:heatDemands loop
    if operationMode == 0 then
      semPowerPort.heatingPowerPort[i].Power = 0.0;
      semPowerPort.heatingPowerPort[i].Temperature_in = -99;
      semPowerPort.heatingPowerPort[i].Temperature_out = -99;
    else
      semPowerPort.heatingPowerPort[i].Power = heatDemand[i].Q_flow[operationMode];
      semPowerPort.heatingPowerPort[i].Temperature_in = heatDemand[i].T_in[operationMode];
      semPowerPort.heatingPowerPort[i].Temperature_out = heatDemand[i].T_out[operationMode];
    end if;

    connect(sem.heatingPowerPort[ID,i],semPowerPort.heatingPowerPort[i]);
  end for;
 end if;

 if coolDemands > 0 then
  for i in 1:coolDemands loop
    if operationMode == 0 then
      semPowerPort.coolingPowerPort[i].Power = 0.0;
      semPowerPort.coolingPowerPort[i].Temperature_in = -99;
      semPowerPort.coolingPowerPort[i].Temperature_out = -99;
    else
      semPowerPort.coolingPowerPort[i].Power = coolDemand[i].Q_flow[operationMode];
      semPowerPort.coolingPowerPort[i].Temperature_in = coolDemand[i].T_in[operationMode];
      semPowerPort.coolingPowerPort[i].Temperature_out = coolDemand[i].T_out[operationMode];
    end if;

    connect(sem.coolingPowerPort[ID,i],semPowerPort.coolingPowerPort[i]);
  end for;
 end if;

 if electricDemands > 0 then
  for i in 1:electricDemands loop
    if operationMode == 0 then
      semPowerPort.electricPowerPort[i].Power = 0.0;
    else
      semPowerPort.electricPowerPort[i].Power = electricDemand[i].Power[operationMode];
    end if;
    connect(sem.electricPowerPort[ID],semPowerPort.electricPowerPort[i]);
  end for;
 end if;

 semPowerPort.dissipationPowerPort.Power = dissipationFlowRate;
 connect(sem.dissipationPowerPort[ID],semPowerPort.dissipationPowerPort);

  annotation (Documentation(info="<html>
  <p>Base class for any production equipment. This partial model provides the connection to the inner sem (SystemEnergyManager) object.</p>
<p>
Besides the parameters the following variables need to be specified:
<ul>
<li><span style=\"font-family: Courier New;\">heatDemand[1...heatDemands].Q_flow[1...operationModes]</span></li>
<li><span style=\"font-family: Courier New;\">heatDemand[1...heatDemands].T_in[1...operationModes]</span></li>
<li><span style=\"font-family: Courier New;\">heatDemand[1...heatDemands].T_out[1...operationModes]</span></li>
</ul> </p>
<p>
<ul>
<li><span style=\"font-family: Courier New;\">coolDemand[1...coolDemands].Q_flow[1...operationModes]</span></li>
<li><span style=\"font-family: Courier New;\">coolDemand[1...coolDemands].T_in[1...operationModes]</span></li>
<li><span style=\"font-family: Courier New;\">coolDemand[1...coolDemands].T_out[1...operationModes]</span></li>
</ul>
</p>
<p>
<ul>
<li> <span style=\"font-family: Courier New;\">electricDemand[1...electricDemands].Power[1...operationModes]</span></li>
</ul>
</p>
<p>
<ul>
<li><span style=\"font-family: Courier New;\">dissipationFlowRate</span></li>
</ul>
</p>
<p>
The <span style=\"font-family: Courier New;\">dissipationFlowRate</span> is the total heat flow dissipated to the surrounding of the machine. 
It is necessary for a consistent energy balance and is used for interaction with the building model. 
</p>
<br>
<p>
The following variables can be used:
<ul>
<li><span style=\"font-family: Courier New;\">T</span>&nbsp;&nbsp;Temeperature of machine as result of an energy balance and thermal mass</li>
<li><span style=\"font-family: Courier New;\">surroundingTemperature</span>&nbsp;&nbsp;Temeperature of machine surroundings calculated in the SystemEnergyManager</li>
</ul> </p>
</html>"),Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-160,140},{160,110}},
          textColor={106,106,106},
          textString="%name")}),                                 Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
end BaseProductionEquipment;
