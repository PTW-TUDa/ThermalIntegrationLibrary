within ThermalIntegrationLib.FactoryBuildings.ThermalZones;
model MixedAir "Model of a room in which the air is completely mixed based on buildings 8.0.0"
  extends Buildings.ThermalZones.Detailed.MixedAir;

  Modelica.Blocks.Interfaces.RealOutput airHeatCapacity(unit="J/(kg.K)") annotation (Placement(transformation(extent={{160,-76},{194,-42}}),iconTransformation(extent={{160,-76},{194,-42}})));
  Modelica.Blocks.Interfaces.RealOutput airDensity(unit="kg/m3") annotation (Placement(transformation(extent={{162,-114},{198,-78}}),iconTransformation(extent={{162,-114},{198,-78}})));
  Medium.ThermodynamicState airState "current state of the room air";

initial equation
  airState=Medium.setState_pTX(p_start,T_start,X_start);
equation
  airState=Medium.setState_pTX(ports[1].p,heaPorAir.T,ports[1].Xi_outflow);
  airHeatCapacity=Medium.specificHeatCapacityCp(airState);
  airDensity=Medium.density(airState);
       annotation (
    Documentation(info="<html>
<p>
Room model that assumes the air to be completely mixed.
</p>
<p>
See
<a href=\"modelica://Buildings.ThermalZones.Detailed.UsersGuide\">Buildings.ThermalZones.Detailed.UsersGuide</a>
for detailed explanations.
</p>
</html>",
revisions="<html>
<ul>
<li>
April 8, 2019, by Michael Wetter:<br/>
Propagated parameter <code>mSenFac</code>.<br/>
This is for issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1405\">Buildings #1405</a>.
</li>
<li>
September 8, 2017, by Michael Wetter:<br/>
Enabled input connector <code>C_flow</code> to allow adding trace substances.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/481\">issue 481</a>.
</li>
<li>
October 29, 2016, by Michael Wetter:<br/>
Removed inheritance from
<a href=\"modelica://Buildings.Fluid.Interfaces.LumpedVolumeDeclarations\">
Buildings.Fluid.Interfaces.LumpedVolumeDeclarations</a>
to provide better comments.
</li>
<li>
May 2, 2016, by Michael Wetter:<br/>
Refactored implementation of latent heat gain.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/515\">issue 515</a>.
</li>
<li>
February 12, 2015, by Michael Wetter:<br/>
Propagated initial states to the fluid volume.
</li>
<li>
August 1, 2013, by Michael Wetter:<br/>
Introduced base class
<a href=\"modelica://Buildings.ThermalZones.Detailed.BaseClasses.RoomHeatMassBalance\">
Buildings.ThermalZones.Detailed.BaseClasses.RoomHeatMassBalance</a>
as the latent heat gains are treated differently in the mixed air and in the CFD model.
</li>
<li>
July 16, 2013, by Michael Wetter:<br/>
Redesigned implementation to remove one level of model hierarchy on the room-side heat and mass balance.
This change was done to facilitate the implementation of non-uniform room air heat and mass balance,
which required separating the convection and long-wave radiation models.<br/>
Changed assignment
<code>solRadExc(tauGla={0.6 for i in 1:NConExtWin})</code> to
<code>solRadExc(tauGla={datConExtWin[i].glaSys.glass[datConExtWin[i].glaSys.nLay].tauSol for i in 1:NConExtWin})</code> to
better take into account the solar properties of the glass.
</li>
<li>
March 7 2012, by Michael Wetter:<br/>
Added optional parameters <code>ove</code> and <code>sidFin</code> to
the parameter <code>datConExtWin</code>.
This allows modeling windows with an overhang or with side fins.
</li>
<li>
February 8 2012, by Michael Wetter:<br/>
Changed model to use new implementation of
<a href=\"modelica://Buildings.HeatTransfer.Radiosity.OutdoorRadiosity\">
Buildings.HeatTransfer.Radiosity.OutdoorRadiosity</a>.
This change leads to the use of the same equations for the radiative
heat transfer between window and ambient as is used for
the opaque constructions.
</li>
<li>
December 12, 2011, by Wangda Zuo:<br/>
Add glass thickness as a parameter for conExtWinRad. It is needed by the claculation of property for uncoated glass.
</li>
<li>
December 6, 2011, by Michael Wetter:<br/>
Fixed bug that caused convective heat gains to be
removed from the room instead of added to the room.
This error was caused by a wrong sign in
<a href=\"modelica://Buildings.ThermalZones.Detailed.BaseClasses.HeatGain\">
Buildings.ThermalZones.Detailed.BaseClasses.HeatGain</a>.
This closes ticket <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/46\">issue 46</a>.
</li>
<li>
August 9, 2011, by Michael Wetter:<br/>
Fixed bug that caused too high a surface temperature of the window frame.
The previous version did not compute the infrared radiation exchange between the
window frame and the sky. This has been corrected by adding the instance
<code>skyRadExcWin</code> and the parameter <code>absIRFra</code> to the
model
<a href=\"modelica://Buildings.ThermalZones.Detailed.BaseClasses.ExteriorBoundaryConditionsWithWindow\">
Buildings.ThermalZones.Detailed.BaseClasses.ExteriorBoundaryConditionsWithWindow</a>.
This closes ticket <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/36\">issue 36</a>.
</li>
<li>
August 9, 2011 by Michael Wetter:<br/>
Changed assignment of tilt in instances <code>bouConExt</code> and <code>bouConExtWin</code>.
This fixes the bug in <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/35\">issue 35</a>
that led to the wrong solar radiation gain for roofs and floors.
</li>
<li>
March 23, 2011, by Michael Wetter:<br/>
Propagated convection model to exterior boundary condition models.
</li>
<li>
December 14, 2010, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},
            {200,200}}), graphics={
        Text(
          extent={{-198,198},{-122,166}},
          lineColor={0,0,127},
          textString="uSha"),
        Text(
          extent={{-190,44},{-128,14}},
          lineColor={0,0,127},
          textString="C_flow",
          visible=use_C_flow)}));
end MixedAir;
