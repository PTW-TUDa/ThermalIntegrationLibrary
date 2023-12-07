within ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.ProcessController;
model ProcessController
  parameter Real ProcessingProgramm1[:,4]
                                         "Table which defines power demand of components during operating modes (operating mode = first column; power demand = following columns)";
  parameter Real ProcessingProgramm2[:,4]
                                         "Table which defines power demand of components during operating modes (operating mode = first column; power demand = following columns)";
  parameter Real ProcessingProgramm3[:,4]
                                         "Table which defines power demand of components during operating modes (operating mode = first column; power demand = following columns)";
  parameter Real ProcessingProgramm4[:,4]
                                         "Table which defines power demand of components during operating modes (operating mode = first column; power demand = following columns)";

  Modelica.Blocks.Interfaces.IntegerInput OperatingMode "Operating mode as defined by VDMA [0 = Off, 1 = Standby, 2 = Powering up, 3 = Working, 4 = Operational, 5 = Powering down].]"
                                                        annotation (Placement(transformation(extent={{-240,80},{-200,120}})));
  Modelica.Blocks.Interfaces.IntegerInput ProcessingProgramm "A processing programm defines a workpiece-specific programm (e.g. temperature profile)" annotation (Placement(transformation(extent={{-240,-120},{-200,-80}})));
  Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus controlBus annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={200,0}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={200,0})));
  Modelica.Blocks.Routing.Extractor extractor(nin=4)
                                              annotation (Placement(transformation(extent={{58,30},{78,50}})));
  Modelica.Blocks.Routing.Extractor extractor1(nin=4)
                                               annotation (Placement(transformation(extent={{58,-10},{78,10}})));
  Modelica.Blocks.Routing.Extractor extractor2(nin=4)
                                               annotation (Placement(transformation(extent={{58,-50},{78,-30}})));
  Modelica.Blocks.Tables.CombiTable1Ds ProcessingProgramm_1(table=ProcessingProgramm1)                                                 annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Math.IntegerToReal integerToReal annotation (Placement(transformation(extent={{-150,90},{-130,110}})));
  Modelica.Blocks.Tables.CombiTable1Ds ProcessingProgramm_2(table=ProcessingProgramm2)                                     annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Modelica.Blocks.Tables.CombiTable1Ds ProcessingProgramm_3(table=ProcessingProgramm3)                                    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Modelica.Blocks.Tables.CombiTable1Ds ProcessingProgramm_4(table=ProcessingProgramm4)                                    annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4_1 annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4_2 annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4_3 annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));

equation
  connect(ProcessingProgramm, extractor.index) annotation (Line(points={{-220,-100},{-140,-100},{-140,26},{68,26},{68,28}},color={255,127,0}));
  connect(extractor1.index, ProcessingProgramm) annotation (Line(points={{68,-12},{68,-14},{-140,-14},{-140,-100},{-220,-100}},
                                                                                                                            color={255,127,0}));
  connect(extractor2.index, ProcessingProgramm) annotation (Line(points={{68,-52},{68,-54},{-140,-54},{-140,-100},{-220,-100}}, color={255,127,0}));
  connect(extractor.y, controlBus.P_el_drives) annotation (Line(points={{79,40},{176,40},{176,
          0},{200,0}},                                                                                     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(extractor1.y, controlBus.P_el_coolingLubricantSystem) annotation (Line(points={{79,0},{
          200,0}},                                                                                        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(extractor2.y, controlBus.P_el_hydraulicSystem) annotation (Line(points={{79,-40},
          {176,-40},{176,0},{200,0}},                                                                                  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integerToReal.u, OperatingMode) annotation (Line(points={{-152,100},{-220,100}}, color={255,127,0}));
  connect(integerToReal.y, ProcessingProgramm_3.u) annotation (Line(points={{-129,100},{-120,100},{-120,-20},{-102,-20}}, color={0,0,127}));
  connect(ProcessingProgramm_2.u, ProcessingProgramm_3.u) annotation (Line(points={{-102,20},{-120,20},{-120,-20},{-102,-20}}, color={0,0,127}));
  connect(ProcessingProgramm_1.u, ProcessingProgramm_3.u) annotation (Line(points={{-102,60},{-120,60},{-120,-20},{-102,-20}}, color={0,0,127}));
  connect(ProcessingProgramm_1.y[1], multiplex4_1.u1[1]) annotation (Line(points={{-79,60},{-70,60},{-70,49},{-12,49}}, color={0,0,127}));
  connect(ProcessingProgramm_1.y[2], multiplex4_2.u1[1]) annotation (Line(points={{-79,60},{-70,60},{-70,9},{-12,9}}, color={0,0,127}));
  connect(ProcessingProgramm_1.y[3], multiplex4_3.u1[1]) annotation (Line(points={{-79,60},{-70,60},{-70,-31},{-12,-31}}, color={0,0,127}));
  connect(ProcessingProgramm_2.y[1], multiplex4_1.u2[1]) annotation (Line(points={{-79,20},{-60,20},{-60,43},{-12,43}}, color={0,0,127}));
  connect(ProcessingProgramm_2.y[2], multiplex4_2.u2[1]) annotation (Line(points={{-79,20},{-60,20},{-60,3},{-12,3}}, color={0,0,127}));
  connect(ProcessingProgramm_2.y[3], multiplex4_3.u2[1]) annotation (Line(points={{-79,20},{-60,20},{-60,-38},{-12,-38},{-12,-37}}, color={0,0,127}));
  connect(ProcessingProgramm_3.y[1], multiplex4_1.u3[1]) annotation (Line(points={{-79,-20},{-50,-20},{-50,37},{-12,37}}, color={0,0,127}));
  connect(ProcessingProgramm_3.y[2], multiplex4_2.u3[1]) annotation (Line(points={{-79,-20},{-50,-20},{-50,-3},{-12,-3}}, color={0,0,127}));
  connect(ProcessingProgramm_3.y[3], multiplex4_3.u3[1]) annotation (Line(points={{-79,-20},{-50,-20},{-50,-43},{-12,-43}}, color={0,0,127}));
  connect(ProcessingProgramm_4.y[1], multiplex4_1.u4[1]) annotation (Line(points={{-79,-60},{-40,-60},{-40,31},{-12,31}}, color={0,0,127}));
  connect(ProcessingProgramm_4.y[2], multiplex4_2.u4[1]) annotation (Line(points={{-79,-60},{-40,-60},{-40,-9},{-12,-9}}, color={0,0,127}));
  connect(ProcessingProgramm_4.y[3], multiplex4_3.u4[1]) annotation (Line(points={{-79,-60},{-40,-60},{-40,-49},{-12,-49}}, color={0,0,127}));
  connect(multiplex4_1.y, extractor.u) annotation (Line(points={{11,40},{56,40}}, color={0,0,127}));
  connect(multiplex4_2.y, extractor1.u) annotation (Line(points={{11,0},{56,0}}, color={0,0,127}));
  connect(multiplex4_3.y, extractor2.u) annotation (Line(points={{11,-40},{56,-40}}, color={0,0,127}));
  connect(integerToReal.y, ProcessingProgramm_4.u) annotation (Line(points={{-129,100},{-120,100},{-120,-60},{-102,-60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{200,200}}), graphics={Text(
          extent={{-180,200},{180,-200}},
          lineColor={0,0,0},
          textString="PLC"), Rectangle(
          extent={{-200,200},{200,-200}},
          lineColor={0,0,0},
          lineThickness=0.5)}),                                  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{200,200}})),
    Documentation(info="<html>
<p>Within the process controller model, the operating mode and processing programm are transferred to relevant values which are necessary to describe the process (e.g. temperature profiles or electric power demands). For that, several submoduls are utilized.</p>
</html>"));
end ProcessController;
