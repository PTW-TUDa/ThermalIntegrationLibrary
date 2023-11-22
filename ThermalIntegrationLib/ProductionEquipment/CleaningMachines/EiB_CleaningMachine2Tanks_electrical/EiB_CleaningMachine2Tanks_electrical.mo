within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_electrical;
model EiB_CleaningMachine2Tanks_electrical
  extends ThermalIntegrationLib.ProductionEquipment.BaseClasses.BaseProductionEquipment(
    electricDemands=1,
    ID=1,
    coolDemands=0,
    m=1300,
    cp=0.5,
    TInitial=298.15,
    heatDemands=0,
    tableOperationMode=[0,2; 86400,2],
    operationModes=3);
    parameter Integer tableProcessingProgramm[:,2]=[16,15; 5,30; 6,60; 7,60; 12,
      10; 11,15; 8,60; 11,15; 14,60; 13,90; 17,15; 2,60] "Washing programm (washing mode = first column, duration in s = second column)";
    parameter Real tableStates[:,2]=[1,0; 2,0; 3,5500; 4,1780; 5,1100; 6,0; 7,0]
              "State power definition for mechanical processes, heating power excluded (washing mode = first column, el. Power [W] = second column)";
    parameter Integer tableWashing_T1[:,1]=[3] "States when washing tank 1 is active";
    parameter Integer tableWashing_T2[:,1]=[4] "States when washing tank 2 is active";
    replaceable parameter
    ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_electrical.TechnicalConfiguration.TechnicalConfiguration_a
    TechnicalConfiguration constrainedby
    ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_electrical.TechnicalConfiguration.BaseClasses.TechnicalConfiguration_base;
  Modelica.Blocks.Math.MultiSum Sum_elPow(nu=4)
                                          annotation (Placement(transformation(extent={{128,-6},{140,
            6}})));
  ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_electrical.TankHeating.Tank1_heating tank1_heating(
    P_heat=TechnicalConfiguration.P_heat,
    eta_heat=TechnicalConfiguration.eta_heat,
    T_req=TechnicalConfiguration.T_req,
    T_lim=TechnicalConfiguration.T_lim,
    m_t1=TechnicalConfiguration.m_t1,
    A_t1=TechnicalConfiguration.A_t1,
    c_fluid=TechnicalConfiguration.c_fluid,
    A_tt=TechnicalConfiguration.A_tt,
    d_ins=TechnicalConfiguration.d_ins,
    lambda_ins=TechnicalConfiguration.lambda_ins,
    washingTable=tableWashing_T1)                 annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_electrical.TankHeating.Tank2_heating tank2_heating(
    P_heat=TechnicalConfiguration.P_heat,
    eta_heat=TechnicalConfiguration.eta_heat,
    T_req=TechnicalConfiguration.T_req,
    T_lim=TechnicalConfiguration.T_lim,
    m_t2=TechnicalConfiguration.m_t2,
    A_t2=TechnicalConfiguration.A_t2,
    c_fluid=TechnicalConfiguration.c_fluid,
    A_tt=TechnicalConfiguration.A_tt,
    d_ins=TechnicalConfiguration.d_ins,
    lambda_ins=TechnicalConfiguration.lambda_ins,
    washingTable=tableWashing_T2)                 annotation (Placement(transformation(extent={{0,-120},{20,-100}})));
  ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_electrical.Batches.batch batch(
    m_batch=TechnicalConfiguration.m_batch,
    c_batch=TechnicalConfiguration.c_batch,
    m_rack=TechnicalConfiguration.m_rack,
    c_rack=TechnicalConfiguration.c_rack) annotation (Placement(transformation(extent={{70,-94},{98,-66}})));
  ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_electrical.MechanicalProcesses.mech_processes
    mech_processes(CustomStateTable=tableStates)
                   annotation (Placement(transformation(extent={{0,50},{20,70}})));
  ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_electrical.ProcessingProgramms.stateController
    stateController(
    T_req=TechnicalConfiguration.T_req,
    T_lim=TechnicalConfiguration.T_lim,
    stateTable=tableProcessingProgramm,
    washingTable_T1=tableWashing_T1,
    washingTable_T2=tableWashing_T2)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Sources.RealExpression T2(y=tank2_heating.T2) annotation (Placement(transformation(extent={{-24,-12},{-10,0}})));
  Modelica.Blocks.Sources.RealExpression T1(y=tank1_heating.T1) annotation (Placement(transformation(extent={{-24,-112},{-10,-100}})));
  Modelica.Blocks.Sources.RealExpression T_amb(y=surroundingTemperature)
                                                         annotation (Placement(transformation(extent={{-100,-106},{-80,-86}})));
  Modelica.Blocks.Sources.RealExpression elBaseLoad(y=0.2) annotation (Placement(transformation(extent={{88,-130},{100,-120}})));
  Modelica.Blocks.Math.MultiSum Sum_Qhall(nu=3) annotation (Placement(transformation(extent={{-94,74},{
            -82,86}})));
  Modelica.Blocks.Sources.RealExpression Q_dot_hall_T1(y=tank1_heating.Q_dot_hall)
    annotation (Placement(transformation(extent={{-128,90},{-108,110}})));
  Modelica.Blocks.Sources.RealExpression Q_dot_hall_T2(y=tank2_heating.Q_dot_hall)
    annotation (Placement(transformation(extent={{-128,74},{-108,94}})));
  ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_electrical.Batches.hot_batches hot_batches(
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
equation
  electricDemand[1].Power[1] = Sum_elPow.y;
  electricDemand[1].Power[2] = Sum_elPow.y;
  electricDemand[1].Power[3] = Sum_elPow.y;
  dissipationFlowRate = Sum_Qhall.y * 1000;

  connect(stateController.state, mech_processes.state) annotation (Line(points={{-69,6},{-40,6},{-40,60},{-1,60}},    color={255,127,0}));
  connect(batch.tank_time, stateController.tank_time) annotation (Line(points={{69,-76},{-56,-76},{-56,0},{-69,0}},   color={0,0,127}));
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
  connect(Sum_Qhall.u[1], Q_dot_hall_T1.y) annotation (Line(points={{-94,82.8},{-100,82.8},{-100,100},{-107,100}},
                                                                                                                 color={0,0,127}));
  connect(Sum_Qhall.u[2], Q_dot_hall_T2.y) annotation (Line(points={{-94,80},{-102,80},{-102,84},{-107,84}},     color={0,0,127}));
  connect(hot_batches.new_batch, batch.new_batch)
    annotation (Line(points={{-78,-56},{-62,-56},{-62,-80},{69,-80}}, color={255,0,255}));
  connect(stateController.opMode, integerExpression.y)
    annotation (Line(points={{-92,0},{-99,0}},   color={255,127,0}));
  connect(hot_batches.T_hall, T_amb.y) annotation (Line(points={{-78,-64},{-74,-64},{-74,-96},{-79,
          -96}},                                                                                          color={0,0,127}));
  connect(hot_batches.Q_dot, Sum_Qhall.u[3]) annotation (Line(points={{-101,-60},{-130,-60},{-130,
          77.2},{-94,77.2}},                                                                                         color={0,0,127}));
  connect(mech_processes.P_el, Sum_elPow.u[1]) annotation (Line(points={{21,60},{120,60},{120,3.15},{128,3.15}},     color={0,0,127}));
  connect(tank1_heating.P_el, Sum_elPow.u[2])
    annotation (Line(points={{21,-10},{120,-10},{120,-2},{128,-2},{128,1.05}},  color={0,0,127}));
  connect(tank2_heating.P_el, Sum_elPow.u[3])
    annotation (Line(points={{21,-110},{120,-110},{120,-2},{128,-2},{128,-1.05}},   color={0,0,127}));
  connect(elBaseLoad.y, Sum_elPow.u[4])
    annotation (Line(points={{100.6,-125},{128,-125},{128,-3.15}},                     color={0,0,127}));
  connect(stateController.T_mt1, T_mt1.y)
    annotation (Line(points={{-88,-12},{-92,-12},{-92,-25.3}},
                                                     color={0,0,127}));
  connect(T_mt2.y, stateController.T_mt2)
    annotation (Line(points={{-68,-25.3},{-68,-12},{-72,-12}}, color={0,0,127}));
  connect(heating_t1.y, stateController.heating_t1)
    annotation (Line(points={{-84,-25.3},{-84,-18},{-83,-18},{-83,-12}}, color={255,0,255}));
  connect(heating_t2.y, stateController.heating_t2)
    annotation (Line(points={{-76,-25.3},{-76,-18},{-77,-18},{-77,-12}}, color={255,0,255}));
  connect(stateController.state, tank2_heating.state)
    annotation (Line(points={{-69,6},{-28,6},{-28,-86},{-6,-86},{-6,-110},{-1,-110}}, color={255,127,0}));
  connect(tank1_heating.state, tank2_heating.state)
    annotation (Line(points={{-1,-10},{-28,-10},{-28,-86},{-6,-86},{-6,-110},{-1,-110}}, color={255,127,0}));
  connect(tank1_heating.t1_state, batch.t1_state) annotation (Line(points={{21,-16},{36,-16},{36,-68},{69,-68}}, color={255,0,255}));
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
end EiB_CleaningMachine2Tanks_electrical;
