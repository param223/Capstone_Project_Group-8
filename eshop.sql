-- Table: public.cart

-- DROP TABLE IF EXISTS public.cart;

CREATE TABLE IF NOT EXISTS public.cart
(
    user_id bigint NOT NULL,
    CONSTRAINT cart_pkey1 PRIMARY KEY (user_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cart
    OWNER to postgres;
	
----------------------------------------------------

-- Table: public.discount

-- DROP TABLE IF EXISTS public.discount;

CREATE TABLE IF NOT EXISTS public.discount
(
    id character varying COLLATE pg_catalog."default" NOT NULL,
    status bigint,
    CONSTRAINT discount_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.discount
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.order_main

-- DROP TABLE IF EXISTS public.order_main;

CREATE TABLE IF NOT EXISTS public.order_main
(
    order_id bigint NOT NULL,
    buyer_address character varying(255) COLLATE pg_catalog."default",
    buyer_email character varying(255) COLLATE pg_catalog."default",
    buyer_name character varying(255) COLLATE pg_catalog."default",
    buyer_phone character varying(255) COLLATE pg_catalog."default",
    create_time timestamp without time zone,
    order_amount numeric(19,2) NOT NULL,
    order_status integer NOT NULL DEFAULT 0,
    update_time timestamp without time zone,
    CONSTRAINT order_main_pkey PRIMARY KEY (order_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_main
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.product_category

-- DROP TABLE IF EXISTS public.product_category;

CREATE TABLE IF NOT EXISTS public.product_category
(
    category_id integer NOT NULL,
    category_name character varying(255) COLLATE pg_catalog."default",
    category_type integer,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id),
    CONSTRAINT uk_6kq6iveuim6wd90cxo5bksumw UNIQUE (category_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_category
    OWNER to postgres;
	
--------------------------------------------------------

-- Table: public.product_in_order

-- DROP TABLE IF EXISTS public.product_in_order;

CREATE TABLE IF NOT EXISTS public.product_in_order
(
    id bigint NOT NULL,
    category_type integer NOT NULL,
    count integer,
    product_description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_id character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default",
    product_price numeric(19,2) NOT NULL,
    product_stock integer,
    cart_user_id bigint,
    order_id bigint,
    CONSTRAINT product_in_order_pkey PRIMARY KEY (id),
    CONSTRAINT fkt0sfj3ffasrift1c4lv3ra85e FOREIGN KEY (order_id)
        REFERENCES public.order_main (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_cart_fkey FOREIGN KEY (cart_user_id)
        REFERENCES public.cart (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT product_in_order_count_check CHECK (count >= 1),
    CONSTRAINT product_in_order_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_in_order
    OWNER to postgres;
	
------------------------------------------------------------

-- Table: public.product_info

-- DROP TABLE IF EXISTS public.product_info;

CREATE TABLE IF NOT EXISTS public.product_info
(
    product_id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    category_type integer DEFAULT 0,
    create_time timestamp without time zone,
    product_description character varying(255) COLLATE pg_catalog."default",
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_price numeric(19,2) NOT NULL,
    product_status integer DEFAULT 0,
    product_stock integer NOT NULL,
    update_time timestamp without time zone,
    CONSTRAINT product_info_pkey PRIMARY KEY (product_id),
    CONSTRAINT product_info_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_info
    OWNER to postgres;
	
-----------------------------------------------------------------

-- Table: public.tokens

-- DROP TABLE IF EXISTS public.tokens;

CREATE TABLE IF NOT EXISTS public.tokens
(
    id integer NOT NULL DEFAULT nextval('tokens_id_seq'::regclass),
    created_date timestamp without time zone,
    token character varying(255) COLLATE pg_catalog."default",
    user_id bigint NOT NULL,
    CONSTRAINT tokens_pkey PRIMARY KEY (id),
    CONSTRAINT fk2dylsfo39lgjyqml2tbe0b0ss FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tokens
    OWNER to postgres;
	
--------------------------------------------------------------------------

-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    id bigint NOT NULL,
    active boolean NOT NULL,
    address character varying(255) COLLATE pg_catalog."default",
    email character varying(255) COLLATE pg_catalog."default",
    name character varying(255) COLLATE pg_catalog."default",
    password character varying(255) COLLATE pg_catalog."default",
    phone character varying(255) COLLATE pg_catalog."default",
    role character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uk_sx468g52bpetvlad2j9y0lptc UNIQUE (email)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;
	
---------------------------------------------------------------------------

-- Table: public.wishlist

-- DROP TABLE IF EXISTS public.wishlist;

CREATE TABLE IF NOT EXISTS public.wishlist
(
    id bigint NOT NULL,
    created_date timestamp without time zone,
    user_id bigint,
    product_id character varying COLLATE pg_catalog."default",
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT product_wish_fkey FOREIGN KEY (product_id)
        REFERENCES public.product_info (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "user_wish_Fkey" FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.wishlist
    OWNER to postgres;
	
---------------------------------------------------------------------------------------------------






--Product_Info


INSERT INTO "public"."product_category" VALUES (2147483641, 'Lightning', 0, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483642, 'Bad & Mattresses', 1, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483643, 'Furniture', 2, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483644, 'Garden', 3, '2022-06-23 23:03:26', '2022-06-23 23:03:26');


--Product

INSERT INTO "public"."product_info" VALUES ('IF001', 0, '2022-06-23 23:03:26', '45039 Muscari Table Lamp Led Aluminium 1', 'https://ii1.pepperfry.com/media/catalog/product/4/5/800x880/45039-muscari-table-lamp-led-aluminium-1-45039-muscari-table-lamp-led-aluminium-1-kuhind.jpg', 'Smart Lamp', 12000.00, 0, 15, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF002', 0, '2022-06-23 23:03:26', 'Amoeba Led Smart Voice Assist Wall Lamp', 'https://ii1.pepperfry.com/media/catalog/product/a/m/800x880/amoeba-black-metal-led-wall-light-by-smartway-lighting-amoeba-black-metal-led-wall-light-by-smartway-8zhukt.jpg',  'Wall Lamp', 15000.00, 0, 12, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF003', 0, '2022-06-23 23:03:26', 'Stellar Black LED Smart Voice Assist Chandelier', 'https://ii1.pepperfry.com/media/catalog/product/s/t/800x880/stellar-black-led-smart-voice-assist-chandelier-by-smartway-lighting-stellar-black-led-smart-voice-a-qan3ni.jpg', 'Chandelier', 20000.00, 0, 25, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF004', 0, '2022-06-23 23:03:26', 'Light House Table Lamp In Brown Colour', 'https://ii1.pepperfry.com/media/catalog/product/l/i/800x880/light-house-kids-table-lamp-in-brown-colour-by-lycka-light-house-kids-table-lamp-in-brown-colour-by--djwi2k.jpg', 'Kids Lamp', 2000.00, 0, 8, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('WS001', 1, '2022-06-23 23:03:26', 'Turner Single Bed in Dark Oak Finish', 'https://ii1.pepperfry.com/media/catalog/product/t/u/494x544/turner-single-bed-in-dark-oak-finish-by-durian-turner-single-bed-in-dark-oak-finish-by-durian-wfmn6b.jpg', 'Single Bed', 29000.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS002', 1, '2022-06-23 23:03:26', 'Vayaka Solid Wood King Size Poster Bed In Rustic Teak Finish', 'https://ii1.pepperfry.com/media/catalog/product/v/a/494x544/vayaka-solid-wood-poster-bed-in-rustic-teak-finish-by-mudramark-vayaka-solid-wood-poster-bed-in-rust-pfx7a0.jpg', 'Poster Bed', 88000.00, 0, 22, '2022-06-23 22:03:26');
INSERT INTO "public"."product_info" VALUES ('WS003', 1, '2022-06-23 23:03:26', 'Microfiber 120 GSM AC Room Double Bed Comforter Rumba', 'https://ii1.pepperfry.com/media/catalog/product/m/i/800x880/microfiber-120-gsm-ac-room-double-bed-comforter-rumba-by-bianca-microfiber-120-gsm-ac-room-double-be-zvurlb.jpg', 'Double Bed Quilts & Comforter', 1500.00, 0, 22, '2022-06-23 22:03:26');
INSERT INTO "public"."product_info" VALUES ('WS004', 1, '2022-06-23 23:03:26', 'Orthopedic HR Foam 6 Inch King Size Mattress', 'https://ii1.pepperfry.com/media/catalog/product/s/p/800x880/spincure-6-inch-othopedic-hr-foam-king-size-mattress-spincure-6-inch-othopedic-hr-foam-king-size-mat-hvpp59.jpg', 'King Size Matreess', 8000.00, 0, 22, '2022-06-23 22:03:26');

INSERT INTO "public"."product_info" VALUES ('PA001', 2, '2022-06-23 23:03:26', 'Segur Solid Wood Coffee Table In Honey Oak Finish', 'https://ii2.pepperfry.com/media/catalog/product/s/e/494x544/segur-solid-wood-coffee-table-in-honey-oak-finish-by-woodsworth-segur-solid-wood-coffee-table-in-hon-oix8lh.jpg', 'Sqaure Table ', 26800.00, 0, 45, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA002', 2, '2022-06-23 23:03:26', 'Avian Solid Wood Nest Of Tables In Honey Oak Finish', 'https://ii2.pepperfry.com/media/catalog/product/a/v/494x544/avian-solid-wood-nest-of-tables-in-honey-oak-finish---woodsworth-by-pepperfry-avian-solid-wood-nest--swyh50.jpg', 'Contemporary Furniture', 7500.00, 0, 45, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA003', 2, '2022-06-23 23:03:26', 'Alexa 4 Seater Foldable Dining Table In Black Finish', 'https://ii1.pepperfry.com/media/catalog/product/a/l/494x544/alexa-4-seater-foldable-dining-table-in-black-finish-by-fine-group-alexa-4-seater-foldable-dining-ta-sjtvqs.jpg', 'Dining Table', 1200.00, 0, 45, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA004', 2, '2022-06-23 23:03:26', 'Metalico Nesting Table (Set Of 2) In Natural Finish', 'https://ii1.pepperfry.com/media/catalog/product/m/e/494x544/metalico-nesting-table--set-of-2--in-natural-finish---bohemiana-by-pepperfry-metalico-nesting-table--e8x3b6.jpg', 'Industrial Furniture', 7000.00, 0, 45, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('AF001', 3, '2022-06-23 23:03:26', 'Grey Iron Round Hanging with Home Text Hanging Planter', 'https://ii1.pepperfry.com/media/catalog/product/g/r/800x880/grey-iron-round-hanging-with-home-text-hanging-planter-by-justoriginals-grey-iron-round-hanging-with-539m0j.jpg', 'Hanging Planter', 600.00, 0, 39, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF002', 3, '2022-06-23 23:03:26', 'Gold Iron Desk Pot Planter', 'https://ii1.pepperfry.com/media/catalog/product/g/o/800x880/gold-iron-desk-pot-planter-by-healthchoice-gold-iron-desk-pot-planter-by-healthchoice-mggbp9.jpg', 'Desk Pot', 190.00, 0, 39, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF003', 3, '2022-06-23 23:03:26', 'Orange Metal Round Hut Bird House', 'https://ii1.pepperfry.com/media/catalog/product/o/r/800x880/orange-metal-round-hut-bird-house-by-green-girgit-orange-metal-round-hut-bird-house-by-green-girgit-oaybjs.jpg', 'Bird House', 400.00, 0, 39, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF004', 3, '2022-06-23 23:03:26', 'Sicilian grey Polymer Fabi Wide Floor Planter', 'https://ii1.pepperfry.com/media/catalog/product/s/i/800x880/sicilian-grey-polymer-fabi-wide-floor-planter-by-planters-sicilian-grey-polymer-fabi-wide-floor-plan-8z6nzp.jpg', 'Floor Planter', 1500.00, 0, 39, '2022-06-23 23:03:26');

--Users

INSERT INTO "public"."users" VALUES (2147483645, true, 'Plot 2, Shivaji Nagar, Benagluru', 'admin@eshop.com', 'Admin', '$2a$10$LiBwO43TpKU0sZgCxNkWJueq2lqxoUBsX2Wclzk8JQ3Ejb9MWu2Xy', '1234567890', 'ROLE_MANAGER');

CREATE SEQUENCE IF NOT EXISTS public.hibernate_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.hibernate_sequence
    OWNER TO postgres;