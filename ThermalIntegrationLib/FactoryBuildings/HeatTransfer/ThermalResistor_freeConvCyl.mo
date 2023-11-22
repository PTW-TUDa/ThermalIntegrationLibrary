within ThermalIntegrationLib.FactoryBuildings.HeatTransfer;
model ThermalResistor_freeConvCyl "Resistance by free convection around a horizontal cylinder port a: wall, port b: far away from wall"
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;

  parameter Modelica.SIunits.Length length "Pipe length";
  parameter Modelica.SIunits.Length r_a "Outer pipe radius";
  replaceable package Medium = Buildings.Media.Air constrainedby Modelica.Media.Interfaces.PartialMedium;

  Modelica.SIunits.ThermalResistance R "Thermal resistance";

  Modelica.SIunits.NusseltNumber nu "Nusselt number";
  Modelica.SIunits.CoefficientOfHeatTransfer alpha "Heat transfer coefficient pipe/air";
  Modelica.SIunits.RayleighNumber ra "Rayleigh number";
  Modelica.SIunits.GrashofNumber gr "Grashof number";
  //Modelica.SIunits.KinematicViscosity visc = Medium.dynamicViscosity*;
  Modelica.SIunits.ThermalDiffusivity a_fluid "Thermal diffusivity of air";
  Medium.ThermodynamicState airState "current state of the room air";
  Modelica.SIunits.Temperature T_m "Average air temperature";
  parameter Modelica.SIunits.CubicExpansionCoefficient beta2 = 0.0036;

  // Debugging
  Real beta;
  Real eta;
  Real dens;
  Real pr;
  Real lambda;

protected
  parameter Modelica.SIunits.Area A=2*Modelica.Constants.pi*r_a*length "Heat exchanger area A";
  parameter Modelica.SIunits.Length charL=Modelica.Constants.pi*r_a "characteristic length of the problem";
  Real f3;

equation
  airState=Medium.setState_pTX(Medium.p_default,T_m,Medium.X_default);
  assert(ra<10^12, "Ra out of bounds",level = AssertionLevel.warning);
  assert(0.1<ra, "Ra out of bounds",level = AssertionLevel.warning);
  assert(Medium.prandtlNumber(airState)>10^(-3), "Pr out of bounds",level = AssertionLevel.warning);

  dT = R*Q_flow;
  T_m = (port_a.T+port_b.T)/2;
  gr = -beta2*(port_a.T-port_b.T)*Modelica.Constants.g_n*charL^3/(Medium.dynamicViscosity(airState)/Medium.density(airState))^2;
  a_fluid = Medium.thermalConductivity(airState)/(Medium.density(airState)*Medium.specificHeatCapacityCp(airState));
  ra = abs(gr)*Medium.prandtlNumber(airState);
  f3 = (1+(0.559/Medium.prandtlNumber(airState))^(9/16))^(-16/9);
  nu = (0.752+0.387*(ra*f3)^(1/6))^2;
  alpha = nu*Medium.thermalConductivity(airState)/charL;
  R = 1/(alpha*A);

  // Debugging
  beta = Medium.isobaricExpansionCoefficient(airState);
  eta = Medium.dynamicViscosity(airState);
  dens = Medium.density(airState);
  pr = Medium.prandtlNumber(airState);
  lambda = Medium.thermalConductivity(airState);

 annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-90,70},{90,-70}},
          pattern=LinePattern.None,
          fillColor={192,192,192},
          fillPattern=FillPattern.Forward),
        Line(
          points={{-90,70},{-90,-70}},
          thickness=0.5),
        Line(
          points={{90,70},{90,-70}},
          thickness=0.5),
        Text(
          extent={{-150,115},{150,75}},
          textString="%name",
          lineColor={0,0,255}),
        Text(
          extent={{-150,-75},{150,-105}},
          textString="R=%R")}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Line(
          points={{-80,0},{80,0}},
          color={255,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-100,-20},{100,-40}},
          lineColor={255,0,0},
          textString="Q_flow"),
        Text(
          extent={{-100,40},{100,20}},
          textString="dT = port_a.T - port_b.T")}),
    Documentation(info="<html>
<p>This is a model for transport of heat without storing it, same as the <a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">ThermalConductor</a> but using the thermal resistance instead of the thermal conductance as a parameter. This is advantageous for series connections of ThermalResistors, especially if it shall be allowed that a ThermalResistance is defined to be zero (i.e. no temperature difference).</p>
<p>In this model the thermal resistance&nbsp;by&nbsp;free&nbsp;convection&nbsp;around&nbsp;a&nbsp;horizontal&nbsp;cylinder is calculated according to [1].</p>
<p>At port&nbsp;a the pipe&nbsp;wall should be connected and at port&nbsp;b the conditions&nbsp;far&nbsp;away&nbsp;from&nbsp;the wall.</p>
<p><br>[1] Gnielinski, V.; Kabelac, S.; Kind, M.; Martin, H.; Mewes, D.; Schaber, K.; Stephan, P. VDI-W&auml;rmeatlas; VDI e.V.: D&uuml;sseldorf, Germany, 2013; Volume 11.</p>
</html>"));
end ThermalResistor_freeConvCyl;
