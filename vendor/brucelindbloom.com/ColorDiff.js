var Lab1 = {L:0.0, a:0.0, b:0.0};
var Lab2 = {L:0.0, a:0.0, b:0.0};
var DE1976 = 0.0;
var DE1994_Textiles = 0.0;
var DE1994_GraphicArts = 0.0;
var DE2000 = 0.0;
var DECMC_11 = 0.0;
var DECMC_21 = 0.0;

function ButtonClear(theForm)
{
	theForm.Lab1_L.value = "";
	theForm.Lab1_a.value = "";
	theForm.Lab1_b.value = "";
	
	theForm.Lab2_L.value = "";
	theForm.Lab2_a.value = "";
	theForm.Lab2_b.value = "";
	
	theForm.DE1976.value = "";
	theForm.DE1994_GraphicArts.value = "";
	theForm.DE1994_Textiles.value = "";
	
	theForm.DE2000.value = "";
	theForm.DECMC_11.value = "";
	theForm.DECMC_21.value = "";
}

function ButtonCalculate(theForm)
{
	GetLab1(theForm);
	GetLab2(theForm);
	DeltaE1976();
	DeltaE1994(true);
	DeltaE1994(false);
	DeltaE2000();
	DeltaECMC(1.0, 1.0);
	DeltaECMC(2.0, 1.0);
	FillAllCells(theForm);
}

function FillAllCells(theForm)
{
	theForm.Lab1_L.value = Lab1.L.toFixed(4);
	theForm.Lab1_a.value = Lab1.a.toFixed(4);
	theForm.Lab1_b.value = Lab1.b.toFixed(4);
	
	theForm.Lab2_L.value = Lab2.L.toFixed(4);
	theForm.Lab2_a.value = Lab2.a.toFixed(4);
	theForm.Lab2_b.value = Lab2.b.toFixed(4);
	
	theForm.DE1976.value = DE1976.toFixed(6);
	theForm.DE1994_Textiles.value = DE1994_Textiles.toFixed(6);
	theForm.DE1994_GraphicArts.value = DE1994_GraphicArts.toFixed(6);
	theForm.DE2000.value = DE2000.toFixed(6);
	theForm.DECMC_11.value = DECMC_11.toFixed(6);
	theForm.DECMC_21.value = DECMC_21.toFixed(6);
}

function GetLab1(theForm)
{
	Lab1.L = GetNumber(theForm.Lab1_L.value);
	Lab1.a = GetNumber(theForm.Lab1_a.value);
	Lab1.b = GetNumber(theForm.Lab1_b.value);
	
	Lab1.L = (Lab1.L < 0.0) ? 0.0 : (Lab1.L > 100.0) ? 100.0 : Lab1.L;
}

function GetLab2(theForm)
{
	Lab2.L = GetNumber(theForm.Lab2_L.value);
	Lab2.a = GetNumber(theForm.Lab2_a.value);
	Lab2.b = GetNumber(theForm.Lab2_b.value);
	
	Lab2.L = (Lab2.L < 0.0) ? 0.0 : (Lab2.L > 100.0) ? 100.0 : Lab2.L;
}

function GetNumber(s)
{
	var val = parseFloat(s);
	return(isNaN(val) ? 0.0 : val);
	
}

function DeltaE1976()
{
	var delL = Lab1.L - Lab2.L;
	var dela = Lab1.a - Lab2.a;
	var delb = Lab1.b - Lab2.b;
	DE1976 = Math.sqrt(delL * delL + dela * dela + delb * delb);
}

function DeltaE1994(textiles)
{
	var k1 = (textiles == true) ? 0.048 : 0.045;
	var k2 = (textiles == true) ? 0.014 : 0.015;
	var kL = (textiles == true) ? 2.0 : 1.0;
	var kC = 1.0;
	var kH = 1.0;

	var C1 = Math.sqrt(Lab1.a * Lab1.a + Lab1.b * Lab1.b);
	var C2 = Math.sqrt(Lab2.a * Lab2.a + Lab2.b * Lab2.b);
	
	var delA = Lab1.a - Lab2.a;
	var delB = Lab1.b - Lab2.b;
	var delC = C1 - C2;
	var delH2 = delA * delA + delB * delB - delC * delC;
	var delH = (delH2 > 0.0) ? Math.sqrt(delH2) : 0.0;
	var delL = Lab1.L - Lab2.L;
	
	var sL = 1.0;
	var sC = 1.0 + k1 * C1;
	var sH = 1.0 + k2 * C1;
	
	var vL = delL / (kL * sL);
	var vC = delC / (kC * sC);
	var vH = delH / (kH * sH);
	
	if (textiles == true)
	{
		DE1994_Textiles = Math.sqrt(vL * vL + vC * vC + vH * vH);
	}
	else
	{
		DE1994_GraphicArts = Math.sqrt(vL * vL + vC * vC + vH * vH);
	}
}

function DeltaE2000()
{
	var kL = 1.0;
	var kC = 1.0;
	var kH = 1.0;
	var lBarPrime = 0.5 * (Lab1.L + Lab2.L);
	var c1 = Math.sqrt(Lab1.a * Lab1.a + Lab1.b * Lab1.b);
	var c2 = Math.sqrt(Lab2.a * Lab2.a + Lab2.b * Lab2.b);
	var cBar = 0.5 * (c1 + c2);
	var cBar7 = cBar * cBar * cBar * cBar * cBar * cBar * cBar;
	var g = 0.5 * (1.0 - Math.sqrt(cBar7 / (cBar7 + 6103515625.0)));	/* 6103515625 = 25^7 */
	var a1Prime = Lab1.a * (1.0 + g);
	var a2Prime = Lab2.a * (1.0 + g);
	var c1Prime = Math.sqrt(a1Prime * a1Prime + Lab1.b * Lab1.b);
	var c2Prime = Math.sqrt(a2Prime * a2Prime + Lab2.b * Lab2.b);
	var cBarPrime = 0.5 * (c1Prime + c2Prime);
	var h1Prime = (Math.atan2(Lab1.b, a1Prime) * 180.0) / Math.PI;
	if (h1Prime < 0.0)
		h1Prime += 360.0;
	var h2Prime = (Math.atan2(Lab2.b, a2Prime) * 180.0) / Math.PI;
	if (h2Prime < 0.0)
		h2Prime += 360.0;
	var hBarPrime = (Math.abs(h1Prime - h2Prime) > 180.0) ? (0.5 * (h1Prime + h2Prime + 360.0)) : (0.5 * (h1Prime + h2Prime));
	var t = 1.0 -
			0.17 * Math.cos(Math.PI * (      hBarPrime - 30.0) / 180.0) +
			0.24 * Math.cos(Math.PI * (2.0 * hBarPrime       ) / 180.0) +
			0.32 * Math.cos(Math.PI * (3.0 * hBarPrime +  6.0) / 180.0) -
			0.20 * Math.cos(Math.PI * (4.0 * hBarPrime - 63.0) / 180.0);
	if (Math.abs(h2Prime - h1Prime) <= 180.0) 
		dhPrime = h2Prime - h1Prime;
	else 
		dhPrime = (h2Prime <= h1Prime) ? (h2Prime - h1Prime + 360.0) : (h2Prime - h1Prime - 360.0);
	var dLPrime = Lab2.L - Lab1.L;
	var dCPrime = c2Prime - c1Prime;
	var dHPrime = 2.0 * Math.sqrt(c1Prime * c2Prime) * Math.sin(Math.PI * (0.5 * dhPrime) / 180.0);
	var sL = 1.0 + ((0.015 * (lBarPrime - 50.0) * (lBarPrime - 50.0)) / Math.sqrt(20.0 + (lBarPrime - 50.0) * (lBarPrime - 50.0)));
	var sC = 1.0 + 0.045 * cBarPrime;
	var sH = 1.0 + 0.015 * cBarPrime * t;
	var dTheta = 30.0 * Math.exp(-((hBarPrime - 275.0) / 25.0) * ((hBarPrime - 275.0) / 25.0));
	var cBarPrime7 = cBarPrime * cBarPrime * cBarPrime * cBarPrime * cBarPrime * cBarPrime * cBarPrime;
	var rC = Math.sqrt(cBarPrime7 / (cBarPrime7 + 6103515625.0));
	var rT = -2.0 * rC * Math.sin(Math.PI * (2.0 * dTheta) / 180.0);
	DE2000 = Math.sqrt(
				(dLPrime / (kL * sL)) * (dLPrime / (kL * sL)) +
				(dCPrime / (kC * sC)) * (dCPrime / (kC * sC)) +
				(dHPrime / (kH * sH)) * (dHPrime / (kH * sH)) +
				(dCPrime / (kC * sC)) * (dHPrime / (kH * sH)) * rT);
}

function DeltaECMC(L, C)
{
	var c1 = Math.sqrt(Lab1.a * Lab1.a + Lab1.b * Lab1.b);
	var c2 = Math.sqrt(Lab2.a * Lab2.a + Lab2.b * Lab2.b);
	var sl = (Lab1.L < 16.0) ? (0.511) : ((0.040975 * Lab1.L) / (1.0 + 0.01765 * Lab1.L));
	var sc = (0.0638 * c1) / (1.0 + 0.0131 * c1) + 0.638;
	var h1 = (c1 < 0.000001) ? 0.0 : ((Math.atan2(Lab1.b, Lab1.a) * 180.0) / Math.PI);
	while (h1 < 0.0)
		h1 += 360.0;
	while (h1 >= 360.0)
		h1 -= 360.0;
	var t = ((h1 >= 164.0) && (h1 <= 345.0)) ? (0.56 + Math.abs(0.2 * Math.cos((Math.PI * (h1 + 168.0)) / 180.0))) : (0.36 + Math.abs(0.4 * Math.cos((Math.PI * (h1 + 35.0)) / 180.0)));
	var c4 = c1 * c1 * c1 * c1;
	var f = Math.sqrt(c4 / (c4 + 1900.0));
	var sh = sc * (f * t + 1.0 - f);
	var delL = Lab1.L - Lab2.L;
	var delC = c1 - c2;
	var delA = Lab1.a - Lab2.a;
	var delB = Lab1.b - Lab2.b;
	var dH2 = delA * delA + delB * delB - delC * delC;
	var v1 = delL / (L * sl);
	var v2 = delC / (C * sc);
	var v3 = sh;
	if (L == 2.0)
	{
		DECMC_21 = Math.sqrt(v1 * v1 + v2 * v2 + (dH2 / (v3 * v3)));
	}
	else
	{
		DECMC_11 = Math.sqrt(v1 * v1 + v2 * v2 + (dH2 / (v3 * v3)));
	}
}
