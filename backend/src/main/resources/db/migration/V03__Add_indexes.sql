CREATE INDEX IF NOT EXISTS idx_orders_id ON public.orders(id);
CREATE INDEX IF NOT EXISTS idx_product_id ON public.product(id);
CREATE INDEX IF NOT EXISTS idx_order_product_orderid ON public.order_product(order_id);
CREATE INDEX IF NOT EXISTS idx_order_product_orderid_productid ON public.order_product(order_id, product_id);
