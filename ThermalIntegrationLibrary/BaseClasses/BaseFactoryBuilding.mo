within ThermalIntegrationLibrary.BaseClasses;
partial model BaseFactoryBuilding
  extends ThermalIntegrationLibrary.BaseClasses.Icons.BaseFactoryBuilding;
  //outer BldSystemEnergyManager semBld if compareBuildings "System energy manager";
//protected
  outer ThermalIntegrationLibrary.BaseClasses.SystemEnergyManager sem "System energy manager";
  ThermalIntegrationLibrary.BaseClasses.Internals.SemPowerPort semPowerPort;
 // ThermalIntegrationLib.Internals.BuildingPort buildingPort;
//public
  parameter Integer ID = 1 "Unique ID";
  parameter Integer heatDemands = 1 "Number of heat demands";
  parameter Integer coolDemands = 1 "Number of cool demands";
  parameter Integer electricDemands = 1 "Number of electric demands";
  final parameter Integer operationModes = 1 "Operation modes 0: off, 1: ..., 2:...";
  parameter Boolean compareBuildings=false "Set to true if only building energy efficiency measures are to be compared";

  ThermalIntegrationLibrary.BaseClasses.Internals.Q_flowDemand[heatDemands] heatDemand(each final operationModes=operationModes);
  ThermalIntegrationLibrary.BaseClasses.Internals.Q_flowDemand[coolDemands] coolDemand(each final operationModes=operationModes);
  ThermalIntegrationLibrary.BaseClasses.Internals.ElectricDemand[electricDemands] electricDemand(each final operationModes=operationModes);

  //parameter Real tableOperationMode[:, 2] = [0, 0; 1, 0]
  //  "Table matrix (time = first column; operationMode = second column)";

 Integer operationMode = 1;

 //get total dissipation power from outer sim
 //SI.Power totalDissipationFlowRate=if compareBuildings then 0 else sem.totalDissipationFlowRate;

 //dissipation power of building not relevant
 SI.Power dissipationFlowRate=semPowerPort.dissipationPowerPort.Power;

 //define inside and outside temperature and pass to outer sim
 input SI.Temperature insideTemperature
                                       "Inside temperature" annotation (Dialog(group = "Variables", enable=true));
 input SI.Temperature outsideTemperature "Outside temperature" annotation (Dialog(group = "Variables", enable=true));

//initial equation
  //totalDissipationFlowRate
equation
  dissipationFlowRate= 0.0;
  if not compareBuildings then
    semPowerPort.buildingPort.insideTemperature = insideTemperature;
    semPowerPort.buildingPort.outsideTemperature = outsideTemperature;
  end if;
 //connect ports for outer sim
 connect(sem.dissipationPowerPort[ID],semPowerPort.dissipationPowerPort);
 connect(sem.buildingPort,semPowerPort.buildingPort);
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
<li><span style=\"font-family: Courier New;\">insideTemperature</span></li>
<li><span style=\"font-family: Courier New;\">outsideTemperature</span></li>
</ul>
</p>
<p>
The <span style=\"font-family: Courier New;\">insideTemperature</span> is the temperature of the building inside air volume. 
It can be used to calculate heat flow between machines and their surrounding. 
</p>
<br>
<p>
The following variables can be used:
<ul>
<li><span style=\"font-family: Courier New;\">totalDissipationFlowRate</span>&nbsp;&nbsp;Dissipation flow rate from all machines into the building inside air volume.</li>
</ul> </p>
</html>"),Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-160,140},{160,110}},
          textColor={106,106,106},
          textString="%name")}),                                 Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end BaseFactoryBuilding;
