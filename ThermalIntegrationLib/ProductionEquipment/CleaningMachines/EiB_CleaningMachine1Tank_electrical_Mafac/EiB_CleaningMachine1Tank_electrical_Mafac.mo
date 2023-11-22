within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_electrical_Mafac;
model EiB_CleaningMachine1Tank_electrical_Mafac
  extends ThermalIntegrationLib.BaseClasses.BaseProductionEquipment(
    electricDemands=1,
    ID=1,
    coolDemands=0,
    m=1300,
    cp=0.5,
    TInitial=298.15,
    heatDemands=0,
    tableOperationMode=[0,3; 12600,3; 12600,2; 15300,2; 15300,3; 27900,3; 27900,2; 28800,2; 28800,3; 41400,3; 41400,2; 44100,2; 44100,3; 56700,
        3; 56700,2; 57600,2; 57600,3; 70200,3; 70200,2; 72900,2; 72900,3; 85500,3; 85500,1; 86400,1],
    operationModes=3);
    parameter Integer tableProcessingProgramm[:,2]=[16,15; 5,30; 6,60; 7,60; 12,10; 11,15; 14,60; 13,90;
     17,15; 2,60] "Washing programm (washing mode = first column, duration in s = second column)";
    replaceable parameter ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_electrical_Mafac.TechnicalConfiguration.TechnicalConfiguration_a TechnicalConfiguration constrainedby ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_electrical_Mafac.TechnicalConfiguration.BaseClasses.TechnicalConfiguration_base;
  Modelica.Blocks.Math.MultiSum Sum_elPow(nu=6)
                                          annotation (Placement(transformation(extent={{128,-6},{140,
            6}})));
  .ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_electrical_Mafac.TankHeating.Tank1_heating tank1_heating(T_t1(start=298.15)) annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  .ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_electrical_Mafac.Batches.batch batch annotation (Placement(transformation(extent={{66,-94},{94,-66}})));
  .ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_electrical_Mafac.MechanicalProcesses.mech_processes mech_processes annotation (Placement(transformation(extent={{0,100},{20,120}})));
  .ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_electrical_Mafac.MechanicalProcesses.ah ah annotation (Placement(transformation(extent={{0,60},{20,80}})));
  .ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_electrical_Mafac.MechanicalProcesses.scc scc annotation (Placement(transformation(extent={{0,20},{20,40}})));
  .ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_electrical_Mafac.MechanicalProcesses.oil_separator oil_separator annotation (Placement(transformation(extent={{70,-50},{90,-30}})));
  .ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_electrical_Mafac.ProcessingProgramms.stateController stateController(stateTable=tableProcessingProgramm) annotation (Placement(transformation(extent={{-92,-10},{-72,10}})));
  Modelica.Blocks.Sources.RealExpression T_amb(y=298.15) annotation (Placement(transformation(extent={{-92,-102},{-72,-82}})));
  Modelica.Blocks.Sources.RealExpression elBaseLoad(y=0.2) annotation (Placement(transformation(extent={{96,-130},{108,-120}})));
  Modelica.Blocks.Math.MultiSum Sum_Qhall(nu=2) annotation (Placement(transformation(extent={{-86,74},{-74,86}})));
  Modelica.Blocks.Sources.RealExpression Q_dot_hall_T1(y=tank1_heating.Q_dot_hall)
    annotation (Placement(transformation(extent={{-120,80},{-100,100}})));
  .ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_electrical_Mafac.Batches.hot_batches hot_batches annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-80,-60})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression(y=operationMode)
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Modelica.Blocks.Sources.RealExpression T_mt(y=tank1_heating.T1) annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-87,-27})));
  Modelica.Blocks.Sources.BooleanExpression heating(y=tank1_heating.heating) annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-77,-27})));
equation
  electricDemand[1].Power[1] = Sum_elPow.y;
  electricDemand[1].Power[2] = Sum_elPow.y;
  electricDemand[1].Power[3] = Sum_elPow.y;
  dissipationFlowRate = Sum_Qhall.y * 1000;

  connect(stateController.state, mech_processes.state) annotation (Line(points={{-71,2},{-52,2},{-52,110},{-1,110}},  color={255,127,0}));
  connect(ah.state, mech_processes.state) annotation (Line(points={{-1,70},{-52,70},{-52,110},{-1,110}},   color={255,127,0}));
  connect(scc.state, mech_processes.state) annotation (Line(points={{-1,30},{-52,30},{-52,110},{-1,110}},   color={255,127,0}));
  connect(tank1_heating.state, mech_processes.state)
    annotation (Line(points={{-1,-7},{-52,-7},{-52,110},{-1,110}},     color={255,127,0}));
  connect(stateController.dur_t1, oil_separator.dur_t1) annotation (Line(points={{-71,6},{50,6},{50,-36},{69,-36}}, color={0,0,127}));
  connect(batch.tank_time, stateController.tank_time) annotation (Line(points={{65,-80},{-56,-80},{-56,-2},{-71,-2}}, color={0,0,127}));
  connect(stateController.new_batch, batch.new_batch) annotation (Line(points={{-71,-6},{-60,-6},{-60,-86},{65,-86}}, color={255,0,255}));
  connect(tank1_heating.T_amb, T_amb.y) annotation (Line(points={{-1,-2},{-32,-2},{-32,-92},{-71,-92}},   color={0,0,127}));
  connect(tank1_heating.t1_state, oil_separator.state_T1)
    annotation (Line(points={{21,-16},{28,-16},{28,-44},{69,-44}}, color={255,0,255}));
  connect(batch.t1_state, oil_separator.state_T1) annotation (Line(points={{65,-68},{28,-68},{28,-44},{69,-44}}, color={255,0,255}));
  connect(tank1_heating.T1, batch.T_t1) annotation (Line(points={{21,-4},{34,-4},{34,-74},{65,-74}}, color={0,0,127}));
  connect(batch.T_amb, T_amb.y) annotation (Line(points={{65,-92},{-71,-92}},                      color={0,0,127}));
  connect(batch.q_dot_batch, tank1_heating.Q_dot_batch)
    annotation (Line(points={{95,-73},{108,-73},{108,-58},{-10,-58},{-10,-13},{-1,-13}},  color={0,0,127}));
  connect(batch.t_batch, tank1_heating.T_batch)
    annotation (Line(points={{95,-87},{112,-87},{112,-54},{-6,-54},{-6,-18},{-1,-18}},    color={0,0,127}));
  connect(Sum_Qhall.u[1], Q_dot_hall_T1.y) annotation (Line(points={{-86,82.1},{-92,82.1},{-92,90},{-99,90}},    color={0,0,127}));
  connect(hot_batches.new_batch, batch.new_batch)
    annotation (Line(points={{-68,-56},{-60,-56},{-60,-86},{65,-86}}, color={255,0,255}));
  connect(stateController.opMode, integerExpression.y)
    annotation (Line(points={{-94,0},{-99,0}},   color={255,127,0}));
  connect(hot_batches.T_hall, T_amb.y) annotation (Line(points={{-68,-64},{-64,-64},{-64,-92},{-71,
          -92}},                                                                                          color={0,0,127}));
  connect(hot_batches.Q_dot, Sum_Qhall.u[2]) annotation (Line(points={{-91,-60},{-130,-60},{-130,77.9},
          {-86,77.9}},                                                                                              color={0,0,127}));
  connect(mech_processes.P_el, Sum_elPow.u[1]) annotation (Line(points={{21,110},{122,110},{122,3.5},
          {128,3.5}},                                                                                                color={0,0,127}));
  connect(ah.P_el, Sum_elPow.u[2]) annotation (Line(points={{21,70},{122,70},{122,-16},{128,-16},{128,
          2.1}},                                                                                               color={0,0,127}));
  connect(scc.P_el, Sum_elPow.u[3]) annotation (Line(points={{21,30},{122,30},{122,-16},{128,-16},{
          128,0.7}},                                                                                            color={0,0,127}));
  connect(tank1_heating.P_el, Sum_elPow.u[4])
    annotation (Line(points={{21,-10},{122,-10},{122,-16},{128,-16},{128,-0.7}},  color={0,0,127}));
  connect(oil_separator.P_el, Sum_elPow.u[5])
    annotation (Line(points={{91,-40},{120,-40},{120,-16},{128,-16},{128,-2.1}},  color={0,0,127}));
  connect(elBaseLoad.y, Sum_elPow.u[6])
    annotation (Line(points={{108.6,-125},{120,-125},{120,-16},{128,-16},{128,-3.5}},  color={0,0,127}));
  connect(stateController.T_mt, T_mt.y)
    annotation (Line(points={{-87,-12},{-87,-19.3}}, color={0,0,127}));
  connect(heating.y, stateController.heating)
    annotation (Line(points={{-77,-19.3},{-77.2,-19.3},{-77.2,-12}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{140,140}}), graphics={
                                                                      Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Bitmap(extent={{-80,-80},{80,80}}, fileName="modelica://ThermalIntegrationLib/Resources/Icon-Maschine.png"),
        Text(
          extent={{-160,140},{160,110}},
          textColor={106,106,106},
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{140,140}})));
end EiB_CleaningMachine1Tank_electrical_Mafac;
