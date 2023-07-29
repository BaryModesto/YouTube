//+------------------------------------------------------------------+
//|                                                    Cerrar_OP.mq4 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property script_show_inputs
//---
input int num_mag = 0;
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
{
//---
   for(int i = OrdersTotal() - 1; i >= 0 ; i--) //recorrer el Terminal
   {
      bool b =  OrderSelect(i, SELECT_BY_POS);
      //---
      if(OrderMagicNumber() == num_mag)  //si el # magico coincide con el del input
      {
         if(OrderType() == OP_BUY)     //si la op seleccionada es una Compra ... cerramos al precio Bid
         {
            bool h = OrderClose(OrderTicket(), OrderLots(), Bid, 0);
         }
         else if(OrderType() == OP_SELL)
         {
            bool h = OrderClose(OrderTicket(), OrderLots(), Ask, 0);
         }
         else                          //es una order pendiente
         {
            bool h =  OrderDelete(OrderTicket());
         }
      }
   }
}
//+------------------------------------------------------------------+
