within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_electrical;
model EiB_CleaningMachine_electrical
  extends ThermalIntegrationLib.ProductionEquipment.BaseClasses.BaseProductionEquipment(
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
    parameter Real tableProcessingProgramm[:,2]=[0,1; 86400,1];
    replaceable parameter
    ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_electrical.TechnicalConfiguration.TechnicalConfiguration_a
    TechnicalConfiguration constrainedby
    ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_electrical.TechnicalConfiguration.BaseClasses.TechnicalConfiguration_base;
  Modelica.Blocks.Math.MultiSum Sum_elPow(nu=7)
                                          annotation (Placement(transformation(extent={{128,-26},{140,-14}})));
  TankHeating.Tank1_heating tank1_heating annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  TankHeating.Tank2_heating tank2_heating annotation (Placement(transformation(extent={{-10,-120},{10,-100}})));
  Batches.batch batch annotation (Placement(transformation(extent={{60,-94},{88,-66}})));
  MechanicalProcesses.mech_processes mech_processes annotation (Placement(transformation(extent={{-10,100},{10,120}})));
  MechanicalProcesses.ah ah annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  MechanicalProcesses.scc scc annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  MechanicalProcesses.oil_separator oil_separator annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
  ProcessingProgramms.stateController stateController(Table=[16,15; 5,30; 6,60; 7,60; 12,10; 11,15; 8,60; 11,15; 14,60; 13,90; 17,15; 2,
        60])                                          annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Modelica.Blocks.Sources.RealExpression T2(y=tank2_heating.T2) annotation (Placement(transformation(extent={{-34,-12},{-20,0}})));
  Modelica.Blocks.Sources.RealExpression T1(y=tank1_heating.T1) annotation (Placement(transformation(extent={{-34,-112},{-20,-100}})));
  Modelica.Blocks.Sources.RealExpression T_amb(y=298.15) annotation (Placement(transformation(extent={{-120,-106},{-100,-86}})));
  Modelica.Blocks.Sources.RealExpression elBaseLoad(y=0.2) annotation (Placement(transformation(extent={{88,-130},{100,-120}})));
  Modelica.Blocks.Math.MultiSum Sum_Qhall(nu=3) annotation (Placement(transformation(extent={{-94,74},{
            -82,86}})));
  Modelica.Blocks.Sources.RealExpression Q_dot_hall_T1(y=tank1_heating.Q_dot_hall)
    annotation (Placement(transformation(extent={{-128,86},{-108,106}})));
  Modelica.Blocks.Sources.RealExpression Q_dot_hall_T2(y=tank2_heating.Q_dot_hall)
    annotation (Placement(transformation(extent={{-128,70},{-108,90}})));
  Batches.hot_batches hot_batches annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-110,-50})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=hot_batches.Q_dot/1000)
    annotation (Placement(transformation(extent={{-128,54},{-108,74}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression(y=operationMode)
    annotation (Placement(transformation(extent={{-160,-10},{-140,10}})));
equation
  electricDemand[1].Power[1] = Sum_elPow.y;
  electricDemand[1].Power[2] = Sum_elPow.y;
  electricDemand[1].Power[3] = Sum_elPow.y;
  dissipationFlowRate = Sum_Qhall.y * 1000;

  connect(stateController.state, mech_processes.state) annotation (Line(points={{-99,2},{-60,2},{-60,110},{-11,110}}, color={255,127,0}));
  connect(ah.state, mech_processes.state) annotation (Line(points={{-11,70},{-60,70},{-60,110},{-11,110}}, color={255,127,0}));
  connect(scc.state, mech_processes.state) annotation (Line(points={{-11,30},{-60,30},{-60,110},{-11,110}}, color={255,127,0}));
  connect(tank1_heating.state, mech_processes.state)
    annotation (Line(points={{-11,-10},{-60,-10},{-60,110},{-11,110}}, color={255,127,0}));
  connect(stateController.dur_t1, oil_separator.dur_t1) annotation (Line(points={{-99,6},{40,6},{40,-36},{59,-36}}, color={0,0,127}));
  connect(batch.tank_time, stateController.tank_time) annotation (Line(points={{59,-76},{-76,-76},{-76,-2},{-99,-2}}, color={0,0,127}));
  connect(stateController.new_batch, batch.new_batch) annotation (Line(points={{-99,-6},{-80,-6},{-80,-80},{59,-80}}, color={255,0,255}));
  connect(tank1_heating.T2, T2.y) annotation (Line(points={{-11,-6},{-19.3,-6}}, color={0,0,127}));
  connect(tank2_heating.T1, T1.y) annotation (Line(points={{-11,-106},{-19.3,-106}}, color={0,0,127}));
  connect(tank2_heating.T_amb, T_amb.y) annotation (Line(points={{-11,-102},{-20,-102},{-20,-96},{-99,-96}},  color={0,0,127}));
  connect(tank1_heating.T_amb, T_amb.y) annotation (Line(points={{-11,-2},{-40,-2},{-40,-96},{-99,-96}},  color={0,0,127}));
  connect(tank1_heating.t1_state, oil_separator.state_T1)
    annotation (Line(points={{11,-16},{20,-16},{20,-44},{59,-44}}, color={255,0,255}));
  connect(batch.t1_state, oil_separator.state_T1) annotation (Line(points={{59,-68},{20,-68},{20,-44},{59,-44}}, color={255,0,255}));
  connect(tank1_heating.T1, batch.T_t1) annotation (Line(points={{11,-4},{22,-4},{22,-72},{59,-72}}, color={0,0,127}));
  connect(batch.T_amb, T_amb.y) annotation (Line(points={{59,-84},{-40,-84},{-40,-96},{-99,-96}},  color={0,0,127}));
  connect(tank2_heating.t2_state, batch.t2_state) annotation (Line(points={{11,-116},{20,-116},{20,-88},{59,-88}}, color={255,0,255}));
  connect(tank2_heating.T2, batch.T_t2) annotation (Line(points={{11,-104},{52,-104},{52,-92},{59,-92}}, color={0,0,127}));
  connect(batch.q_dot_batch, tank1_heating.Q_dot_batch)
    annotation (Line(points={{89,-73},{100,-73},{100,-58},{-18,-58},{-18,-14},{-11,-14}}, color={0,0,127}));
  connect(tank2_heating.Q_dot_batch, tank1_heating.Q_dot_batch)
    annotation (Line(points={{-11,-114},{-18,-114},{-18,-14},{-11,-14}}, color={0,0,127}));
  connect(batch.t_batch, tank1_heating.T_batch)
    annotation (Line(points={{89,-87},{104,-87},{104,-54},{-14,-54},{-14,-18},{-11,-18}}, color={0,0,127}));
  connect(tank2_heating.T_batch, tank1_heating.T_batch)
    annotation (Line(points={{-11,-118},{-14,-118},{-14,-18},{-11,-18}}, color={0,0,127}));
  connect(tank2_heating.state, mech_processes.state)
    annotation (Line(points={{-11,-110},{-60,-110},{-60,110},{-11,110}}, color={255,127,0}));
  connect(elBaseLoad.y, Sum_elPow.u[1]) annotation (Line(points={{100.6,-125},{116,-125},{116,-16.4},{128,-16.4}},
                                                                                                               color={0,0,127}));
  connect(tank2_heating.P_el, Sum_elPow.u[2]) annotation (Line(points={{11,-110},{116,-110},{116,-17.6},{128,-17.6}},
                                                                                                                  color={0,0,127}));
  connect(oil_separator.P_el, Sum_elPow.u[3])
    annotation (Line(points={{81,-40},{116,-40},{116,-18.8},{128,-18.8}},       color={0,0,127}));
  connect(tank1_heating.P_el, Sum_elPow.u[4]) annotation (Line(points={{11,-10},{116,-10},{116,-20},{128,-20}},         color={0,0,127}));
  connect(mech_processes.P_el, Sum_elPow.u[5])
    annotation (Line(points={{11,110},{116,110},{116,-21.2},{128,-21.2}},          color={0,0,127}));
  connect(ah.P_el, Sum_elPow.u[6]) annotation (Line(points={{11,70},{116,70},{116,-22.4},{128,-22.4}},          color={0,0,127}));
  connect(scc.P_el, Sum_elPow.u[7]) annotation (Line(points={{11,30},{116,30},{116,-23.6},{128,-23.6}},          color={0,0,127}));
  connect(Sum_Qhall.u[1], Q_dot_hall_T1.y) annotation (Line(points={{-94,82.8},{-100,82.8},{-100,96},{
          -107,96}},                                                                                             color={0,0,127}));
  connect(Sum_Qhall.u[2], Q_dot_hall_T2.y) annotation (Line(points={{-94,80},{-102,80},{-102,80},{-107,
          80}},                                                                                                  color={0,0,127}));
  connect(hot_batches.new_batch, batch.new_batch)
    annotation (Line(points={{-98,-46},{-80,-46},{-80,-80},{59,-80}}, color={255,0,255}));
  connect(hot_batches.T_hall, T_amb.y)
    annotation (Line(points={{-98,-54},{-94,-54},{-94,-96},{-99,-96}}, color={0,0,127}));
  connect(realExpression.y, Sum_Qhall.u[3])
    annotation (Line(points={{-107,64},{-100,64},{-100,77.2},{-94,77.2}}, color={0,0,127}));
  connect(stateController.opMode, integerExpression.y)
    annotation (Line(points={{-122,0},{-139,0}}, color={255,127,0}));
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
end EiB_CleaningMachine_electrical;
