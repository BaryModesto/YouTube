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
//--
enum ENUM_TIPO_OP
{
   Todas,
   BUY_Mercado,
   SELL_Mercado,
   BUY_Limit,
   SELL_Limit,
   BUY_Stop,
   SELL_Stop
};
input int num_mag = 0;
input ENUM_TIPO_OP tipo_op = Todas;
input string Simbolo = "TODAS";
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
{
//---
   string simbolo_cierre = "";
//---
   if(Simbolo != "TODAS")
   {
      simbolo_cierre = Simbolo;
   }
   else if(Simbolo == "ACTUAL")
   {
      simbolo_cierre = _Symbol;
   }
//---
   for(int i = OrdersTotal() - 1; i >= 0 ; i--) //recorrer el Terminal
   {
      bool b =  OrderSelect(i, SELECT_BY_POS);
      //---
      if(OrderMagicNumber() == num_mag && (Simbolo == "TODAS" || OrderSymbol() == simbolo_cierre ) )  //si el # magico coincide con el del input
      {
         if(OrderType() == OP_BUY && (tipo_op == BUY_Mercado || tipo_op == Todas)) //si la op seleccionada es una Compra ... cerramos al precio Bid
         {
            bool h = OrderClose(OrderTicket(), OrderLots(), Bid, 0);
         }
         else if(OrderType() == OP_SELL && (tipo_op == SELL_Mercado || tipo_op == Todas) ) //si la op seleccionada es una venta ... cerramos al precio Ask
         {
            bool h = OrderClose(OrderTicket(), OrderLots(), Ask, 0);
         }
         else if(OrderType() == OP_BUYLIMIT && (tipo_op == BUY_Limit || tipo_op == Todas)) //eliminamos los buy limit
         {
            bool h =  OrderDelete(OrderTicket());
         }
         else if(OrderType() == OP_SELLLIMIT && (tipo_op == SELL_Limit || tipo_op == Todas)) //eliminamos los sell limit
         {
            bool h =  OrderDelete(OrderTicket());
         }
         else if(OrderType() == OP_BUYSTOP && (tipo_op == BUY_Stop || tipo_op == Todas)) //eliminamos los buy stop
         {
            bool h =  OrderDelete(OrderTicket());
         }
         else if(OrderType() == OP_SELLSTOP && (tipo_op == SELL_Stop || tipo_op == Todas)) //eliminamos los sell stop
         {
            bool h =  OrderDelete(OrderTicket());
         }
      }
   }
}
//+------------------------------------------------------------------+
