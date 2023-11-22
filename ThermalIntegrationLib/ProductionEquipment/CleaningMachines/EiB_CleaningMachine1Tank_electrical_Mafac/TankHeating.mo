within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_electrical_Mafac;
package TankHeating
  model Tank1_heating
    extends .ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_electrical_Mafac.TechnicalConfiguration.TechnicalConfiguration_a;
    Real T_t1(start=341.15),
         Q_dot_t1(start=0),
         Q_dot_hall(start = 0);
    Modelica.Blocks.Interfaces.IntegerInput state
      annotation (Placement(transformation(extent={{-120,20},{-100,40}}),  iconTransformation(extent={{-120,20},
              {-100,40}})));
    Modelica.Blocks.Interfaces.RealInput Q_dot_batch
      annotation (Placement(transformation(extent={{-120,-40},{-100,-20}}), iconTransformation(extent={{-120,
              -40},{-100,-20}})));
    Modelica.Blocks.Interfaces.RealOutput P_el
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.BooleanOutput t1_state
      annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
    Modelica.Blocks.Interfaces.RealInput T_amb
      annotation (Placement(transformation(extent={{-120,70},{-100,90}}), iconTransformation(extent={{-120,70},{-100,90}})));
    Modelica.Blocks.Interfaces.RealInput T_batch
      annotation (Placement(transformation(extent={{-120,-90},{-100,-70}}), iconTransformation(extent={{-120,-90},{-100,-70}})));
    Modelica.Blocks.Interfaces.RealOutput T1 annotation (Placement(transformation(extent={{100,50},{120,70}})));
    Modelica.Blocks.Interfaces.BooleanOutput heating annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,110})));
  protected
    Real a_H2O = 350,
         a_air = 8,
         d_tt = 0.002,
         lambda_tt = 20,
         k = 1/(1/a_H2O+d_tt/lambda_tt+d_ins/lambda_ins+1/a_air);
                      // heat transfer coefficient resting water [W/m^2K]
                    // heat transfer coefficient air [W/m^2K]
                       // thickness wall without insulation [m]
                         // thermal conductivity stainless steel [W/mK]

  initial equation
    pre(heating) = false;

  equation
    heating = T_t1 <= T_lim or pre(heating) and T_t1 < T_req; // state tank1 heating on/off

    if state < 5 or state > 7 then // cleaning NOT in progress, fluid stays in tank
      Q_dot_hall = (T_t1-T_amb)*k*A_t1; // heat transfere to hall
      t1_state = false; // fluid is not in contact with batch
      if heating then // heating on, plus heat extraction by tankwall
        Q_dot_t1 = eta_heat*P_heat - Q_dot_hall;
        P_el = P_heat;
      else // heating off, only heat extraction by tankwall
        Q_dot_t1 = -Q_dot_hall;
        P_el = 0;
      end if;
    else // cleaning in progress, heat extraction by batch
      t1_state = true; // fluid is in contact with batch
      Q_dot_t1 = -Q_dot_batch;
      P_el = 0;
      Q_dot_hall = 0; // what is heat transfere to hall while cleaning?
    end if;

    der(T_t1) = Q_dot_t1/(m_t1*c_fluid); // tank1 temperature slope

    T1 = T_t1;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Line(
            points={{-64,34}},
            color={0,0,0},
            thickness=0.5),
          Text(
            extent={{-60,-66},{60,-100}},
            lineColor={0,0,0},
            textString="T1"),
          Rectangle(
            extent={{-40,-40},{40,-46}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Line(
            points={{-30,-40},{-30,80},{-20,86},{-10,80},{-8,0},{0,-8},{8,0},{10,80},{20,86},{30,80},
                {30,-40}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.Bezier),
          Line(
            points={{-26,-40},{-26,76},{-20,82},{-14,76},{-12,-4},{0,-12},{12,-4},{14,76},{20,82},{26,
                76},{26,-40}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.Bezier),
          Rectangle(
            extent={{-30,-52},{-20,-60}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Rectangle(
            extent={{20,-52},{30,-60}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Rectangle(
            extent={{-42,-46},{42,-52}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Rectangle(
            extent={{-6,-52},{6,-60}},
            lineColor={0,0,0},
            lineThickness=0.5)}),          Diagram(coordinateSystem(preserveAspectRatio=false)));
  end Tank1_heating;
end TankHeating;
