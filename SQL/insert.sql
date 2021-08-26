/*------------------ 为提高插入速度，暂时禁用约束 ------------------*/
-- 主码约束
/*
ALTER TABLE Activity
DISABLE CONSTRAINT pk_Activity;

ALTER TABLE Administractor
DISABLE CONSTRAINT pk_Admin;

ALTER TABLE Buyer
DISABLE CONSTRAINT pk_Buyer;

ALTER TABLE ReceivedInformation
DISABLE CONSTRAINT pk_ReceivedInformation;

ALTER TABLE Seller
DISABLE CONSTRAINT pk_Seller;

-- 外码约束
ALTER TABLE Shop
DISABLE CONSTRAINT fk_Shop;

ALTER TABLE Commodity
DISABLE CONSTRAINT fk_Commodity;

ALTER TABLE ReceivedInformation
DISABLE CONSTRAINT fk_ReceivedInformation;

ALTER TABLE Orders
DISABLE CONSTRAINT fk1_Orders;

ALTER TABLE Orders
DISABLE CONSTRAINT  fk2_Orders;

ALTER TABLE Coupon
DISABLE CONSTRAINT fk1_Coupon;

ALTER TABLE Coupon
DISABLE CONSTRAINT  fk2_Coupon;

ALTER TABLE Favorite_Product
DISABLE CONSTRAINT  fk1_Favorite_Product;

ALTER TABLE Favorite_Product
DISABLE CONSTRAINT fk2_Favorite_Product;

ALTER TABLE Add_Shopping_Cart
DISABLE CONSTRAINT fk1_Add_Shopping_Cart;

ALTER TABLE Add_Shopping_Cart
DISABLE CONSTRAINT  fk2_Add_Shopping_Cart;

ALTER TABLE  Follow_Shop
DISABLE CONSTRAINT  fk1_Follow_Shop;

ALTER TABLE  Follow_Shop
DISABLE CONSTRAINT  fk2_Follow_Shop;

ALTER TABLE Coupon_Shop
DISABLE CONSTRAINT  fk1_Coupon_Shop;

ALTER TABLE Coupon_Shop
DISABLE CONSTRAINT  fk2_Coupon_Shop;

ALTER TABLE Buyer_Coupon
DISABLE CONSTRAINT fl1_Buyer_Coupon;

ALTER TABLE Buyer_Coupon
DISABLE CONSTRAINT  fk2_Buyer_Coupon;
*/

/*-------------------- INSERT ---------------------------------*/
-- 卖家
-- 设置全局时间格式
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
 -- 验证
 /*
SELECT
  TO_CHAR( SYSDATE, 'YYYY-MM-DD' )
FROM
  dual;
*/

DELETE FROM Seller;

INSERT INTO  Seller(seller_id, phone, passwd, nickname, id_number, seller_name)
    VALUES('SE0001','15345698742','123456','干饭夏','530322200106284956','张三');

INSERT INTO  Seller(seller_id, phone, passwd, nickname, id_number, seller_name)
    VALUES('SE0002','15456698742','189456','小可爱','530322200346284956','李四');

INSERT INTO  Seller(seller_id, phone, passwd, nickname, id_number, seller_name)
    VALUES('SE0003','15545698742','023456','夏东海','530322199800106284','张吴离');

INSERT INTO  Seller(seller_id, phone, passwd, nickname, id_number, seller_name)
    VALUES('SE0004','15645698742','gg3456','章北海的星空','530322200106284956','章北海');

INSERT INTO  Seller(seller_id, phone, passwd, nickname, id_number, seller_name)
    VALUES('SE0005','15745698742','ll3456','钱钱儿','530322199700106284','洛基');
    

-- 买家
DELETE FROM Buyer;

INSERT INTO  Buyer(buyer_id, phone, passwd, nickname, gender, date_birth, id_number)
    VALUES('BU0001','15367698742','gh3456','夏天','男','1978-01-02', '530322197802081312');
    
INSERT INTO  Buyer(buyer_id, phone, passwd, nickname, gender, date_birth, id_number)
    VALUES('BU0002','15367688742','wa3456','溧水','女','1989-01-02', '530322198902081311');
    
INSERT INTO  Buyer(buyer_id, phone, passwd, nickname, gender, date_birth, id_number)
    VALUES('BU0003','15367698742','gh3456','夏天','男', '1991-01-02', '530322199102081312');
    
INSERT INTO  Buyer(buyer_id, phone, passwd, nickname, gender, date_birth, id_number)
    VALUES('BU0004','15367698742','gh3456','夏水','男', '2020-01-02', '530322187902081312');
    
INSERT INTO  Buyer(buyer_id, phone, passwd, nickname, gender, date_birth, id_number)
    VALUES('BU0005','15367698742','gh3456','夏下','男', '2020-01-02', '530322187902081312');

-- 活动
DELETE FROM Activity;

INSERT INTO  Activity(activity_id, start_time, end_time, activity_name, activity_category)
    VALUES('AC0001','2021-05-21','2021-06-01','520',1);

INSERT INTO  Activity(activity_id, start_time, end_time, activity_name, activity_category)
    VALUES('AC0002','2021-04-21','2021-05-01','大促销',2);

INSERT INTO  Activity(activity_id, start_time, end_time, activity_name, activity_category)
    VALUES('AC0003','2021-06-15','2021-06-21','618',2);

INSERT INTO  Activity(activity_id, start_time, end_time, activity_name, activity_category)
    VALUES('AC0004','2021-11-10','2021-11-12','双十一',1);

INSERT INTO  Activity(activity_id, start_time, end_time, activity_name, activity_category)
    VALUES('AC0005','2021-05-21','2021-06-01','896',2);

-- 店铺
DELETE FROM Shop;

INSERT INTO  Shop(shop_id, seller_id, shop_name, credit_score, shop_category)
    VALUES('SH0001','SE0001','同济小卖部',89,1);

INSERT INTO  Shop(shop_id, seller_id, shop_name, credit_score, shop_category)
     VALUES('SH0002','SE0002','同济嘉定食堂',12,3);
    
INSERT INTO  Shop(shop_id, seller_id, shop_name, credit_score, shop_category)
    VALUES('SH0003', 'SE0002','同济干拌面',85,5);
    
INSERT INTO  Shop(shop_id, seller_id, shop_name, credit_score, shop_category)
    VALUES ('SH0004','SE0002','袁阿姨中药铺',99,3);
    
INSERT INTO  Shop(shop_id, seller_id, shop_name, credit_score, shop_category)
    VALUES ('SH0005','SE0004','同济三只老鼠',96,2);

-- 商品集
DELETE FROM Commodity;

INSERT INTO  Commodity(commodity_id,shop_id, price, commodity_category, commodity_name, commodity_storage)
    VALUES('CO0001','SH0001',56.00,1,'华为pro 20手机壳', 589);
    
INSERT INTO  Commodity(commodity_id,shop_id, price, commodity_category, commodity_name, commodity_storage)
    VALUES('CO0002','SH0002',3156.00,1,'华为pro 20手机', 56);
    
INSERT INTO  Commodity(commodity_id,shop_id, price, commodity_category, commodity_name, commodity_storage)
    VALUES('CO0003','SH0003',560.00,1,'拍立得', 21);
    
INSERT INTO  Commodity(commodity_id,shop_id, price, commodity_category, commodity_name, commodity_storage)
    VALUES('CO0004','SH0004',123.00,1,'罗技 K480', 890);
    
INSERT INTO  Commodity(commodity_id,shop_id, price, commodity_category, commodity_name, commodity_storage)
    VALUES('CO0005','SH0001',892.00,1,'李宁 短袖', 32);

-- 买家收获信息
DELETE FROM Receivedinformation;

INSERT INTO ReceivedInformation(received_id, buyer_id, phone, receiver_name, country, province, city, district, detail_addr)
    VALUES ('RE0001', 'BU0001', '15209876453', '老王', '中国', '12', '1', '4', '同济4800号' );
    
INSERT INTO ReceivedInformation(received_id, buyer_id, phone, receiver_name, country, province, city, district, detail_addr)
    VALUES ('RE0002', 'BU0002', '16209846453', '老李', '中国', '12', '1', '4', '同济4800号' );
    
INSERT INTO ReceivedInformation(received_id, buyer_id, phone, receiver_name, country, province, city, district, detail_addr)
    VALUES ('RE0003', 'BU0003', '19209876453', '小王', '中国', '12', '1', '4', '同济4800号' );
    
INSERT INTO ReceivedInformation(received_id, buyer_id, phone, receiver_name, country, province, city, district, detail_addr)
    VALUES ('RE0004', 'BU0004', '1909876453', '老夏', '中国', '12', '1', '4', '同济4800号');
    
INSERT INTO ReceivedInformation(received_id, buyer_id, phone, receiver_name, country, province, city, district, detail_addr)
    VALUES ('RE0005', 'BU0005', '15209876453', '老金', '中国', '12', '1', '4', '同济4800号');
        
-- 订单
DELETE FROM Orders;

INSERT INTO Orders(order_id, buyer_id, received_id, shop_id, order_date, status)
    VALUES ('OR0001', 'BU0001', 'RE0001', 'SH0001', '2021-03-12', 1);

INSERT INTO Orders(order_id, buyer_id, received_id, shop_id, order_date, status)
    VALUES ('OR0002', 'BU0003', 'RE0002', 'SH0001', '2021-04-12', 2);
    
INSERT INTO Orders(order_id, buyer_id, received_id, shop_id, order_date, status)
    VALUES ('OR0003', 'BU0001', 'RE0003', 'SH0001', '2021-05-12', 3);
    
INSERT INTO Orders(order_id, buyer_id, received_id, shop_id, order_date, status)
    VALUES ('OR0004', 'BU0001', 'RE0003', 'SH0001', '2021-06-11', 1);
    
INSERT INTO Orders(order_id, buyer_id, received_id, shop_id, order_date, status)
    VALUES ('OR0005', 'BU0001', 'RE0004', 'SH0001', '2021-06-10', 2);
    
    
 -- 管理员
 DELETE FROM Administrator;
 
INSERT INTO Administrator(administrator_id, phone, passwd, nickname, id_number, admin_name)
    VALUES ('AD0001', '15647612389', 'LLF123456', '小李', '530322200403158974', '王景天');
   
INSERT INTO Administrator(administrator_id, phone, passwd, nickname, id_number, admin_name)
    VALUES ('AD0002', '15745012389', 'LLF12346', '小王', '530322200403158974', '王淏');
    
INSERT INTO Administrator(administrator_id, phone, passwd, nickname, id_number, admin_name)
    VALUES ('AD0003', '15845912389', 'LLF12356', '小张', '530322200403158974', '张天');
    
INSERT INTO Administrator(administrator_id, phone, passwd, nickname, id_number, admin_name)
    VALUES ('AD0004', '15945712389', 'LF123456', '小钱', '530322200403158974', '钱景天');
    
INSERT INTO Administrator(administrator_id, phone, passwd, nickname, id_number, admin_name)
    VALUES ('AD0005', '15145512389', 'LLF12345', '小丽', '530322200403158974', '王景丽');
    

-- 优惠券
DELETE FROM Coupon;

INSERT INTO Coupon(coupon_id, start_time, end_time, threshold, discount_1, discount_2, coupon_category, shop_id, commodity_id)
    VALUES ('CO0001','2021-06-15','2021-06-20', 20, 6, 1, 2, null, 'CO0004');

INSERT INTO Coupon(coupon_id, start_time, end_time, threshold, discount_1, discount_2, coupon_category, shop_id, commodity_id)
    VALUES ('CO0002','2021-06-15','2021-06-20', 120.00, 91.00, 1, 2, 'SH0001', null);

INSERT INTO Coupon(coupon_id, start_time, end_time, threshold, discount_1, discount_2, coupon_category, shop_id, commodity_id)
    VALUES ('CO0003','2021-06-15','2021-06-20', 100.00, 65.00, 2, 1, null, 'CO0002');

INSERT INTO Coupon(coupon_id, start_time, end_time, threshold, discount_1, discount_2, coupon_category, shop_id, commodity_id)
    VALUES ('CO0004','2021-06-15','2021-06-20', 80.00, 75.00, 1, 2, null, 'CO0003');

INSERT INTO Coupon(coupon_id, start_time, end_time, threshold, discount_1, discount_2, coupon_category, shop_id, commodity_id)
    VALUES ('CO0005','2021-06-15','2021-06-20', 90.00, 81.00, 5, 2, 'SH0003', null);

        
-- 收藏商品  
DELETE FROM favorite_product;

INSERT INTO Favorite_Product(buyer_id, commodity_id)
    VALUES ('BU0001','CO0001');
    
INSERT INTO Favorite_Product(buyer_id, commodity_id)
    VALUES ('BU0002','CO0001');

INSERT INTO Favorite_Product(buyer_id, commodity_id)
    VALUES ('BU0003','CO0001');

INSERT INTO Favorite_Product(buyer_id, commodity_id)
    VALUES ('BU0004','CO0001');

INSERT INTO Favorite_Product(buyer_id, commodity_id)
    VALUES ('BU0005','CO0001');


-- 加入购物车
DELETE FROM add_shopping_cart;

INSERT INTO Add_Shopping_Cart(buyer_id, commodity_id)
    VALUES ('BU0001','CO0001');

INSERT INTO Add_Shopping_Cart(buyer_id, commodity_id)
     VALUES ('BU0001','CO0002');

INSERT INTO Add_Shopping_Cart(buyer_id, commodity_id)
   VALUES ('BU0001','CO0003');

INSERT INTO Add_Shopping_Cart(buyer_id, commodity_id)
    VALUES ('BU0001','CO0004');

INSERT INTO Add_Shopping_Cart(buyer_id, commodity_id)
    VALUES ('BU0001','CO0005');
     
     
 -- 关注店铺
DELETE FROM follow_shop;
 
INSERT INTO Follow_Shop(buyer_id, shop_id)
    VALUES ('BU0001', 'SH0001');
    
INSERT INTO Follow_Shop(buyer_id, shop_id)
    VALUES ('BU0002', 'SH0002');
   
INSERT INTO Follow_Shop(buyer_id, shop_id)
    VALUES ('BU0003', 'SH0004');
   
INSERT INTO Follow_Shop(buyer_id, shop_id)
    VALUES ('BU0004', 'SH0005');
   
INSERT INTO Follow_Shop(buyer_id, shop_id)
    VALUES ('BU0005', 'SH0001');
   
-- 店铺关联优惠券
DELETE FROM coupon_shop;

INSERT INTO Coupon_Shop(coupon_id, shop_id, amount)
    VALUES ('CO0001','SH0001',5);

INSERT INTO Coupon_Shop(coupon_id, shop_id, amount)
    VALUES ('CO0002','SH0002',10);
    
INSERT INTO Coupon_Shop(coupon_id, shop_id, amount)
    VALUES ('CO0002','SH0001',96);
    
INSERT INTO Coupon_Shop(coupon_id, shop_id, amount)
    VALUES ('CO0004','SH0003',5);
    
INSERT INTO Coupon_Shop(coupon_id, shop_id, amount)
    VALUES ('CO0005','SH0005',78);
    
-- 买家拥有优惠券
DELETE FROM buyer_coupon;

INSERT INTO Buyer_Coupon(buyer_id, coupon_id, amount)
    VALUES ('BU0001', 'CO0002', 4);
    
INSERT INTO Buyer_Coupon(buyer_id, coupon_id, amount)
    VALUES ('BU0002', 'CO0003', 5);
    
INSERT INTO Buyer_Coupon(buyer_id, coupon_id, amount)
    VALUES ('BU0003', 'CO0004',6);
    
INSERT INTO Buyer_Coupon(buyer_id, coupon_id, amount)
    VALUES ('BU0004', 'CO0002', 5);
    
INSERT INTO Buyer_Coupon(buyer_id, coupon_id, amount)
    VALUES ('BU0005', 'CO0001', 8);

/*------------------------ 启动约束 --------------------------*/
-- 主码约束
/*
ALTER TABLE Activity
ENABLE CONSTRAINT pk_Activity;

ALTER TABLE Administractor
ENABLE CONSTRAINT pk_Admin;

ALTER TABLE Buyer
ENABLE CONSTRAINT pk_Buyer;

ALTER TABLE ReceivedInformation
ENABLE CONSTRAINT pk_ReceivedInformation;

ALTER TABLE Seller
ENABLE CONSTRAINT pk_Seller;

-- 外码约束
ALTER TABLE Shop
ENABLE CONSTRAINT fk_Shop;

ALTER TABLE Commodity
ENABLE CONSTRAINT fk_Commodity;

ALTER TABLE ReceivedInformation
ENABLE CONSTRAINT fk_ReceivedInformation;

ALTER TABLE Orders
ENABLE CONSTRAINT fk1_Orders;

ALTER TABLE Orders
ENABLE CONSTRAINT  fk2_Orders;

ALTER TABLE Coupon
ENABLE CONSTRAINT fk1_Coupon;

ALTER TABLE Coupon
ENABLE CONSTRAINT  fk2_Coupon;

ALTER TABLE Favorite_Product
ENABLE CONSTRAINT  fk1_Favorite_Product;

ALTER TABLE Favorite_Product
ENABLE CONSTRAINT fk2_Favorite_Product;

ALTER TABLE Add_Shopping_Cart
ENABLE CONSTRAINT fk1_Add_Shopping_Cart;

ALTER TABLE Add_Shopping_Cart
ENABLE CONSTRAINT  fk2_Add_Shopping_Cart;

ALTER TABLE  Follow_Shop
ENABLE CONSTRAINT  fk1_Follow_Shop;

ALTER TABLE  Follow_Shop
ENABLE CONSTRAINT  fk2_Follow_Shop;

ALTER TABLE Coupon_Shop
ENABLE CONSTRAINT  fk1_Coupon_Shop;

ALTER TABLE Coupon_Shop
ENABLE CONSTRAINT  fk2_Coupon_Shop;

ALTER TABLE Buyer_Coupon
ENABLE CONSTRAINT fl1_Buyer_Coupon;

ALTER TABLE Buyer_Coupon
ENABLE CONSTRAINT  fk2_Buyer_Coupon;
*/












