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
enum ENUM_SIMBOLO
{
   TODOS,
   ACTUAL,
   ESPECIFICO
} simbolo;
//---
input int num_mag = 0;
input ENUM_TIPO_OP Tipo_OP = Todas;
input ENUM_SIMBOLO Simbolo = TODOS;
input string Nombre_del_simbolo = "";
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
{
//---
   string simbolo_cierre = "";
//---
   if(Simbolo == ESPECIFICO)
   {
      simbolo_cierre = Nombre_del_simbolo;
   }
   else if(Simbolo == ACTUAL)
   {
      simbolo_cierre = _Symbol;
   }
//---
   for(int i = OrdersTotal() - 1; i >= 0 ; i--) //recorrer el Terminal
   {
      bool b =  OrderSelect(i, SELECT_BY_POS);
      //--- si el # magico coincide con el del input y el simbolo es el correcto
      if(
         OrderMagicNumber() == num_mag
         && 
         (Simbolo == TODOS || (OrderSymbol() == simbolo_cierre && Simbolo != TODOS) ) )
      {
         if(OrderType() == OP_BUY && (Tipo_OP == BUY_Mercado || Tipo_OP == Todas)) //si la op seleccionada es una Compra ... cerramos al precio Bid
         {
            bool h = OrderClose(OrderTicket(), OrderLots(), Bid, 0);
         }
         else if(OrderType() == OP_SELL && (Tipo_OP == SELL_Mercado || Tipo_OP == Todas) ) //si la op seleccionada es una venta ... cerramos al precio Ask
         {
            bool h = OrderClose(OrderTicket(), OrderLots(), Ask, 0);
         }
         else if(OrderType() == OP_BUYLIMIT && (Tipo_OP == BUY_Limit || Tipo_OP == Todas)) //eliminamos los buy limit
         {
            bool h =  OrderDelete(OrderTicket());
         }
         else if(OrderType() == OP_SELLLIMIT && (Tipo_OP == SELL_Limit || Tipo_OP == Todas)) //eliminamos los sell limit
         {
            bool h =  OrderDelete(OrderTicket());
         }
         else if(OrderType() == OP_BUYSTOP && (Tipo_OP == BUY_Stop || Tipo_OP == Todas)) //eliminamos los buy stop
         {
            bool h =  OrderDelete(OrderTicket());
         }
         else if(OrderType() == OP_SELLSTOP && (Tipo_OP == SELL_Stop || Tipo_OP == Todas)) //eliminamos los sell stop
         {
            bool h =  OrderDelete(OrderTicket());
         }
      }
   }
}
//+------------------------------------------------------------------+
