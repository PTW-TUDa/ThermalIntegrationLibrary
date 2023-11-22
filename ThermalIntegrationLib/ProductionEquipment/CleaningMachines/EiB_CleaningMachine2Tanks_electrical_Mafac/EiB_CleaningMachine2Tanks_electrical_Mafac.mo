within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_electrical_Mafac;
model EiB_CleaningMachine2Tanks_electrical_Mafac
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
    parameter Integer tableProcessingProgramm[:,2]=[16,15; 5,30; 6,60; 7,60; 12,
      10; 11,15; 8,60; 11,15; 14,60; 13,90; 17,15; 2,60] "Washing programm (washing mode = first column, duration in s = second column)";
    replaceable parameter
    ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_electrical_Mafac.TechnicalConfiguration.TechnicalConfiguration_a
    TechnicalConfiguration constrainedby
    ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_electrical_Mafac.TechnicalConfiguration.BaseClasses.TechnicalConfiguration_base;
  Modelica.Blocks.Math.MultiSum Sum_elPow(nu=7)
                                          annotation (Placement(transformation(extent={{128,-6},{140,
            6}})));
  TankHeating.Tank1_heating tank1_heating(
    m_batch=TechnicalConfiguration.m_batch,
    c_batch=TechnicalConfiguration.c_batch,
    m_rack=TechnicalConfiguration.m_rack,
    c_rack=TechnicalConfiguration.c_rack,
    P_heat=TechnicalConfiguration.P_heat,
    eta_heat=TechnicalConfiguration.eta_heat,
    T_req=TechnicalConfiguration.T_req,
    T_lim=TechnicalConfiguration.T_lim,
    m_t1=TechnicalConfiguration.m_t1,
    A_t1=TechnicalConfiguration.A_t1,
    c_fluid=TechnicalConfiguration.c_fluid,
    A_tt=TechnicalConfiguration.A_tt,
    d_ins=TechnicalConfiguration.d_ins,
    lambda_ins=TechnicalConfiguration.lambda_ins)
                                          annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  TankHeating.Tank2_heating tank2_heating(
    P_heat=TechnicalConfiguration.P_heat,
    eta_heat=TechnicalConfiguration.eta_heat,
    T_req=TechnicalConfiguration.T_req,
    T_lim=TechnicalConfiguration.T_lim,
    m_t2=TechnicalConfiguration.m_t2,
    A_t2=TechnicalConfiguration.A_t2,
    c_fluid=TechnicalConfiguration.c_fluid,
    A_tt=TechnicalConfiguration.A_tt,
    d_ins=TechnicalConfiguration.d_ins,
    lambda_ins=TechnicalConfiguration.lambda_ins)
                                          annotation (Placement(transformation(extent={{0,-120},{20,-100}})));
  Batches.batch batch(
    m_batch=TechnicalConfiguration.m_batch,
    c_batch=TechnicalConfiguration.c_batch,
    m_rack=TechnicalConfiguration.m_rack,
    c_rack=TechnicalConfiguration.c_rack)
                      annotation (Placement(transformation(extent={{70,-94},{98,-66}})));
  MechanicalProcesses.mech_processes mech_processes annotation (Placement(transformation(extent={{0,100},{20,120}})));
  MechanicalProcesses.ah ah annotation (Placement(transformation(extent={{0,60},{20,80}})));
  MechanicalProcesses.scc scc annotation (Placement(transformation(extent={{0,20},{20,40}})));
  ProcessingProgramms.stateController stateController(
    T_req=TechnicalConfiguration.T_req,
    T_lim=TechnicalConfiguration.T_lim,
    stateTable=tableProcessingProgramm)               annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Sources.RealExpression T2(y=tank2_heating.T2) annotation (Placement(transformation(extent={{-24,-12},{-10,0}})));
  Modelica.Blocks.Sources.RealExpression T1(y=tank1_heating.T1) annotation (Placement(transformation(extent={{-24,-112},{-10,-100}})));
  Modelica.Blocks.Sources.RealExpression T_amb(y=surroundingTemperature)
                                                         annotation (Placement(transformation(extent={{-100,-106},{-80,-86}})));
  Modelica.Blocks.Sources.RealExpression elBaseLoad(y=0.2) annotation (Placement(transformation(extent={{88,-130},{100,-120}})));
  Modelica.Blocks.Math.MultiSum Sum_Qhall(nu=4) annotation (Placement(transformation(extent={{-86,114},{-74,126}})));
  Modelica.Blocks.Sources.RealExpression Q_dot_hall_T1(y=tank1_heating.Q_dot_hall)
    annotation (Placement(transformation(extent={{-128,90},{-108,110}})));
  Modelica.Blocks.Sources.RealExpression Q_dot_hall_T2(y=tank2_heating.Q_dot_hall)
    annotation (Placement(transformation(extent={{-128,74},{-108,94}})));
  Batches.hot_batches hot_batches(
    m_batch=TechnicalConfiguration.m_batch,
    c_batch=TechnicalConfiguration.c_batch,
    m_rack=TechnicalConfiguration.m_rack,
    c_rack=TechnicalConfiguration.c_rack,
    T_req=TechnicalConfiguration.T_req)
                                  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,-60})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression(y=operationMode)
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Modelica.Blocks.Sources.RealExpression T_mt2(y=tank2_heating.T2) annotation (Placement(
        transformation(
        extent={{-7,-4},{7,4}},
        rotation=90,
        origin={-68,-33})));
  Modelica.Blocks.Sources.RealExpression T_mt1(y=tank1_heating.T1) annotation (Placement(
        transformation(
        extent={{-7,-4},{7,4}},
        rotation=90,
        origin={-92,-33})));
  Modelica.Blocks.Sources.BooleanExpression heating_t1(y=tank1_heating.heating_t1) annotation (
      Placement(transformation(
        extent={{-7,-4},{7,4}},
        rotation=90,
        origin={-84,-33})));
  Modelica.Blocks.Sources.BooleanExpression heating_t2(y=tank2_heating.heating_t2) annotation (
      Placement(transformation(
        extent={{-7,-4},{7,4}},
        rotation=90,
        origin={-76,-33})));
  MechanicalProcesses.units_waste_heat units_waste_heat(Q_waste_heat=TechnicalConfiguration.Q_waste_heat)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,50})));
  MechanicalProcesses.oil_separator oil_separator(pct=TechnicalConfiguration.pct_oil_sep)
    annotation (Placement(transformation(extent={{70,-40},{90,-20}})));
equation
  electricDemand[1].Power[1] = Sum_elPow.y;
  electricDemand[1].Power[2] = Sum_elPow.y;
  electricDemand[1].Power[3] = Sum_elPow.y;
  dissipationFlowRate = Sum_Qhall.y;

  connect(stateController.state, mech_processes.state) annotation (Line(points={{-69,2},{-50,2},{-50,110},{-1,110}},  color={255,127,0}));
  connect(ah.state, mech_processes.state) annotation (Line(points={{-1,70},{-50,70},{-50,110},{-1,110}},   color={255,127,0}));
  connect(scc.state, mech_processes.state) annotation (Line(points={{-1,30},{-50,30},{-50,110},{-1,110}},   color={255,127,0}));
  connect(tank1_heating.state, mech_processes.state)
    annotation (Line(points={{-1,-10},{-50,-10},{-50,110},{-1,110}},   color={255,127,0}));
  connect(batch.tank_time, stateController.tank_time) annotation (Line(points={{69,-76},{-56,-76},{-56,-2},{-69,-2}}, color={0,0,127}));
  connect(stateController.new_batch, batch.new_batch) annotation (Line(points={{-69,-6},{-62,-6},{-62,-80},{69,-80}}, color={255,0,255}));
  connect(tank1_heating.T2, T2.y) annotation (Line(points={{-1,-6},{-9.3,-6}},   color={0,0,127}));
  connect(tank2_heating.T1, T1.y) annotation (Line(points={{-1,-106},{-9.3,-106}},   color={0,0,127}));
  connect(tank2_heating.T_amb, T_amb.y) annotation (Line(points={{-1,-102},{-10,-102},{-10,-96},{-79,-96}},   color={0,0,127}));
  connect(tank1_heating.T_amb, T_amb.y) annotation (Line(points={{-1,-2},{-30,-2},{-30,-96},{-79,-96}},   color={0,0,127}));
  connect(tank1_heating.T1, batch.T_t1) annotation (Line(points={{21,-4},{32,-4},{32,-72},{69,-72}}, color={0,0,127}));
  connect(batch.T_amb, T_amb.y) annotation (Line(points={{69,-84},{-30,-84},{-30,-96},{-79,-96}},  color={0,0,127}));
  connect(tank2_heating.t2_state, batch.t2_state) annotation (Line(points={{21,-116},{30,-116},{30,-88},{69,-88}}, color={255,0,255}));
  connect(tank2_heating.T2, batch.T_t2) annotation (Line(points={{21,-104},{62,-104},{62,-92},{69,-92}}, color={0,0,127}));
  connect(batch.q_dot_batch, tank1_heating.Q_dot_batch)
    annotation (Line(points={{99,-73},{110,-73},{110,-58},{-8,-58},{-8,-14},{-1,-14}},    color={0,0,127}));
  connect(tank2_heating.Q_dot_batch, tank1_heating.Q_dot_batch)
    annotation (Line(points={{-1,-114},{-8,-114},{-8,-14},{-1,-14}},     color={0,0,127}));
  connect(batch.t_batch, tank1_heating.T_batch)
    annotation (Line(points={{99,-87},{114,-87},{114,-54},{-4,-54},{-4,-18},{-1,-18}},    color={0,0,127}));
  connect(tank2_heating.T_batch, tank1_heating.T_batch)
    annotation (Line(points={{-1,-118},{-4,-118},{-4,-18},{-1,-18}},     color={0,0,127}));
  connect(tank2_heating.state, mech_processes.state)
    annotation (Line(points={{-1,-110},{-50,-110},{-50,110},{-1,110}},   color={255,127,0}));
  connect(hot_batches.new_batch, batch.new_batch)
    annotation (Line(points={{-79,-56},{-62,-56},{-62,-80},{69,-80}}, color={255,0,255}));
  connect(stateController.opMode, integerExpression.y)
    annotation (Line(points={{-91,0},{-99,0}},   color={255,127,0}));
  connect(hot_batches.T_hall, T_amb.y) annotation (Line(points={{-79,-64},{-74,-64},{-74,-96},{-79,-96}}, color={0,0,127}));
  connect(mech_processes.P_el, Sum_elPow.u[1]) annotation (Line(points={{21,110},{120,110},{120,-2},{128,-2},{128,3.6}},
                                                                                                                     color={0,0,127}));
  connect(ah.P_el, Sum_elPow.u[2]) annotation (Line(points={{21,70},{120,70},{120,-2},{128,-2},{128,2.4}},     color={0,0,127}));
  connect(scc.P_el, Sum_elPow.u[3]) annotation (Line(points={{21,30},{120,30},{120,-2},{128,-2},{128,1.2}},     color={0,0,127}));
  connect(tank1_heating.P_el, Sum_elPow.u[4])
    annotation (Line(points={{21,-10},{120,-10},{120,-2},{128,-2},{128,0}},     color={0,0,127}));
  connect(tank2_heating.P_el, Sum_elPow.u[5])
    annotation (Line(points={{21,-110},{120,-110},{120,-2},{128,-2},{128,-1.2}},    color={0,0,127}));
  connect(elBaseLoad.y, Sum_elPow.u[6])
    annotation (Line(points={{100.6,-125},{128,-125},{128,-2.4}},                      color={0,0,127}));
  connect(stateController.T_mt1, T_mt1.y)
    annotation (Line(points={{-88,-11},{-92,-11},{-92,-25.3}},
                                                     color={0,0,127}));
  connect(T_mt2.y, stateController.T_mt2)
    annotation (Line(points={{-68,-25.3},{-68,-11},{-72,-11}}, color={0,0,127}));
  connect(heating_t1.y, stateController.heating_t1)
    annotation (Line(points={{-84,-25.3},{-84,-18},{-83,-18},{-83,-11}}, color={255,0,255}));
  connect(heating_t2.y, stateController.heating_t2)
    annotation (Line(points={{-76,-25.3},{-76,-18},{-77,-18},{-77,-11}}, color={255,0,255}));
  connect(hot_batches.Q_dot, Sum_Qhall.u[1]) annotation (Line(points={{-101,-60},{-132,-60},{-132,123.15},{-86,123.15}}, color={0,0,127}));
  connect(Q_dot_hall_T1.y, Sum_Qhall.u[2]) annotation (Line(points={{-107,100},{-94,100},{-94,121.05},{-86,121.05}}, color={0,0,127}));
  connect(Q_dot_hall_T2.y, Sum_Qhall.u[3])
    annotation (Line(points={{-107,84},{-94,84},{-94,117.9},{-86,117.9},{-86,118.95}}, color={0,0,127}));
  connect(units_waste_heat.Q_waste, Sum_Qhall.u[4]) annotation (Line(points={{-90,61},{-90,116},{-86,116},{-86,116.85}}, color={0,0,127}));
  connect(units_waste_heat.state, mech_processes.state)
    annotation (Line(points={{-90,39},{-90,18},{-50,18},{-50,110},{-1,110}}, color={255,127,0}));
  connect(stateController.processTime, oil_separator.processTime)
    annotation (Line(points={{-69,6},{36,6},{36,-26},{69,-26}}, color={0,0,127}));
  connect(tank1_heating.t1_state, oil_separator.state_T1)
    annotation (Line(points={{21,-16},{34,-16},{34,-34},{69,-34}}, color={255,0,255}));
  connect(oil_separator.P_el, Sum_elPow.u[7]) annotation (Line(points={{91,-30},{120,-30},{120,-3.6},{128,-3.6}}, color={0,0,127}));
  connect(batch.t1_state, tank1_heating.t1_state) annotation (Line(points={{69,-68},{34,-68},{34,-16},{21,-16}}, color={255,0,255}));
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
end EiB_CleaningMachine2Tanks_electrical_Mafac;
