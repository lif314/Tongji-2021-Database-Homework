 
-- 卖家
CREATE TABLE Seller (
        seller_id VARCHAR2(6) NOT NULL,
        phone CHAR(11) NOT NULL, 
        passwd VARCHAR2(18) NOT NULL,
        nickname VARCHAR2(30) NOT NULL,
        id_number CHAR(18) NOT NULL,
        seller_name VARCHAR2(30) NOT NULL,
        CONSTRAINT pk_Seller PRIMARY KEY (seller_id)
        );
        
        
 -- 买家
CREATE TABLE Buyer (
        buyer_id VARCHAR2(6) NOT NULL, 
        phone Char(11) NOT NULL, 
        passwd VARCHAR2(18) NOT NULL,
        nickname VARCHAR2(30) NOT NULL,
        gender NUMBER(1) NOT NULL,
        date_birth DATE NOT NULL, 
        id_number CHAR(18) NOT NULL,
        CONSTRAINT pk_Buyer PRIMARY KEY (buyer_id)
        );

 
-- 活动
CREATE TABLE Activity (
        activity_id VARCHAR2(6) NOT NULL,
        start_time DATE NOT NULL,
        end_time DATE NOT NULL, 
        activity_name VARCHAR2(30) NOT NULL,
        activity_category  NUMBER(2) NOT NULL,
        CONSTRAINT pk_Activity PRIMARY KEY (activity_id)
        );


-- 店铺
CREATE TABLE Shop (
        shop_id VARCHAR2(6) NOT NULL,
        seller_id VARCHAR2(6) NOT NULL,
        shop_name VARCHAR2(30) NOT NULL,
        credit_score  NUMBER(2) NOT NULL,
        shop_category  NUMBER(2) NOT NULL,
        CONSTRAINT pk_Shop PRIMARY KEY (shop_id),
        CONSTRAINT fk_Shop FOREIGN KEY (seller_id)
                REFERENCES Seller(seller_id)
        );
        
     
-- 商品集
CREATE TABLE Commodity (
        commodity_id VARCHAR2(6) NOT NULL,
        price   NUMBER(11,2) NOT NULL,
        commodity_category  NUMBER(6) NOT NULL,
        commodity_storage  NUMBER(6) NOT NULL,
        commodity_name   VARCHAR2(30) NOT NULL,
        shop_id  VARCHAR2(6) NOT NULL,
        CONSTRAINT pk_Commodity PRIMARY KEY (commodity_id),
        CONSTRAINT fk_Commodity FOREIGN KEY (shop_id) 
                REFERENCES Shop(shop_id)
        );
   
-- 买家收获信息
CREATE TABLE ReceivedInformation (
        received_id VARCHAR2(6) NOT NULL,
        buyer_id VARCHAR2(6) NOT NULL, 
        phone CHAR(11) NOT NULL,
        receiver_name VARCHAR2(30) NOT NULL,
        country VARCHAR2(3) NOT NULL,
        province CHAR(2) NOT NULL,
        city CHAR(2) NOT NULL,
        district CHAR(2) NOT  NULL,
        detail_addr VARCHAR2(30) NOT NULL,
        CONSTRAINT pk_ReceivedInformation PRIMARY KEY (received_id),
        CONSTRAINT fk_ReceivedInformation FOREIGN KEY (buyer_id)
            REFERENCES Buyer(buyer_id)
        );
           
-- 订单
CREATE TABLE Orders (
        order_id VARCHAR2(6) NOT NULL,
        buyer_id VARCHAR2(6) NOT NULL,
        received_id VARCHAR2(6) NOT NULL,
        shop_id VARCHAR2(6) NOT NULL,
        order_date DATE NOT NULL,
        status  NUMBER(1) NOT NULL,
        CONSTRAINT pk_Orders PRIMARY  KEY  (order_id),
        CONSTRAINT fk1_Orders FOREIGN KEY(received_id)
                REFERENCES ReceivedInformation(received_id),
        CONSTRAINT fk2_Orders FOREIGN KEY (shop_id)
                 REFERENCES Shop(shop_id)
        );


 -- 管理员
CREATE TABLE Administrator (
        administrator_id VARCHAR2(6) NOT NULL,
        phone CHAR(11) NOT NULL,
        passwd VARCHAR2(18) NOT NULL,
        nickname VARCHAR2(30) NOT NULL,
        id_number CHAR(18) NOT NULL,
        admin_name VARCHAR2(30) NOT NULL,
        CONSTRAINT pk_Admin PRIMARY KEY (administrator_id)
        );
 

-- 优惠券
CREATE TABLE Coupon (
        coupon_id VARCHAR2(6) NOT NULL,
        start_time DATE NULL,
        end_time DATE NOT NULL,
        threshold  NUMBER(11,2) NOT NULL,
        discount_1  NUMBER(11,2) DEFAULT (0),
        discount_2  NUMBER(2,2) DEFAULT (0),
        coupon_category NUMBER(2) NOT NULL,
        shop_id VARCHAR2(6),
        commodity_id VARCHAR2(6),
        CONSTRAINT pk_Coupon PRIMARY KEY (coupon_id),
        CONSTRAINT fk1_Coupon FOREIGN KEY(commodity_id)
                REFERENCES Commodity(commodity_id),
        CONSTRAINT fk2_Coupon FOREIGN KEY (shop_id)
                 REFERENCES Shop(shop_id)
        );
        
-- 收藏商品    
 CREATE TABLE Favorite_Product (
        buyer_id VARCHAR(6) NOT NULL,
        commodity_id VARCHAR(6) NOT NULL,
        CONSTRAINT pk_Favorite_Product PRIMARY KEY (buyer_id, commodity_id),
        CONSTRAINT fk1_Favorite_Product FOREIGN KEY(buyer_id)
                REFERENCES Buyer(buyer_id),
        CONSTRAINT fk2_Favorite_Product FOREIGN KEY (commodity_id)
                 REFERENCES Commodity(commodity_id)
        );

-- 加入购物车
CREATE TABLE Add_Shopping_Cart (
        buyer_id VARCHAR2(6) NOT NULL,
        commodity_id VARCHAR2(6) NOT  NULL,
        CONSTRAINT pk_Shopping_Cart PRIMARY KEY (buyer_id, commodity_id),
        CONSTRAINT fk1_Add_Shopping_Cart FOREIGN KEY(buyer_id)
                REFERENCES Buyer(buyer_id),
        CONSTRAINT fk2_Add_Shopping_Cart FOREIGN KEY (commodity_id)
                 REFERENCES Commodity(commodity_id)
        );
        

 -- 关注店铺
CREATE TABLE Follow_Shop (
        buyer_id VARCHAR2(6) NOT NULL, 
        shop_id VARCHAR2(6) NOT NULL,
        CONSTRAINT pk_Follow_Shop PRIMARY KEY (buyer_id, shop_id),
        CONSTRAINT fk1_Follow_Shop FOREIGN KEY(buyer_id)
                REFERENCES Buyer(buyer_id),
        CONSTRAINT fk2_Follow_Shop FOREIGN KEY (shop_id)
                 REFERENCES Shop(shop_id)
        );


-- 店铺关联优惠券
CREATE TABLE Coupon_Shop ( 
        coupon_id VARCHAR2(6) NOT NULL, 
        shop_id VARCHAR2(6) NOT NULL, 
        amount NUMBER(9) NOT NULL,
        CONSTRAINT pk_Coupon_Shop PRIMARY KEY (coupon_id, shop_id),
        CONSTRAINT fk1_Coupon_Shop FOREIGN KEY(coupon_id)
                REFERENCES Coupon(coupon_id),
        CONSTRAINT fk2_Coupon_Shop FOREIGN KEY (shop_id)
                 REFERENCES Shop(shop_id)
        );

-- 买家拥有优惠券
CREATE TABLE Buyer_Coupon ( 
        buyer_id VARCHAR2(6) NOT NULL, 
        coupon_id VARCHAR2(6) NOT NULL,
        amount NUMBER(9) NOT NULL,
        CONSTRAINT pk_Buyer_Coupon PRIMARY KEY (buyer_id, coupon_id),
        CONSTRAINT fk1_Buyer_Coupon FOREIGN KEY (buyer_id)
                REFERENCES Buyer(buyer_id),
        CONSTRAINT fk2_Buyer_Coupon FOREIGN KEY (coupon_id)
                 REFERENCES Coupon(coupon_id)
        );



