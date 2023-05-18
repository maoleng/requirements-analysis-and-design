CREATE TABLE "Admin" (
	"id" BIGINT NOT NULL,
	"name" NVARCHAR(255) NOT NULL,
	"is_admin_master" BINARY NOT NULL,
	"email" NVARCHAR(255) NOT NULL,
	"password" NVARCHAR(255) NOT NULL,
	"active" BINARY NOT NULL DEFAULT '''1''',
	"created_at" DATETIME2(0) NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE "User" (
	"id" BIGINT NOT NULL,
	"name" NVARCHAR(255) NOT NULL,
	"phone" NVARCHAR(255) NULL DEFAULT NULL,
	"email" NVARCHAR(255) NOT NULL,
	"address" NVARCHAR(255) NULL DEFAULT NULL,
	"password" NVARCHAR(255) NULL DEFAULT NULL,
	"is_agent" BINARY NOT NULL,
	"active" BINARY NOT NULL DEFAULT '''1''',
	"created_at" DATETIME2(0) NOT NULL,
	PRIMARY KEY ("id")
);
CREATE TABLE "Order" (
	"id" BIGINT NOT NULL,
	"name" NVARCHAR(255) NULL DEFAULT NULL,
	"address" NVARCHAR(255) NULL DEFAULT NULL,
	"email" NVARCHAR(255) NULL DEFAULT NULL,
	"phone" NVARCHAR(255) NULL DEFAULT NULL,
	"status" INT NOT NULL,
	"is_paid" BINARY NOT NULL DEFAULT '''0''',
	"ship_fee" FLOAT NOT NULL DEFAULT '''0''',
	"product_price" FLOAT NOT NULL,
	"ship_price" FLOAT NOT NULL DEFAULT '''0''',
	"user_id" BIGINT NULL DEFAULT NULL,
	"admin_id" BIGINT NULL DEFAULT NULL,
	"bank_code" NVARCHAR(255) NULL DEFAULT NULL,
	"transaction_code" NVARCHAR(255) NULL DEFAULT NULL,
	"created_at" DATETIME2(0) NOT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY,
	FOREIGN KEY,
	CONSTRAINT "order_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "User" ("id") ON UPDATE NO_ACTION ON DELETE NO_ACTION,
	CONSTRAINT "order_admin_id_foreign" FOREIGN KEY ("admin_id") REFERENCES "Admin" ("id") ON UPDATE NO_ACTION ON DELETE NO_ACTION
);

CREATE TABLE "Product" (
	"id" BIGINT NOT NULL,
	"category" INT NOT NULL,
	"name" NVARCHAR(255) NOT NULL,
	"price" FLOAT NOT NULL,
	"description" NVARCHAR(max) NOT NULL,
	"image" NVARCHAR(255) NOT NULL,
	"created_at" DATETIME2(0) NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE "OrderProduct" (
	"order_id" BIGINT NOT NULL,
	"product_id" BIGINT NOT NULL,
	"name" NVARCHAR(255) NOT NULL,
	"amount" INT NOT NULL,
	"price" FLOAT NOT NULL,
	"discount_price" FLOAT NOT NULL DEFAULT '''0''',
	"original_price" FLOAT NOT NULL,
	FOREIGN KEY,
	FOREIGN KEY,
	PRIMARY KEY ("order_id", "product_id"),
	CONSTRAINT "orderproduct_product_id_foreign" FOREIGN KEY ("product_id") REFERENCES "Product" ("id") ON UPDATE NO_ACTION ON DELETE NO_ACTION,
	CONSTRAINT "orderproduct_order_id_foreign" FOREIGN KEY ("order_id") REFERENCES "Order" ("id") ON UPDATE NO_ACTION ON DELETE NO_ACTION
);

CREATE INDEX "orderproduct_order_id_foreign" ON "OrderProduct" ("order_id");
CREATE INDEX "orderproduct_product_id_foreign" ON "OrderProduct" ("product_id");
