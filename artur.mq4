//+------------------------------------------------------------------+
//|                                                        artur.mq4 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_separate_window
#property indicator_minimum 0
#property indicator_maximum 2
#property indicator_buffers 3
//--- input parameters
input double   level=1.06;
//--- indicator buffers
double         CrossLevelBufferUp[],CrossLevelBufferDown[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   IndicatorBuffers(2); 
   SetLevelValue(0,level);
   SetLevelStyle(STYLE_DOT,1,clrGray);
   SetIndexBuffer(1,CrossLevelBufferUp);
   SetIndexStyle(1,DRAW_HISTOGRAM,STYLE_SOLID,1,clrSeaGreen);  
   SetIndexBuffer(2,CrossLevelBufferDown);
   SetIndexStyle(2,DRAW_HISTOGRAM,STYLE_SOLID,1,clrRed); 
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   int    i,Counted_bars;
   double prev_bar,current_bar;
   datetime prevTick,currTick;
   
   prev_bar=0;
   current_bar=0;
   //ArraySetAsSeries(CrossLevelBufferUp,false); 
   //ArraySetAsSeries(CrossLevelBufferDown,false); 
   Counted_bars=IndicatorCounted(); // Количество просчитанных баров 
   i=Bars-Counted_bars-1;           // Индекс первого непосчитанного
   prevTick=iTime(Symbol(),Period(),i);
   prev_bar=High[i];
   i--;
   while(i>=0) {
      current_bar=High[i];
      CrossLevelBufferDown[i]=0;
      CrossLevelBufferUp[i]=0;
      if(current_bar<=level && level<=prev_bar){
         CrossLevelBufferUp[i]=current_bar;
         currTick=iTime(Symbol(),Period(),i);
         Print("Bar[",i,"] time[",iTime(Symbol(),Period(),i),"] LONG value=",current_bar," prev=",prev_bar);
      }
      if(current_bar>=level && level>=prev_bar){
         CrossLevelBufferDown[i]=current_bar;
         currTick=iTime(Symbol(),Period(),i);
         Print("Bar[",i,"] time[",iTime(Symbol(),Period(),i),"] SHORT value=",current_bar," prev=",prev_bar);
      }
      prev_bar=current_bar;
      i--;
   }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   
  }
//+------------------------------------------------------------------+
